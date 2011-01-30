/**
 * ...
 * @author Glenn Ko
 */

package alternsector.physics.adaptors.alternativa3d.ccd;
import flash.Vector;

class CollisionTable 
{
	static var _instance:CollisionTable = new CollisionTable();
	
	var _COUNT:Int;
	public function getNewCollisionGroupId(staticPairClasse:Dynamic=null, staticAllocate:Int=0):Int {
		var row:Vector<CC3DPairPool> = new Vector<CC3DPairPool>(_COUNT);
		_poolTable.push( row );
		var newPool:CC3DPairPool;
		for (i in 0..._COUNT+1) {
			newPool = new CC3DPairPool();
			newPool.classe = CC3DPairPool;
			row[i] = newPool;
		}
		
		staticPairClasse != null ? registerStaticCollisionPair(_COUNT, staticPairClasse, staticAllocate) : registerStaticCollisionPair(_COUNT, CC3DPair, 0);
		return _COUNT++;
	}

	// todo: filter mask optmisation to CAT A/B items
	public function setFilterMask(groupId:Int, groupMask:Int):Void {
		
	}
	
	inline public function registerStaticCollisionPair(groupId:Int, classe:Dynamic, staticAmount:Int=0):Void 
	{
		var newPool:CC3DPairPool = new CC3DPairPool();
		newPool.classe = classe;
		_staticPoolTable[groupId] = newPool;
		if (staticAmount != 0) {
			newPool.allocate(staticAmount);
		}
	}

	
	var _poolTable:Vector<Vector<CC3DPairPool>>;
	var _staticPoolTable:Vector<CC3DPairPool>;

	function new() 
	{
		reset();
	}
	
	public static inline function Get():CollisionTable {
		return _instance;
	}
	
	public function reset():Void {
		_poolTable = new Vector<Vector<CC3DPairPool>>();
		_staticPoolTable = new Vector<CC3DPairPool>();
		_COUNT = 0;
	}
	
	inline public function getPair(groupId1:Int, groupId2:Int):CC3DPair {
		var pairPool:CC3DPairPool = _poolTable[groupId1][groupId2];
		return pairPool.create();
	}
	inline public function getStaticPair(groupId1:Int):CC3DPair {
		var pairPool:CC3DPairPool = _staticPoolTable[groupId1];
		return pairPool.create();
	}
	
	public function registerCollisionPair(groupId:Int, groupId2:Int, classe:Dynamic, allocateAmount:Int = 0):Void {
		var pairPool:CC3DPairPool = new CC3DPairPool();
		pairPool.classe = classe;
		_poolTable[groupId][groupId2] = pairPool;
		_poolTable[groupId2][groupId] = pairPool;
		if (allocateAmount > 0) {
			pairPool.allocate(allocateAmount);
		}
	}
	
	public function finalize():Void {
		_poolTable.fixed = true;
		for (i in 0..._COUNT) {
			_poolTable[i].fixed = true;
		}
		_staticPoolTable.fixed = true;
	}
	
	// -- Other methods
	
	inline public function getStaticPool(id:Int):CC3DPairPool {
		return _staticPoolTable[id];
	}
	inline public function getPool(id1:Int, id2:Int):CC3DPairPool {
		return _poolTable[id1][id2];
	}
	
	
}