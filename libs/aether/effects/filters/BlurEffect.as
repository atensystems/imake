package aether.effects.filters {
	
	import flash.filters.BlurFilter;
	
	public class BlurEffect extends BitmapFilterEffect {
	
		public function BlurEffect(
			blurX:Number=5,
			blurY:Number=5,
			quality:int=1,
			blendMode:String=null,
			alpha:Number=1
		) {
			var blur:BlurFilter = new BlurFilter(blurX, blurY, quality);
			super(blur, blendMode, alpha);
		}
	
	}
	
}