package aether.effects.shaders {
	
	import aether.utils.MathUtil;

	public class IsolateColorEffect extends ShaderEffect {

		public static var shaderClass:String = "IsolateColorKernel";
		public static var shaderFile:String = "isolateColor.pbj";

		private var _red:uint;
		private var _green:uint;
		private var _blue:uint;
		private var _hueThreshold:uint;
		private var _luminanceThreshold:uint;
		private var _hideNonIsolated:uint;
		
		public function IsolateColorEffect(
			color:uint=0xFF0000,
			hueThreshold:uint=10,
			luminanceThreshold:uint=60,
			hideNonIsolated:Boolean=false,
			blendMode:String=null,
			alpha:Number=1
		) {
			_shaderClass = shaderClass;
			_shaderFile = shaderFile;
			this.color = color;
			this.hueThreshold = hueThreshold;
			this.luminanceThreshold = luminanceThreshold;
			this.hideNonIsolated = hideNonIsolated;
			init(blendMode, alpha);
		}
		
		override protected function configureShader(data:Object):void {
			data.color.value = [_red, _green, _blue];
			data.hueThreshold.value = [_hueThreshold];
			data.luminanceThreshold.value = [_luminanceThreshold];
			data.hideNonIsolated.value = [_hideNonIsolated];
		}
		
		public function set color(color:uint):void {
			color = MathUtil.clamp(color, 0, 0xFFFFFF);
			_red = color >> 16 & 0xFF;
			_green = color >> 8 & 0xFF;
			_blue = color & 0xFF;
		}

		public function set hueThreshold(threshold:uint):void {
			_hueThreshold = MathUtil.clamp(threshold, 0, 360);
		}

		public function set luminanceThreshold(threshold:uint):void {
			_luminanceThreshold = MathUtil.clamp(threshold, 0, 255);
		}

		public function set hideNonIsolated(hide:Boolean):void {
			_hideNonIsolated = hide ? 1 : 0;
		}

	}

}