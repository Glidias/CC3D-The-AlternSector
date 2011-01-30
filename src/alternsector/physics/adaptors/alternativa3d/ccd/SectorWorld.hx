package alternsector.physics.adaptors.alternativa3d.ccd;
import flash.errors.Error;
import flash.utils.Dictionary;
import flash.Vector;
import portal.Sector;

/**
 * ...
 * @author Glenn Ko
 */

class SectorWorld implements ICC3DWorld
{
	var _awakeSectors:SectorPhysics;
	var _sleepingSectors:Vector<SectorPhysics>;
	var _sleepCount:Int;
	
	static inline var MAX_ITERATIONS:Int = 100;
	static inline var MS:Float = 1 / 1000;
	private var _traceError:Error;
	public function getTraceError():Error {
		var err:Error = _traceError;
		if (_traceError != null) _traceError = null;
		return err;
	}
	
	public function new(sleepBufferSize:Int = 64) 
	{
		_sleepCount = 0;
		_sleepingSectors = new Vector<SectorPhysics>(sleepBufferSize, true);
	}
	
	public function update(dtms:Int):Void {
		//delta time in milliseconds
		var doSleep:Bool;
		var doDispose:Bool;
        
        //delta time in seconds
        var elapsed:Float = dtms * (1/1000);
                
        var iteration:Int = 0;
		var sector:SectorPhysics;
		var nextSector:SectorPhysics;
		var tailSector:SectorPhysics;
	
		
		// Wake all sectors by default at the moment
		while (_sleepCount > 0) {
			sector = _sleepingSectors[--_sleepCount];
			if (sector.sleepId < 0) throw new Error("ALREADY waken!");
			//_sleepingSectors[_sleepCount] = null;
			sector.sleepId = -1;
			sector.next = _awakeSectors;
			_awakeSectors = sector;
		}
		
		// Notify delta times for sectors
		sector = _awakeSectors;
		while (sector!=null) {
			sector._notifyWake(elapsed);
			sector = sector.next;
		}
		
		// Begin iterative loop
		while ( _awakeSectors != null ) {
			
			//start by trying to step over the entire remainder
			sector = _awakeSectors;
			while (sector!=null) {
				sector.doCoarsePhase();
				sector = sector.next;
			}
			
			sector = _awakeSectors;
			tailSector = null;
			while (sector!=null) {
				nextSector = sector.next;
				sector.findClosestPair();  // this shuold be seprated out to middle phase i think..
				sector.integrateResolve();
				
				doSleep = false;
				doDispose = false;
				if ( (doSleep = sector._remainingTime <= 0 ) ) { //||  (doDispose = sector.ccCount == 0)
				//	if (sector._remainingTime < 0) throw new Error("wHEN LOWER!");
					// truncate from awake sectors list.
					if ( tailSector != null ) {  
						tailSector.next = nextSector;
					}
					else {
						_awakeSectors = nextSector;
					}
					
					if (doSleep) {
						sleepSector(sector);
						sector.next  = null;
					}
					else {  // dispose back to pool
						throw new Error("THIs should not happen as of yet!");
						sector.dispose();
					}
					
					sector = nextSector;
					continue;
				}
				
				tailSector = sector;
				sector = nextSector;
			}
			
			
			iteration++;
			if (iteration > MAX_ITERATIONS) {
				_traceError = new Error("ERROR: MAx iterations reached!:"+tailSector._remainingTime + " left from: "+elapsed+ ", +=" +tailSector.getDeltaTime() );
				break;
			}
		}
		

	}

	
	/* INTERFACE alternsector.physics.adaptors.alternativa3d.ccd.ICC3DWorld */
	
	public function addCC3D(cc:CC3D):Void 
	{
		var sector:Sector = cc.sector;
		var sectorPhysics:SectorPhysics;
	
		if (sector.physics != null) {
			sectorPhysics = sector.physics;
			/*  // toconsider: only wake on add
			if (sectorPhysics.sleepId >=0) {
				_wakeSector(sectorPhysics);
			}
			*/
		}
		else {
			sectorPhysics = SectorPhysics.Create(sector);
			sectorPhysics.next = _awakeSectors;
			_awakeSectors = sectorPhysics;
			
		}
	
		sectorPhysics.addChild(cc);
	}
	


	inline function _wakeSector(sectorPhysics:SectorPhysics):Void {
		var tailIndex:Int = _sleepCount -1;
		if (sectorPhysics.sleepId < 0) throw new Error("Sector isn't sleeping!");
		var secPhysics2:SectorPhysics;
		if (sectorPhysics.sleepId != tailIndex) {
			secPhysics2 = _sleepingSectors[tailIndex];
			secPhysics2.sleepId = sectorPhysics.sleepId;
			_sleepingSectors[secPhysics2.sleepId] = secPhysics2;
			_sleepingSectors[tailIndex] = null; 
		}
		else {  // pop
			_sleepingSectors[sectorPhysics.sleepId] = null;
		}
		
		_sleepCount--;
		sectorPhysics.sleepId = -1;
		
		sectorPhysics.next = _awakeSectors;
		_awakeSectors = sectorPhysics;
	}
	
	inline function sleepSector(sectorPhysics:SectorPhysics):Void {
		#if debug
		if (sectorPhysics.sleepId < 0) throw new Error("Already slept based on sleep ID!:" + sectorPhysics.sleepId);
		#end
		
		sectorPhysics.sleepId = _sleepCount;
		_sleepingSectors[_sleepCount++] = sectorPhysics;
	
		
	}

		
	public function removeCC3D(cc:CC3D):Void 
	{
		var sectorNode:SectorPhysics = cc.sector.physics;
		sectorNode.removeChild(cc);
		if (sectorNode.ccCount == 0) {  // empty cc3d lists
			// remove from sector collision list.
			sectorNode.dispose();
		}
	}
	


	
}