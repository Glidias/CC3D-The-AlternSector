package alternativa.engine3d.materials;

extern class TextureMaterial extends Material {
	var _mipMapping : Int;
	var _texture : flash.display.BitmapData;
	var correctUV : Bool;
	var diffuseMapURL : String;
	var mipMap : flash.Vector<flash.display.BitmapData>;
	var mipMapping : Int;
	var numMaps : Int;
	var opacityMapURL : String;
	var repeat : Bool;
	var resolution : Float;
	var smooth : Bool;
	var texture : flash.display.BitmapData;
	var threshold : Float;
	function new(?p0 : flash.display.BitmapData, ?p1 : Bool, ?p2 : Bool, ?p3 : Int, ?p4 : Float) : Void;
	function calculateMipMaps() : Void;
	function disposeMipMaps() : Void;
	static var drawIndices : flash.Vector<Int>;
	static var drawUVTs : flash.Vector<Float>;
	static var drawVertices : flash.Vector<Float>;
}
