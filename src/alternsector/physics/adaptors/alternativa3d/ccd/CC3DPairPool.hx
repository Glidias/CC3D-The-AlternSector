package alternsector.physics.adaptors.alternativa3d.ccd;


/**
 * ...
 * @author Glenn Ko
 */

class CC3DPairPool
{
	public var collector:CC3DPair;
	public var classe:Dynamic;
    static var EMPTY_PARAMS:Array<Dynamic> = [];

	public function new() 
	{
		
	}
	
	public static inline function getNewPool(classe:Dynamic):CC3DPairPool {
		var newPool:CC3DPairPool = new CC3DPairPool();
		newPool.classe = classe;
		return newPool;
	}
	
	public function allocate(amount:Int):Void {
		var result:CC3DPair;
		while ( --amount > -1 ) {
			result =  Type.createInstance( classe, EMPTY_PARAMS );
			result._init();
			result.pool = this;
			result.next = collector;
			collector = result;
		}
	}
	
	
	public function create():CC3DPair {
		var result:CC3DPair;
		
		if (collector != null) {
			result = collector;
			result.next = null;
			result.pool = this;
			collector = collector.next;
		}
		else {
			result =  Type.createInstance( classe, EMPTY_PARAMS );
			result._init();
			result.pool = this;
		}
		return result;
	}
	
}