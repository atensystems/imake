package aether.effects.common {
	
	import aether.effects.ImageEffect;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class OverlayImageEffect extends ImageEffect {
	
		private var _image:BitmapData;
		private var _matrix:Matrix;
		
		public function OverlayImageEffect(
			image:BitmapData,
			point:Point=null,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			if (point == null) {
				point = new Point();
			}
			_image = image;
			_matrix = new Matrix();
			_matrix.translate(point.x, point.y);
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			bitmapData.draw(_image, _matrix);
		}
	
	}
	
}