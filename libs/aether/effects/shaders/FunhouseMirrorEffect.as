package {
	
	import aether.effects.shaders.ShaderEffect;

	public class FunhouseMirrorEffect extends ShaderEffect {

		public static var shaderClass:String = "FunhouseMirrorKernel";
		public static var shaderFile:String = "funhouseMirror.pbj";

		private var _warpBeginX:uint;
		private var _warpEndX:uint;
		private var _warpRatioX:uint;
		private var _distortionX:Number;
		private var _warpBeginY:uint;
		private var _warpEndY:uint;
		private var _warpRatioY:uint;
		private var _distortionY:Number;
		
		public function FunhouseMirrorEffect(
			warpBeginX:uint=0,
			warpEndX:uint=512,
			warpRatioX:uint=0.5,
			distortionX:Boolean=0.5,
			warpBeginY:uint=0,
			warpEndY:uint=512,
			warpRatioY:uint=0.5,
			distortionY:Boolean=0.5,
			blendMode:String=null,
			alpha:Number=1
		) {
			_shaderClass = shaderClass;
			_shaderFile = shaderFile;
			this.warpBeginX = warpBeginX;
			this.warpEndX = warpEndX;
			this.warpRatioX = warpRatioX;
			this.distortionX = distortionX;
			this.warpBeginY = warpBeginY;
			this.warpEndY = warpEndY;
			this.warpRatioY = warpRatioY;
			this.distortionY = distortionY;
			init(blendMode, alpha);
		}
		
		override protected function configureShader(data:Object):void {
			data.color.warpBeginX = [_warpBeginX];
			data.color.warpEndX = [warpEndX];
			data.color.warpRatioX = [warpRatioX];
			data.color.distortionX = [_distortionX];
			data.color.warpBeginY = [_warpBeginY];
			data.color.warpEndY = [warpEndY];
			data.color.warpRatioY = [warpRatioY];
			data.color.distortionY = [_distortionY];
		}
		
		public function set warpBeginX(x:uint):void {
			_warpBeginX = x;
		}

		public function set warpEndX(x:uint):void {
			_warpEndX = x;
		}

		public function set warpRatioX(ratio:Number):void {
			_warpRatioX = ratio;
		}

		public function set distortionX(amount:uint):void {
			_distortionX = amount;
		}

		public function set warpBeginY(x:uint):void {
			_warpBeginY = x;
		}

		public function set warpEndY(x:uint):void {
			_warpEndY = x;
		}

		public function set warpRatioY(ratio:Number):void {
			_warpRatioY = ratio;
		}

		public function set distortionY(amount:uint):void {
			_distortionY = amount;
		}

	}

}