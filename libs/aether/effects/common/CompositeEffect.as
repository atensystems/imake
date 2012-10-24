package aether.effects.common {

	import aether.effects.ImageEffect;
	import aether.utils.ImageUtil;
	
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	
	public class CompositeEffect extends ImageEffect {
	
		private var _bitmapToAffect:BitmapData;
		private var _effects:Array;
	
		public function CompositeEffect(
			effects:Array,
			bitmapToAffect:BitmapData=null,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_effects = effects;
			_bitmapToAffect = bitmapToAffect;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			for each (var effect:ImageEffect in _effects) {
				effect.apply(bitmapData);
			}
		}
	
		override public function apply(bitmapData:BitmapData):void {
			if (_bitmapToAffect == null) {
				super.apply(bitmapData);
			} else {
				var clone:BitmapData = new BitmapData(bitmapData.width, bitmapData.height, true, 0x00000000);
				ImageUtil.copyPixels(_bitmapToAffect, clone);
				applyEffect(clone);
				bitmapData.draw(clone, null, new ColorTransform(1, 1, 1, _alpha), _blendMode);
			}
		}

	}
	
}