package alternativa.engine3d.core;

extern class View extends Canvas {
	var _height : Float;
	var _interactive : Bool;
	var _width : Float;
	var camera : Camera3D;
	var interactive : Bool;
	var logoAlign : String;
	var logoHorizontalMargin : Float;
	var logoVerticalMargin : Float;
	function new(width : Float, height : Float, ?p2 : Bool) : Void;
	function clear() : Void;
	function hideLogo() : Void;
	function onMouseMove(?p0 : flash.events.MouseEvent) : Void;
	function showLogo() : Void;
}
