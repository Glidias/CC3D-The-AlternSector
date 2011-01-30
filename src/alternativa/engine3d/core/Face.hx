package alternativa.engine3d.core;

extern class Face {
	var distance : Float;
	var geometry : VG;
	var material : alternativa.engine3d.materials.Material;
	var next : Face;
	var normal(default,null) : flash.geom.Vector3D;
	var normalX : Float;
	var normalY : Float;
	var normalZ : Float;
	var offset : Float;
	var processNegative : Face;
	var processNext : Face;
	var processPositive : Face;
	var vertices(default,null) : flash.Vector<Vertex>;
	var wrapper : Wrapper;
	function new() : Void;
	function calculateBestSequenceAndNormal() : Void;
	function create() : Face;
	function getUV(p0 : flash.geom.Vector3D) : flash.geom.Point;
	function toString() : String;
	static var collector : Face;
	//static function Create() : Face;
}
