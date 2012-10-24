package aether.effects {

	import aether.utils.ImageUtil;

	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;

	public class ImageEffect {
		
		protected var _blendMode:String;
		protected var _alpha:Number;
		
		protected function init(blendMode:String=null, alpha:Number=1):void {
			_blendMode = blendMode;
			_alpha = alpha;
		}

		protected function applyEffect(bitmapData:BitmapData):void {}

		public function apply(bitmapData:BitmapData):void {
			var clone:BitmapData = new BitmapData(bitmapData.width, bitmapData.height, true, 0x00000000);
			ImageUtil.copyPixels(bitmapData, clone);
			if ((!_blendMode || _blendMode == BlendMode.NORMAL) && _alpha == 1){
				applyEffect(clone);
			} else {
				var overlay:BitmapData = clone.clone();
				applyEffect(overlay);
				clone.draw(overlay, null, new ColorTransform(1, 1, 1, _alpha), _blendMode);
			}
			ImageUtil.copyPixels(clone, bitmapData);
		}

	}

}