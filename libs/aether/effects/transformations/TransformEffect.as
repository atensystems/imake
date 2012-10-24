package aether.effects.transformations {
	
	import aether.effects.ImageEffect;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class TransformEffect extends ImageEffect {
	
		private var _matrix:Matrix;
		private var _bgColor:uint;

		public function TransformEffect(
			matrix:Matrix,
			bgColor:uint=0,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_matrix = matrix;
			_bgColor = bgColor;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var copy:BitmapData = new BitmapData(bitmapData.width, bitmapData.height, true, _bgColor);
			copy.draw(bitmapData, _matrix);
			bitmapData.copyPixels(copy, copy.rect, new Point());
		}
	
	}
	
}