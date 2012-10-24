package aether.effects.adjustments {
	
	import aether.effects.ImageEffect;
	import aether.utils.Adjustments;
	
	import flash.display.BitmapData;
		
	public class SaturationEffect extends ImageEffect {
	
		private var _amount:Number;

		public function SaturationEffect(amount:Number=1, blendMode:String=null, alpha:Number=1) {
			init(blendMode, alpha);
			_amount = amount;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			Adjustments.saturate(bitmapData, _amount);
		}
	
	}
	
}