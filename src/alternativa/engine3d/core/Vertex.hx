package alternativa.engine3d.core;

extern class Vertex {
	var cameraX : Float;
	var cameraY : Float;
	var cameraZ : Float;
	var drawId : Int;
	var index : Int;
	var next : Vertex;
	var offset : Float;
	var transformId : Int;
	var u : Float;
	var v : Float;
	var value : Vertex;
	var x : Float;
	var y : Float;
	var z : Float;
	function new() : Void;
	function create() : Vertex;
	function toString() : String;
	static var collector : Vertex;
	static function createList(p0 : Int) : Vertex;
}
