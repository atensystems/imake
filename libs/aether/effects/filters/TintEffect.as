package aether.effects.filters {
	
	public class TintEffect extends ColorMatrixEffect {
	
		public function TintEffect(tint:uint, blendMode:String=null, alpha:Number=1) {
			var matrix:Array = [
				(tint>>16&0xFF)/0xFF, .59, .11, 0, 0,
				 (tint>>8&0xFF)/0xFF, .59, .11, 0, 0,
				    (tint&0xFF)/0xFF, .59, .11, 0, 0,
								   0,   0,   0, 1, 0
			];
			super(matrix, blendMode, alpha);
		}
	
	}
	
}