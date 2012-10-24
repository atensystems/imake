package aether.effects.common {
	
	import aether.effects.ImageEffect;
	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	
	public class AlphaEffect extends ImageEffect {
		
		private var _mask:BitmapData;
	
		public function AlphaEffect(mask:BitmapData) {
			_mask = mask;
		}
		
		override public function apply(bitmapData:BitmapData):void {
			bitmapData.copyChannel(_mask, _mask.rect, new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
		}

	}
	
}