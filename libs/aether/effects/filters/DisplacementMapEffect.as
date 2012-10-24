package aether.effects.filters {
	
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class DisplacementMapEffect extends BitmapFilterEffect {

		public function DisplacementMapEffect(
			map:BitmapData,
			scaleX:Number=10,
			scaleY:Number=10,
			blendMode:String=null,
			alpha:Number=1
		) {
			var filter:DisplacementMapFilter = new DisplacementMapFilter(map, new Point(), 1, 1, scaleX, scaleY, DisplacementMapFilterMode.CLAMP);
			super(filter, blendMode, alpha);
		}
	
	}
	
}