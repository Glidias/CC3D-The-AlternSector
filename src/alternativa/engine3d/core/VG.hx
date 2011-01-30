package alternativa.engine3d.core;

extern class VG {
	var alpha : Float;
	var blendMode : String;
	var boundMaxX : Float;
	var boundMaxY : Float;
	var boundMaxZ : Float;
	var boundMinX : Float;
	var boundMinY : Float;
	var boundMinZ : Float;
	var boundPlaneList : Vertex;
	var boundVertexList : Vertex;
	var colorTransform : flash.geom.ColorTransform;
	var debug : Int;
	var faceStruct : Face;
	var filters : Array<Dynamic>;
	var next : VG;
	var numOccluders : Int;
	var object : Object3D;
	var sorting : Int;
	var space : Int;
	var tma : Float;
	var tmb : Float;
	var tmc : Float;
	var tmd : Float;
	var tmtx : Float;
	var tmty : Float;
	var viewAligned : Bool;
	function new() : Void;
	function calculateAABB(p0 : Float, p1 : Float, p2 : Float, p3 : Float, p4 : Float, p5 : Float, p6 : Float, p7 : Float, p8 : Float, p9 : Float, p10 : Float, p11 : Float) : Void;
	function calculateOOBB(p0 : Object3D) : Void;
	function crop(p0 : Camera3D, p1 : Float, p2 : Float, p3 : Float, p4 : Float, p5 : Float) : Void;
	function destroy() : Void;
	function draw(p0 : Camera3D, p1 : Canvas, p2 : Float, p3 : Object3D) : Void;
	function split(p0 : Camera3D, p1 : Float, p2 : Float, p3 : Float, p4 : Float, p5 : Float) : Void;
	function transformStruct(p0 : Face, p1 : Int, p2 : Float, p3 : Float, p4 : Float, p5 : Float, p6 : Float, p7 : Float, p8 : Float, p9 : Float, p10 : Float, p11 : Float, p12 : Float, p13 : Float) : Void;
	static function create(p0 : Object3D, p1 : Face, p2 : Int, p3 : Int, p4 : Bool, ?p5 : Float, ?p6 : Float, ?p7 : Float, ?p8 : Float, ?p9 : Float, ?p10 : Float) : VG;
}
