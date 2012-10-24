package aether.effects.carnival {
	
	import aether.effects.ImageEffect;
	import aether.utils.MathUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.display.Shape;
	
	public class KaleidoscopeEffect extends ImageEffect {
	
		private var _startAngle:Number;
		private var _segments:uint;

		public function KaleidoscopeEffect(
			segments:uint=8,
			startAngle:Number=0,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_segments = segments;
			if (_segments % 2 > 0) _segments++;
			_startAngle = MathUtil.degreesToRadians(startAngle);
		}
		
		private function drawSegment(index:uint, segment:BitmapData, center:Point, angle:Number):Bitmap {
			var bitmap:Bitmap = new Bitmap(segment);
			if (index % 2 > 0) {
				bitmap.scaleY = -1;
				bitmap.rotation = (index+1)*angle;
			} else {
				bitmap.rotation = index*angle;
			}
			bitmap.x = center.x;
			bitmap.y = center.y;
			return bitmap;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var w:Number = bitmapData.width;
			var h:Number = bitmapData.height;
			var r:Number = Math.min(w,h)/2;
			var segmentAngle:Number = 360/_segments;
			var theta:Number = MathUtil.degreesToRadians(segmentAngle);
			var angle:Number = Math.PI-theta;
			var x:Number = Math.cos(theta)*r;
			var y:Number = Math.sin(theta)*r;
			var matrix:Matrix = new Matrix();
			matrix.translate(-w/2, -h/2);
			matrix.rotate(-_startAngle);
			var image:BitmapData = new BitmapData(w, h, true, 0x00000000);
			image.draw(bitmapData, matrix);
			var shape:Shape = new Shape();
			shape.graphics.beginBitmapFill(image, null, false);
			shape.graphics.lineTo(r, 0);
			shape.graphics.lineTo(x, y);
			shape.graphics.lineTo(0, 0);
			shape.graphics.endFill();
			var segment:BitmapData = new BitmapData(shape.width, shape.height, true, 0x00000000);
			segment.draw(shape);
			var sprite:Sprite = new Sprite();
			var center:Point = new Point(w/2, h/2);
			for (var i:uint; i < _segments; i++) {
				sprite.addChild(drawSegment(i, segment, center, segmentAngle));
			}
			bitmapData.fillRect(bitmapData.rect, 0x00000000);
			bitmapData.draw(sprite);
		}
	
	}
	
}