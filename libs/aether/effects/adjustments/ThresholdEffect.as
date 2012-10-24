package aether.effects.adjustments {
	
	import aether.effects.ImageEffect;
	import aether.utils.Adjustments;

	import flash.display.BitmapData;
		
	public class ThresholdEffect extends ImageEffect {
	
		private var _threshold:uint;

		public function ThresholdEffect(
			threshold:uint,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_threshold = threshold;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			Adjustments.threshold(bitmapData, _threshold);
		}
	
	}
	
}