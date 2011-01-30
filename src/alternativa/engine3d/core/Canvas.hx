package alternativa.engine3d.core;

extern class Canvas extends flash.display.Sprite {
	var _numChildren : Int;
	var gfx : flash.display.Graphics;
	var modifiedAlpha : Bool;
	var modifiedBlendMode : Bool;
	var modifiedColorTransform : Bool;
	var modifiedFilters : Bool;
	var modifiedGraphics : Bool;
	var numDraws : Int;
	var object : Object3D;
	function new() : Void;
	function getChildCanvas(p0 : Bool, p1 : Bool, ?p2 : Object3D, ?p3 : Float, ?p4 : String, ?p5 : flash.geom.ColorTransform, ?p6 : Array<Dynamic>) : Canvas;
	function removeChildren(p0 : Int) : Void;
	static var collector : flash.Vector<Canvas>;
	static var collectorLength : Int;
	static var defaultColorTransform : flash.geom.ColorTransform;
}
