package aether.effects.convolution {
	
	public class SharpenEffect extends ConvolutionEffect {

		public function SharpenEffect(
			pAmount:Number=5,
			blendMode:String=null,
			alpha:Number=1
		) {
			var matrix:Array = [
				 0,      -1,  0,
				-1, pAmount, -1,
				 0,      -1,  0
			];
			super(matrix, 1, 0, blendMode, alpha);
		}
	
	}
	
}