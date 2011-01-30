package alternativa.engine3d.materials;

extern class Material {
	var name : String;
	function new() : Void;
	function clearLinks(p0 : alternativa.engine3d.core.Face) : Void;
	function draw(p0 : alternativa.engine3d.core.Camera3D, p1 : alternativa.engine3d.core.Canvas, p2 : alternativa.engine3d.core.Face, p3 : Float) : Void;
	function drawViewAligned(p0 : alternativa.engine3d.core.Camera3D, p1 : alternativa.engine3d.core.Canvas, p2 : alternativa.engine3d.core.Face, p3 : Float, p4 : Float, p5 : Float, p6 : Float, p7 : Float, p8 : Float, p9 : Float) : Void;
	function toString() : String;
}
