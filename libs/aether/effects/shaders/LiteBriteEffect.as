package aether.effects.shaders {

	import aether.utils.MathUtil;

	public class LiteBriteEffect extends ShaderEffect {

		public static var shaderClass:String = "LiteBriteKernel";
		public static var shaderFile:String = "liteBrite.pbj";

		private var _backgroundColor:uint;
		private var _threshold:Number;

		public function LiteBriteEffect(
			threshold:Number=.4,
			backgroundColor:uint=0xFF000000,
			blendMode:String=null,
			alpha:Number=1
		) {
			_shaderClass = shaderClass;
			_shaderFile = shaderFile;
			this.threshold = threshold;
			this.backgroundColor  = backgroundColor;
			init(blendMode, alpha);
		}
		
		override protected function configureShader(data:Object):void {
			data.levelsThreshold.value = [_threshold];
			data.backgroundColor.value = [
				(_backgroundColor >> 16 & 0xFF)/0xFF,
				(_backgroundColor >> 8 & 0xFF)/0xFF,
				(_backgroundColor & 0xFF)/0xFF,
				(_backgroundColor >> 24 & 0xFF)/0xFF
			];
		}
		
		public function set backgroundColor(color:uint):void {
			_backgroundColor = color;
		}

		public function set threshold(threshold:Number):void {
			_threshold = MathUtil.clamp(threshold, 0, 1);
		}

	}

}