package aether.effects.transformations {
	
	import aether.effects.ImageEffect;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class GridEffect extends ImageEffect {
	
		private var _rows:uint;
		private var _columns:uint;

		public function GridEffect(
			rows:uint=2,
			columns:uint=2,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_rows = rows;
			_columns = columns;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var w:Number = bitmapData.width;
			var tW:Number = w/_columns;
			var h:Number = bitmapData.height;
			var tH:Number = h/_rows;
			var matrix:Matrix = new Matrix();
			matrix.scale(tW/w, tH/h);
			var image:BitmapData = new BitmapData(tW, tH, true, 0x00000000);
			image.draw(bitmapData, matrix);
			var grid:BitmapData = new BitmapData(w, h);
			var column:uint;
			for (var row:uint = 0; row < _rows; row++) {
				for (column = 0; column < _columns; column++) {
					grid.copyPixels(image, image.rect, new Point(column*tW, row*tH));
				}
			}
			bitmapData.copyPixels(grid, grid.rect, new Point());
		}
	
	}
	
}