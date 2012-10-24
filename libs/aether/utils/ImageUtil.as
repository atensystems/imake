package aether.utils {

	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.filters.BitmapFilter;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public class ImageUtil {

		static public function getBitmapData(pObject:DisplayObject):BitmapData {
			return ScreenCapture.drawFromObject(pObject);
		}

		static public function getChannelData(bitmapData:BitmapData, channel:uint):BitmapData {
			var clone:BitmapData = new BitmapData(bitmapData.width, bitmapData.height);
			clone.copyChannel(bitmapData, bitmapData.rect, new Point(), channel, BitmapDataChannel.RED);
			clone.copyChannel(bitmapData, bitmapData.rect, new Point(), channel, BitmapDataChannel.GREEN);
			clone.copyChannel(bitmapData, bitmapData.rect, new Point(), channel, BitmapDataChannel.BLUE);
			return clone;
		}
		
		static public function copyChannel(source:BitmapData, dest:BitmapData, channel:uint):void {
			dest.copyChannel(source, source.rect, new Point(), channel, channel);
		}

		static public function copyPixels(source:BitmapData, dest:BitmapData):void {
			dest.copyPixels(source, source.rect, new Point());
		}

		static public function applyFilter(source:BitmapData, filter:BitmapFilter):void {
			source.applyFilter(source, source.rect, new Point(), filter);
		}

	}

}