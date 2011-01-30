package alternsector.physics.adaptors.alternativa3d.ccd;
import alternativa.engine3d.core.EllipsoidCollider;
import alternativa.engine3d.core.Object3D;
import alternsector.math.PMath;
import flash.errors.Error;

import portal.Sector;

import flash.geom.Vector3D;

/**
 * ...
 * @author Glenn Ko
 */

class CC3D 
{
	// Alternativa3D implementation
	public var object:Object3D;
	public var collider:EllipsoidCollider;
		
	// Basic info
	public var vx:Float;
	public var vy:Float;
	public var vz:Float;
	public var entity:Dynamic;
	public var collisionGroupId:Int;
	public var sleep:Bool;
	public var staticCollision:CC3DPair;
	public var collisionPoint:Vector3D;
	public var collisionNormal:Vector3D;
	public var position:Vector3D;
	public var displacement:Vector3D;
	
	public var typeA:Bool;
		
	// -- World implementation 
	// Sector binding
	public var sector:Sector;
	// Id integer for generic use
	public var id:Int;
		
	// Linked list and parent
	public var _parent:CC3DList;
	public var prev:CC3D;
	public var next:CC3D;
		
	// Result aabb during movement
	public var boundMaxX : Float;
	public var boundMaxY : Float;
	public var boundMaxZ : Float;
	public var boundMinX : Float;
	public var boundMinY : Float;
	public var boundMinZ : Float;
	
	// Other info
	public var mass:Float; // <- this variable might be factored out elsewhere
	
	// Pooling
	public static var collector:CC3D;

	public function new() 
	{
		
	}
	
	inline public function _integrate(dt:Float):Void {
		object.x += vx * dt;
		object.y += vy * dt;
		object.z += vz * dt;	
	}
	
	inline public function _updateAABB(dt:Float):Void {
        var dest:Float = object.x + vx * dt;
        boundMinX = PMath.minF( object.x, dest ) - collider.radiusX;
        boundMaxX = PMath.maxF( object.x, dest ) + collider.radiusX;
		dest = object.y + vy * dt;
		boundMinY = PMath.minF( object.y, dest ) - collider.radiusY;
        boundMaxY = PMath.maxF( object.y, dest ) + collider.radiusY;
		dest = object.z + vz * dt;
		boundMinZ = PMath.minF( object.z, dest ) - collider.radiusZ;
        boundMaxZ = PMath.maxF( object.z, dest ) + collider.radiusZ;
	}
	
	inline public function isAABBOverlapping( sibling:CC3D ):Bool {
        return !( boundMinX > sibling.boundMaxX || 
				  boundMinY > sibling.boundMaxY ||
				  boundMinZ > sibling.boundMaxZ ||
				  boundMaxX < sibling.boundMinX ||
				  boundMaxY < sibling.boundMinY || 
				  boundMaxZ < sibling.boundMinZ 
		);
    }
	
	inline public function collidesWithWorld(dt:Float):Bool {
		_updateVectors(dt);
		return _gotCollideWithWorld(dt);
	}
	
	inline public function _updateVectors(dt:Float):Void {
		position.x = object.x;
		position.y = object.y;
		position.z = object.z;
		displacement.x = vx * dt;
		displacement.y = vy * dt;
		displacement.z = vz * dt;
	}

	inline public function _gotCollideWithWorld(dt:Float):Bool {
		// todo: also need to consider inner sector geom if available
		return collider.getCollision(position, displacement, collisionPoint, collisionNormal, sector.collisionTarget);  
	}
	
	// todo: disposal/killing
	inline public function _removeFromParent():Void {
		
	}
	
	inline public function _dispose():Void {
		
	}
	
	
	
	public static function create(obj:Object3D, entity:Dynamic, collisionGroupId:Int, vx:Float, vy:Float, vz:Float, radiusX:Float, radiusY:Float, radiusZ:Float, sector:Sector):CC3D {
		var result:CC3D;
		if (collector != null) {
			result = collector;
			result.collider.radiusX = radiusX;
			result.collider.radiusY = radiusY;
			result.collider.radiusZ = radiusZ;
			collector = collector.next;
		}
		else {
			result = new CC3D();
			result.collider = new EllipsoidCollider(radiusX, radiusY, radiusZ);
			result.collisionNormal = new Vector3D();
			result.collisionPoint = new Vector3D();
			result.position  = new Vector3D();
			result.displacement = new Vector3D();
		}
		result.next = null;
		result.sleep = false;
		result.sector = sector;
		result.mass = 1;
		//result.prev = null;
		result.typeA = true; // todo: proper type based on collisionGroupId
		result.object = obj;
		result.vx = vx;
		result.vy = vy;
		result.vz  = vz;
		result.entity = entity;
		result.collisionGroupId = collisionGroupId;
		return result;
	}
		
	public static function createStatic(obj:Object3D):Void {
		var result:CC3D;
		if (collector != null) {
			result = collector;
			collector = collector.next;
		}
		else result = new CC3D();
		result.next = null;
		
		result.object = obj;
	}
	
}