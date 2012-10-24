package aether.effects.adjustments {
	
	import aether.effects.ImageEffect;
	import aether.utils.Adjustments;
		
	import flash.display.BitmapData;
	
	public class PosterizeEffect extends ImageEffect {
	
		private var _levels:uint;

		public function PosterizeEffect(
			levels:uint=2,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_levels = levels;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			Adjustments.posterize(bitmapData, _levels);
		}
	
	}
	
}