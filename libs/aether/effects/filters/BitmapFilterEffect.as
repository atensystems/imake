package aether.effects.filters {
	
	import aether.effects.ImageEffect;
	import aether.utils.ImageUtil;
	
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	
	public class BitmapFilterEffect extends ImageEffect {
	
		private var _filter:BitmapFilter;
		
		public function BitmapFilterEffect(
			filter:BitmapFilter,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_filter = filter;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			ImageUtil.applyFilter(bitmapData, _filter);
		}
	
	}
	
}