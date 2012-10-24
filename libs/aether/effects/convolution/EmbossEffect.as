package aether.effects.convolution {
	
	public class EmbossEffect extends ConvolutionEffect {

		public function EmbossEffect(
			amount:Number=2,
			blendMode:String=null,
			alpha:Number=1
		) {
			var matrix:Array = [
				-amount, -1,      0,
				     -1,  1,      1,
				      0,  1, amount
			];
			super(matrix, 1, 0, blendMode, alpha);
		}
	
	}
	
}