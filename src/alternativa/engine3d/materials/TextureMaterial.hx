package alternativa.engine3d.materials;

extern class TextureMaterial extends Material {
	var correctUV : Bool;
	var diffuseMapURL : String;
	var mipMapping : Int;
	var opacityMapURL : String;
	var repeat : Bool;
	var resolution : Float;
	var smooth : Bool;
	var texture : flash.display.BitmapData;
	var threshold : Float;
	function new(?p0 : flash.display.BitmapData, ?p1 : Bool, ?p2 : Bool, ?p3 : Int, ?p4 : Float) : Void;
}
