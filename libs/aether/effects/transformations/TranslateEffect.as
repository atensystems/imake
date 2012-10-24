package aether.effects.transformations {
	
	import aether.effects.ImageEffect;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class TranslateEffect extends ImageEffect {
	
		private var _matrix:Matrix;
		private var _wrapAround:Boolean;
		private var _bgColor:uint;
		private var _smoothing:Boolean;

		public function TranslateEffect(
			x:Number,
			y:Number,
			wrapAround:Boolean=false,
			bgColor:uint=0,
			useSmoothing:Boolean=false,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_matrix = new Matrix();
			_matrix.translate(x, y);
			_wrapAround = wrapAround;
			_bgColor = bgColor;
			_smoothing = useSmoothing;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var bd:BitmapData = bitmapData;
			var w:Number = bd.width;
			var h:Number = bd.height;
			var b:BitmapData = new BitmapData(w, h, true, _bgColor);
			b.draw(bitmapData, _matrix, null, null, null, _smoothing);
			var matrix:Matrix = new Matrix();
			if (_wrapAround) {
				if (_matrix.tx==0&&_matrix.ty!=0) {
					if (_matrix.ty>0) {
						matrix.translate(0, _matrix.ty-h);
					} else {
						matrix.translate(0, _matrix.ty+h);
					}
					b.draw(bd, matrix, null, null, null, _smoothing);
				} else if (_matrix.tx!=0&&_matrix.ty==0) {
					if (_matrix.tx>0) {
						// this removes seam -- test more, then apply to others
						matrix.translate(_matrix.tx-w+1, 0);
					} else {
						matrix.translate(_matrix.tx+w, 0);
					}
					b.draw(bd, matrix, null, null, null, _smoothing);
				} else if (_matrix.tx>0&&_matrix.ty>0) {
					b.copyPixels(bd, new Rectangle(w-_matrix.tx, 0, _matrix.tx, h-_matrix.ty), new Point(0, _matrix.ty));
					b.copyPixels(bd, new Rectangle(0, h-_matrix.ty, w-_matrix.tx, _matrix.ty), new Point(_matrix.tx, 0));
					b.copyPixels(bd, new Rectangle(w-_matrix.tx, h-_matrix.ty, _matrix.tx, _matrix.ty), new Point());
				} else if (_matrix.tx<0&&_matrix.ty<0) {
					b.copyPixels(bd, new Rectangle(0, 0, -_matrix.tx, -_matrix.ty), new Point(w+_matrix.tx, h+_matrix.ty));
					b.copyPixels(bd, new Rectangle(0, -_matrix.ty, -_matrix.tx, h+_matrix.ty), new Point(w+_matrix.tx, 0));
					b.copyPixels(bd, new Rectangle(-_matrix.tx, 0, w+_matrix.tx, -_matrix.ty), new Point(0, h+_matrix.tx));
				} else if (_matrix.tx<0&&_matrix.ty>0) {
					b.copyPixels(bd, new Rectangle(0, 0, -_matrix.tx, h-_matrix.ty), new Point(w+_matrix.tx, _matrix.ty));
					b.copyPixels(bd, new Rectangle(0, h-_matrix.ty, -_matrix.tx, _matrix.ty), new Point(w+_matrix.tx, 0));
					b.copyPixels(bd, new Rectangle(-_matrix.tx, h-_matrix.ty, w+_matrix.tx, _matrix.ty), new Point());
				} else if (_matrix.tx>0&&_matrix.ty<0) {
					b.copyPixels(bd, new Rectangle(0, 0, w-_matrix.tx, -_matrix.ty), new Point(_matrix.tx, h+_matrix.ty));
					b.copyPixels(bd, new Rectangle(w-_matrix.tx, 0, _matrix.tx, -_matrix.ty), new Point(0, h+_matrix.ty));
					b.copyPixels(bd, new Rectangle(w-_matrix.tx, -_matrix.ty, _matrix.tx, h+_matrix.ty), new Point());
				}
			}
			bd.copyPixels(b, b.rect, new Point());
		}
	
	}
	
}