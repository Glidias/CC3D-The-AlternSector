package alternsector.physics.adaptors.alternativa3d.ccd;

/**
 * ...
 * @author Glenn Ko
 */

class CC3DList 
{
	public var head:CC3D;


	public function new() 
	{
		
	}
	
	inline public function _integrate(dt:Float):Void {
		var h:CC3D = head;
		while (h != null) {
			h._integrate(dt);
			h = h.next;
		}
	}

	
	// TODO: Proper implementation for parent/prev/next
	inline public function prepend(cc:CC3D):Void {
		if (head != null) {
			
		}
		cc.next = head;
		head = cc;
	}
	
	
}