package alternsector.physics.adaptors.alternativa3d.ccd;

/**
 * ...
 * @author Glenn Ko
 */

class CC3DPair 
{
	public var next:CC3DPair;
	public var pool:CC3DPairPool;
	
	public var t:Float;
	public var c1:CC3D;
	public var c2:CC3D;

	public function new() 
	{
		
	}
	
	public function _init():Void {
		
	}
	
	inline public function destroy():Void {
		c1 = null;
		c2 = null;
		_dispose();
	}
	
	
	inline function _dispose():Void {
		next = pool.collector;
		pool.collector = this;
	}
	
	/**
	 * Whether collision can occur between the two cc3Ds within timeframe
	 * @param	dt	The timeframe in seconds
	 * @return
	*/
	public function willCollide(dt:Float):Bool 
	{
		return false;
	}
		
	/**
	 * Override this to define specifics for resolving collisions
	*/
	public function resolve():Void 
	{
		
	}
	
}