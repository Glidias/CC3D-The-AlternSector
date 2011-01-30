package alternativa.engine3d.core;

extern class EllipsoidCollider 
{
	var radiusX : Float;
	var radiusY : Float;
	var radiusZ : Float;
	var threshold : Float;

	function calculateDestination (source:flash.geom.Vector3D, displacement:flash.geom.Vector3D, object:Object3D, excludedObjects:flash.utils.Dictionary = null) : flash.geom.Vector3D;

	function getCollision (source:flash.geom.Vector3D, displacement:flash.geom.Vector3D, resCollisionPoint:flash.geom.Vector3D, resCollisionPlane:flash.geom.Vector3D, object:Object3D, excludedObjects:flash.utils.Dictionary = null) : Bool;

	function new(radiusX:Float, radiusY:Float, radiusZ:Float):Void;
}