package aether.effects.shaders {
	
	import aether.utils.MathUtil;

	public class StampEffect extends ShaderEffect {

		public static var shaderClass:String = "StampKernel";
		public static var shaderFile:String = "stamp.pbj";

		private var _foregroundColor:uint;
		private var _backgroundColor:uint;
		private var _threshold:Number;
		
		public function StampEffect(
			threshold:Number=.4,
			foregroundColor:uint=0xFFFFFFFF,
			backgroundColor:uint=0xFF000000,
			blendMode:String=null,
			alpha:Number=1
		) {
			_shaderClass = shaderClass;
			_shaderFile = shaderFile;
			this.threshold = threshold;
			this.foregroundColor  = foregroundColor;
			this.backgroundColor  = backgroundColor;
			init(blendMode, alpha);
		}
		
		override protected function configureShader(data:Object):void {
			data.levelsThreshold.value = [_threshold];
			data.foregroundColor.value = [
				(_foregroundColor >> 16 & 0xFF)/0xFF,
				(_foregroundColor >> 8 & 0xFF)/0xFF,
				(_foregroundColor & 0xFF)/0xFF,
				(_foregroundColor >> 24 & 0xFF)/0xFF
			];
			data.backgroundColor.value = [
				(_backgroundColor >> 16 & 0xFF)/0xFF,
				(_backgroundColor >> 8 & 0xFF)/0xFF,
				(_backgroundColor & 0xFF)/0xFF,
				(_backgroundColor >> 24 & 0xFF)/0xFF
			];
		}
		
		public function set foregroundColor(color:uint):void {
			_foregroundColor = color;
		}

		public function set backgroundColor(color:uint):void {
			_backgroundColor = color;
		}

		public function set threshold(threshold:Number):void {
			_threshold = MathUtil.clamp(threshold, 0, 1);
		}

	}

}