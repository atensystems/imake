package aether.effects.adjustments {
	
	import aether.effects.ImageEffect;
	import aether.utils.Adjustments;
		
	import flash.display.BitmapData;
	
	public class LevelsEffect extends ImageEffect {
	
		private var _blackPoint:uint;
		private var _midPoint:uint;
		private var _whitePoint:uint;

		public function LevelsEffect(
			blackPoint:uint,
			midPoint:uint,
			whitePoint:uint,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_blackPoint = blackPoint;
			_midPoint = midPoint;
			_whitePoint = whitePoint;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			Adjustments.setLevels(bitmapData, _blackPoint, _midPoint, _whitePoint);
		}
	
	}
	
}