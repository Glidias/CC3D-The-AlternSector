package alternativa.engine3d.core;

extern class Debug {
	static var BONES : Int;
	static var BOUNDS : Int;
	static var EDGES : Int;
	static var NODES : Int;
	static function drawBone(p0 : Canvas, p1 : Float, p2 : Float, p3 : Float, p4 : Float, p5 : Float, p6 : Int) : Void;
	static function drawBounds(p0 : Camera3D, p1 : Canvas, p2 : Object3D, p3 : Float, p4 : Float, p5 : Float, p6 : Float, p7 : Float, p8 : Float, ?p9 : Int, ?p10 : Float) : Void;
	static function drawEdges(p0 : Camera3D, p1 : Canvas, p2 : Face, p3 : Int) : Void;
	static function drawKDNode(p0 : Camera3D, p1 : Canvas, p2 : Object3D, p3 : Int, p4 : Float, p5 : Float, p6 : Float, p7 : Float, p8 : Float, p9 : Float, p10 : Float, p11 : Float) : Void;
}
