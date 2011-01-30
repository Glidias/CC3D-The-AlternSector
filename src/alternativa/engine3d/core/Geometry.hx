package alternativa.engine3d.core;

extern class Geometry {
	var _faces : flash.utils.Dictionary;
	var _vertices : flash.utils.Dictionary;
	var faceIdCounter : UInt;
	var faces(default,null) : flash.utils.Dictionary;
	var orderedFaces(default,null) : flash.Vector<Face>;
	var orderedVertices(default,null) : flash.Vector<Vertex>;
	var vertexIdCounter : UInt;
	var vertices(default,null) : flash.utils.Dictionary;
	function new() : Void;
	function addFace(p0 : flash.Vector<Vertex>, ?p1 : alternativa.engine3d.materials.Material, ?p2 : Dynamic) : Face;
	function addFaceByIds(p0 : Array<Dynamic>, ?p1 : alternativa.engine3d.materials.Material, ?p2 : Dynamic) : Face;
	function addQuadFace(p0 : Vertex, p1 : Vertex, p2 : Vertex, p3 : Vertex, ?p4 : alternativa.engine3d.materials.Material, ?p5 : Dynamic) : Face;
	function addTriFace(p0 : Vertex, p1 : Vertex, p2 : Vertex, ?p3 : alternativa.engine3d.materials.Material, ?p4 : Dynamic) : Face;
	function addVertex(p0 : Float, p1 : Float, p2 : Float, ?p3 : Float, ?p4 : Float, ?p5 : Dynamic) : Vertex;
	function addVerticesAndFaces(p0 : flash.Vector<Float>, p1 : flash.Vector<Float>, p2 : flash.Vector<Int>, ?p3 : Bool, ?p4 : alternativa.engine3d.materials.Material) : Void;
	function clone() : Geometry;
	function getFaceById(p0 : Dynamic) : Face;
	function getFaceId(p0 : Face) : Dynamic;
	function getVertexById(p0 : Dynamic) : Vertex;
	function getVertexId(p0 : Vertex) : Dynamic;
	function hasFace(p0 : Face) : Bool;
	function hasFaceById(p0 : Dynamic) : Bool;
	function hasVertex(p0 : Vertex) : Bool;
	function hasVertexById(p0 : Dynamic) : Bool;
	function removeFace(p0 : Face) : Face;
	function removeFaceById(p0 : Dynamic) : Face;
	function removeVertex(p0 : Vertex) : Vertex;
	function removeVertexById(p0 : Dynamic) : Vertex;
	function transform(p0 : flash.geom.Matrix3D) : Void;
	function weldFaces(?p0 : Float, ?p1 : Float, ?p2 : Float, ?p3 : Bool) : Void;
	function weldVertices(?p0 : Float, ?p1 : Float) : Void;
}
