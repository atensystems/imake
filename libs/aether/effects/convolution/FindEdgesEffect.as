package aether.effects.convolution {

	import aether.utils.Adjustments;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.filters.ColorMatrixFilter;
	
	public class FindEdgesEffect extends ConvolutionEffect {
	
		private var _grayscale:Boolean;
	
		public function FindEdgesEffect(
			grayscale:Boolean=false,
			blendMode:String=null,
			alpha:Number=1
		) {
			var matrix:Array=[
				-1, -1, -1,
				-1,  8, -1,
				-1, -1, -1
			];
			super(matrix, 1, 0, blendMode, alpha);
			_grayscale = grayscale;		
		}

		override protected function applyEffect(bitmapData:BitmapData):void {
			super.applyEffect(bitmapData);
			if (_grayscale) {
				var gray:ColorMatrixFilter = new ColorMatrixFilter(Adjustments.GRAYSCALE_MATRIX);
				bitmapData.applyFilter(bitmapData, bitmapData.rect, new Point(), gray);
			}
		}
		
	}
	
}