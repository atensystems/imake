package aether.utils {

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ScreenCapture {
	
		static public function capture(
			clip:DisplayObject,
			transparent:Boolean=true,
			area:Rectangle=null
		):BitmapData {
			if (area == null) {
				area = new Rectangle(0, 0, clip.width, clip.height);
			}
			var color:uint = transparent ? 0x00FFFFFF : 0xFFFFFFFF;
			var image:BitmapData = new BitmapData(area.width, area.height, true, color);
			var matrix:Matrix = new Matrix();
			matrix.translate(-area.x, -area.y);
			image.draw(clip, matrix);
			return image;
		}
	
		static public function drawFromObject(object:DisplayObject):BitmapData {
			var bitmapData:BitmapData = new BitmapData(object.width, object.height, true, 0x00000000);
			bitmapData.draw(object);
			return bitmapData;
		}
	
	}
	
}