package alternativa.engine3d.core;

extern class MouseEvent3D extends flash.events.Event {
	var _bubbles : Bool;
	var _currentTarget : Object3D;
	var _eventPhase : UInt;
	var _target : Object3D;
	var altKey : Bool;
	var buttonDown : Bool;
	var ctrlKey : Bool;
	var delta : Int;
	var localDirection : flash.geom.Vector3D;
	var localOrigin : flash.geom.Vector3D;
	var relatedObject : Object3D;
	var shiftKey : Bool;
	var stop : Bool;
	var stopImmediate : Bool;
	function new(p0 : String, ?p1 : Bool, ?p2 : Object3D, ?p3 : Bool, ?p4 : Bool, ?p5 : Bool, ?p6 : Bool, ?p7 : Int) : Void;
	function calculateLocalRay(p0 : Float, p1 : Float, p2 : Object3D, p3 : Camera3D) : Void;
	static var CLICK : String;
	static var DOUBLE_CLICK : String;
	static var MOUSE_DOWN : String;
	static var MOUSE_MOVE : String;
	static var MOUSE_OUT : String;
	static var MOUSE_OVER : String;
	static var MOUSE_UP : String;
	static var MOUSE_WHEEL : String;
	static var ROLL_OUT : String;
	static var ROLL_OVER : String;
}
