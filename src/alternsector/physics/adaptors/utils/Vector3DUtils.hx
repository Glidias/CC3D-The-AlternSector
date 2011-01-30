package alternsector.physics.adaptors.utils;
import flash.geom.Vector3D;

/**
 * ...
 * @author Glenn Ko
 */

class Vector3DUtils 
{

	inline public static function distanceBetween(p1:Vector3D, p2:Vector3D):Float {
		var dx:Float = p2.x - p1.x;
		var dy:Float = p2.y - p1.y;
		var dz:Float = p2.z - p1.z;
		return Math.sqrt( dx * dx + dy * dy + dz * dz );
	}
	
	inline public static function lengthOf(vec:Vector3D):Float {
		return Math.sqrt( vec.x * vec.x + vec.y* vec.y + vec.z * vec.z );
	}
	
	inline public static function getNewScaledVector(src:Vector3D, scalar:Float):Vector3D {
		return new Vector3D(src.x * scalar, src.y * scalar, src.z * scalar);
	}
	
	
}