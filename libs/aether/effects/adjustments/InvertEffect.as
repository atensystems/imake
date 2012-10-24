package aether.effects.adjustments {
	
	import aether.effects.ImageEffect;
	import aether.utils.Adjustments;
		
	import flash.display.BitmapData;
	
	public class InvertEffect extends ImageEffect {
	
		public function InvertEffect(blendMode:String=null, alpha:Number=1) {
			init(blendMode, alpha);
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			Adjustments.invert(bitmapData);
		}
	
	}
	
}