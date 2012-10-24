package aether.effects.shaders {
	
	import flash.geom.Point;
	
	public class WormholeEffect extends ShaderEffect {

		public static var shaderClass:String = "WormHoleKernel";
		public static var shaderFile:String = "wormhole.pbj";

		private var _twirlAngle:Number;
		private var _gravity:Number;
		private var _center:Point;
		private var _radius:Number;
		
		public function WormholeEffect(
			center:Point,
			radius:Number=50,
			twirlAngle:Number=0,
			gravity:Number=0,
			blendMode:String=null,
			alpha:Number=1
		) {
			_shaderClass = shaderClass;
			_shaderFile = shaderFile;
			this.twirlAngle = twirlAngle;
			this.gravity = gravity;
			this.radius = radius;
			this.center = center;
			init(blendMode, alpha);
		}
		
		override protected function configureShader(data:Object):void {
			data.center.value = [_center.x, _center.y];
			data.radius.value = [_radius];
			data.twirlAngle.value = [_twirlAngle];
			data.gravity.value = [_gravity];
		}
		
		public function set twirlAngle(angle:Number):void {
			_twirlAngle = angle;
		}

		public function set gravity(gravity:Number):void {
			_gravity = gravity;
		}

		public function set radius(radius:Number):void {
			_radius = radius;
		}

		public function set center(center:Point):void {
			_center = center;
		}

	}

}