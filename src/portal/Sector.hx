package portal;
import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.core.Object3DContainer;
import alternsector.physics.adaptors.alternativa3d.ccd.SectorPhysics;

// Extern class for Alternativa3d context
extern class Sector  {  
		// (Physics on-demand. Both values must be supplied if physics is enabled for sector)
		// The sector physics zone to run a simulation. 
		public var physics:SectorPhysics;
		// Default static collision target (the main sector cell or some proxy geometry to test against)
		public var collisionTarget:Object3D;
		
		// -- Currently not used atm.
		// (Optional/on-demand)
		// A container of inner objects/geometry to test against static stuff.
		public var container:Object3DContainer;  
		
}