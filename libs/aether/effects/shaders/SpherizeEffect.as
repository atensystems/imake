package aether.effects.shaders {

	import aether.utils.MathUtil;

	import flash.geom.Point;

	public class SpherizeEffect extends ShaderEffect {

		public static var shaderClass:String = "SpherizeKernel";
		public static var shaderFile:String = "spherize.pbj";

		private var _amount:Number;
		private var _center:Point;
		private var _radius:Number;
		
		public function SpherizeEffect(
			center:Point,
			radius:Number,
			amount:Number=1,
			blendMode:String=null,
			alpha:Number=1
		) {
			_shaderClass = shaderClass;
			_shaderFile = shaderFile;
			this.amount = amount;
			this.radius = radius;
			this.center = center;
			init(blendMode, alpha);
		}
		
		override protected function configureShader(data:Object):void {
			data.center.value = [_center.x, _center.y];
			data.radius.value = [_radius];
			data.amount.value = [_amount];
		}
		
		public function set amount(amount:Number):void {
			_amount = MathUtil.clamp(amount, -1, 1);
		}

		public function set radius(radius:Number):void {
			_radius = radius;
		}

		public function set center(center:Point):void {
			_center = center;
		}

	}

}