package alternativa.engine3d.core;

extern class Wrapper {
	var next : Wrapper;
	var vertex : Vertex;
	function new() : Void;
	function create() : Wrapper;
	static var collector : Wrapper;
	static function Create() : Wrapper;
}
