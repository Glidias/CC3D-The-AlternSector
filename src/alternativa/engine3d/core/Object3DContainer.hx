package alternativa.engine3d.core;

extern class Object3DContainer extends Object3D {
	var childrenList : Object3D;
	var mouseChildren : Bool;
	var numChildren(default,null) : Int;
	var numVisibleChildren : Int;
	var visibleChildren : flash.Vector<Object3D>;
	function new() : Void;
	function addChild(p0 : Object3D) : Object3D;
	function addChildAt(p0 : Object3D, p1 : Int) : Object3D;
	function addToList(p0 : Object3D, ?p1 : Object3D) : Void;
	function collectVG(p0 : Camera3D) : VG;
	function colorizeVG(p0 : VG) : Void;
	function contains(p0 : Object3D) : Bool;
	function drawVisibleChildren(p0 : Camera3D, p1 : Canvas) : Void;
	function getChildAt(p0 : Int) : Object3D;
	function getChildByName(p0 : String) : Object3D;
	function getChildIndex(p0 : Object3D) : Int;
	function removeChild(p0 : Object3D) : Object3D;
	function removeChildAt(p0 : Int) : Object3D;
	function setChildIndex(p0 : Object3D, p1 : Int) : Void;
	function swapChildren(p0 : Object3D, p1 : Object3D) : Void;
	function swapChildrenAt(p0 : Int, p1 : Int) : Void;
}
