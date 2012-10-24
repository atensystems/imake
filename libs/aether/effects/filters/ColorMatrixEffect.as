package aether.effects.filters {
	
	import flash.filters.ColorMatrixFilter;
	
	public class ColorMatrixEffect extends BitmapFilterEffect {
	
		static public var GRAYSCALE:Array = [.3, .59, .11, 0, 0, .3, .59, .11, 0, 0, .3, .59, .11, 0, 0, 0, 0, 0, 1, 0];
		static public var SEPIA:Array = [.5, .59, .11, 0, 0, .4, .59, .11, 0, 0, .16, .59, .11, 0, 0, 0, 0, 0, 1, 0];
		static public var IDENTITY:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];

		private var _matrix:Array;

		public function ColorMatrixEffect(matrix:Array, blendMode:String=null, alpha:Number=1) {
			var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			super(filter, blendMode, alpha);
		}
	
	}
	
}