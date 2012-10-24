package aether.effects.common {

	import aether.effects.ImageEffect;
	import aether.utils.ImageUtil;
	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class ChannelEffect extends ImageEffect {
	
		private var _effect:ImageEffect;
		private var _channel:uint;
	
		public function ChannelEffect(
			effect:ImageEffect,
			channel:uint,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_effect = effect;
			_channel = channel;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var clone:BitmapData = ImageUtil.getChannelData(bitmapData, _channel);
			_effect.apply(clone);
			bitmapData.copyChannel(clone, clone.rect, new Point(), _channel, _channel);
		}
	
	}
	
}