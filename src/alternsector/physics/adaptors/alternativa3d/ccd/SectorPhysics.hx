package alternsector.physics.adaptors.alternativa3d.ccd;
import alternativa.engine3d.core.EllipsoidCollider;
import alternsector.math.PMath;
import alternsector.physics.adaptors.alternativa3d.ccd.CC3D;
import alternsector.physics.adaptors.utils.Vector3DUtils;
import flash.errors.Error;
import flash.geom.Vector3D;

import portal.Sector;

/**
 * ...
 * @author Glenn Ko
 */

class SectorPhysics 
{
	static public inline var EPSILON:Float = 1e-8;
	public var sector:Sector;
		
	public var wakeA:CC3DList;
	public var wakeB:CC3DList;
	public var sleepA:CC3DList;
	public var sleepB:CC3DList;
	
	public var sleepId:Int;
	public var ccCount:Int;
	
	public var staticPairList:CC3DPair;
	public var minPair:CC3DPair;
	public var pairList:CC3DPair;
	var _lastPair:CC3DPair;
	
	// Pooling and linked list
	public static var collector:SectorPhysics;
	public var next:SectorPhysics;
	
	var _deltaTime:Float;
	public var _remainingTime:Float;
	var _collisionTable:CollisionTable;

	public function new() 
	{
		
	}
	
	inline public function findClosestPair():Void 
	{
		var pair:CC3DPair;
		var minT:Float = _remainingTime; 
		
		minPair = null;
		
		pair = staticPairList;
		while (pair != null) {
			if (pair.t < minT ) {
				minPair = pair;
				minT = pair.t;
				
			}
			pair = pair.next;
		}
		
		pair = pairList;
		while (pair != null) {
			if (pair.willCollide(_remainingTime) && pair.t < minT) {
				minPair = pair;
				minT = pair.t;
			}
			_lastPair = pair;
			pair = pair.next;
		}
		
		_deltaTime = minT;
	}
	
	
	inline function _init(sec:Sector):Void {
		wakeA = new CC3DList();
		wakeB = new CC3DList();
		sleepA = new CC3DList();
		sleepB = new CC3DList();
		_reset();
		sector = sec;
		_collisionTable = CollisionTable.Get();
		sec.physics = this;
	}
	
	inline function _reset():Void {

		_deltaTime = 0;
		ccCount = 0;
		sleepId = -1;
	}
	
	
	public function integrateResolve():Void 
	{
		if (minPair != null) {
			minPair.c1.staticCollision = null;  // flag as null before integrate
		}
		var deferedCollection:CC3DPair = _integrate();  
		
		if (minPair != null) {  // repeated check is done...which is stupid, bah.
			minPair.resolve();
		}
		
		var nextPair:CC3DPair;
		if (_lastPair != null) {
			_lastPair.next = deferedCollection;
			deferedCollection = pairList;
		}
		//else if (pairList != null) throw new Error("Still have pairlist to cleanup!");
		
		while (deferedCollection != null) {
			nextPair = deferedCollection.next;
			deferedCollection.destroy();
			deferedCollection = nextPair;
		}
		_lastPair = null;
		pairList = null;
		
	}
	
	inline function _integrate():CC3DPair {
		var pair:CC3DPair = this.staticPairList;

		_remainingTime -= _deltaTime;
		
		var nextPair:CC3DPair;
		var deferedCollection:CC3DPair = null;
		var lastPair:CC3DPair = null;
		while (pair != null) {
			nextPair = pair.next;
			
			if (pair.c1.staticCollision == null) {  // flagged as null, so need to remove
				if (lastPair != null) lastPair.next = nextPair;
				else {
					this.staticPairList = nextPair;
				}
				//defer destruction before resolve
				pair.next = deferedCollection;
				deferedCollection = pair;
				
				pair = nextPair;
				continue;
			}
			pair.t -= _deltaTime;
		
			lastPair = pair;
			pair = nextPair;
			
		}
		
		var dt:Float = _deltaTime - EPSILON;
		wakeA._integrate(dt);
		wakeB._integrate(dt);
		sleepA._integrate(dt);
		sleepB._integrate(dt);
		
		return deferedCollection;
	}
	
	inline public function _notifyWake(remainingTime:Float):Void {
		_remainingTime = remainingTime;
		_deltaTime  = remainingTime;
		
	}
	
	inline public function doCoarsePhase():Void {
	
		_updateList(wakeA);
		
		// todo: implementation of pairs for different groups/states
		//_updateList(wakeB);
		//_updateList(sleepA);
		//_updateList(sleepB);
   
		_collectMovingCollisionPairs();
	}
	
		
	// todo: implementation of pairs for different groups/states
	inline function _collectMovingCollisionPairs():Void {
		var h:CC3D =  wakeA.head;
		var v:CC3D;
		while ( h != null) {
			v = h.next;
			while ( v != null) {
				if ( h.isAABBOverlapping(v) ) {
					var pair:CC3DPair = _getCollisionPairFor(h, v);
					pair.next = this.pairList;
					this.pairList = pair;
				}
				v = v.next;
			}
			h = h.next;
		}   
	
	}

	inline function _updateList(list:CC3DList):Void {
		var h:CC3D = list.head;
		while (h != null) {
			h._updateAABB(_remainingTime);
			h._updateVectors(_remainingTime);
			if (h.staticCollision == null) {  // get new static collision
				var staticPair:CC3DPair = h._gotCollideWithWorld(_remainingTime) ? _getStaticCollisionFor(h) : null;
				if (staticPair != null) {
					var collDisplacement:Vector3D = h.collisionPoint.subtract(h.position);
					var dirNorm:Vector3D = collDisplacement.clone();
					dirNorm.normalize();
					dirNorm.scaleBy( -(h.collider.radiusX) );
					
					collDisplacement.x = collDisplacement.x + dirNorm.x;
					collDisplacement.y = collDisplacement.y + dirNorm.y;
					collDisplacement.z = collDisplacement.z + dirNorm.z;
					var lengther:Float = (Vector3DUtils.lengthOf(collDisplacement));

					var t:Float = lengther/ Vector3DUtils.lengthOf(h.displacement) * _remainingTime;
					
					if (PMath.isNaN(t)) {
						throw new Error("IT nAN!:"+_remainingTime+ " , " +t) + ", "+Vector3DUtils.lengthOf(collDisplacement) + ", "+collDisplacement;
						t = 0;	
					}
			
					if (t < 0) {
						t = 0;
						throw new Error("Delta time is lower than zero!");
					}
					
					staticPair.next = this.staticPairList;
					this.staticPairList = staticPair;
					
					staticPair.c1 = h;			
					staticPair.t = t;
					
					h.staticCollision = staticPair;
					
			
				}
			}
			h = h.next;
		}
	}
	
	inline function _getStaticCollisionFor(h:CC3D):CC3DPair 
	{
		var pair:CC3DPair =  _collisionTable.getStaticPair(h.collisionGroupId);
		pair.c1 = h;
		return pair;
	}
	inline function _getCollisionPairFor(h:CC3D, v:CC3D):CC3DPair 
	{
		var pair:CC3DPair =  _collisionTable.getPair(h.collisionGroupId, v.collisionGroupId);
		pair.c1 = h;
		pair.c2 = v;
		return pair;
	}
	
	inline public function addChild(cc:CC3D):Void {
		ccCount++;
		var list:CC3DList = cc.sleep ? cc.typeA ? sleepA : sleepB : cc.typeA ? wakeA : wakeB;
		list.prepend(cc);
	}
	
	inline public function removeChild(cc:CC3D):Void {
		cc._removeFromParent();
		cc._dispose();
		ccCount--;
	}

	
	public static function Create(sec:Sector):SectorPhysics {
		var result:SectorPhysics;
		if (collector != null) {
			result = collector;
			result.sector = sec;
			result._reset();
			sec.physics = result;
			collector = collector.next;
		}
		else {
			result = new SectorPhysics();
			result._init(sec);
		}
		return result;
	}
	
	/**
	 * NOTE: Assumed all cc3d lists are empty during disposal.
	 */
	public inline function dispose():Void {
		sector.physics = null;
		sector =  null;
		minPair = null;
		
		next = collector;
		collector = this;
	}
	
	inline public function getDeltaTime():Float 
	{
		return _deltaTime;
	}
	
}