package aether.effects.filters {
	
	public class ContrastEffect extends ColorMatrixEffect {

		public function ContrastEffect(
			amount:Number=.3,
			blendMode:String=null,
			alpha:Number=1
		) {
			var scale:Number = amount + 1;
			var offset:Number = 128 * (1 - scale);
			var matrix:Array = [
				scale,     0,     0, 0, offset,
				0, 	   scale,     0, 0, offset,
				0,         0, scale, 0, offset,
				0,         0,     0, 1,      0 
			];
			super(matrix, blendMode, alpha);
		}
	
	}
	
}