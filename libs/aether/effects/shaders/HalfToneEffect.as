package aether.effects.shaders {
	
	public class HalfToneEffect extends StampEffect {

		public static var shaderClass:String = "HalfToneKernel";
		public static var shaderFile:String = "halfTone.pbj";

		public function HalfToneEffect(
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
		
	}

}