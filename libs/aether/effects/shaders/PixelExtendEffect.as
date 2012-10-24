package aether.effects.shaders {
	
	import aether.utils.MathUtil;

	public class PixelExtendEffect extends ShaderEffect {

		public static var shaderClass:String = "PixelExtendKernel";
		public static var shaderFile:String = "pixelExtend.pbj";

		public static const LEFT:uint = 0;
		public static const TOP:uint = 1;
		public static const RIGHT:uint = 2;
		public static const BOTTOM:uint = 3;

		private var _direction:uint;
		private var _startPixel:uint;
		
		public function PixelExtendEffect(
			direction:uint=0,
			startPixel:uint=0,
			blendMode:String=null,
			alpha:Number=1
		) {
			_shaderClass = shaderClass;
			_shaderFile = shaderFile;
			this.direction  = direction;
			this.startPixel = startPixel;
			init(blendMode, alpha);
		}
		
		override protected function configureShader(data:Object):void {
			data.direction.value = [_direction];
			data.startPixel.value = [_startPixel];
		}
		
		public function set direction(direction:uint):void {
			_direction = MathUtil.clamp(direction, 0, 3);
		}

		public function set startPixel(startPixel:uint):void {
			_startPixel = startPixel;
		}

	}

}