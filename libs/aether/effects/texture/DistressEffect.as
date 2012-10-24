package aether.effects.texture {

	import aether.effects.ImageEffect;
	import aether.utils.Adjustments;
	import aether.utils.ImageUtil;
	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	public class DistressEffect extends ImageEffect {
	
		private var _amount:Number;
		
		public function DistressEffect(amount:Number=1, blendMode:String=null, alpha:Number=1) {
			init(blendMode, alpha);
			_amount = amount;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var baseX:Number = 20;
			var baseY:Number = 20;
			var numOctaves:uint = 5;
			var fractal:Boolean = true;
			var perlin:BitmapData = bitmapData.clone();
			perlin.perlinNoise(baseX, baseY, numOctaves, int(new Date()), true, fractal, 1, true);
			Adjustments.setLevels(perlin, 0, 50, 100);
			var displaceX:Number = _amount;
			var displaceY:Number = _amount*3;
			ImageUtil.applyFilter(bitmapData, new DisplacementMapFilter(perlin, new Point(), 1, 1, displaceX, displaceY, DisplacementMapFilterMode.CLAMP));

			var noise:BitmapData = new BitmapData(bitmapData.width, bitmapData.height, true, 0x00000000);
			noise.fillRect(noise.rect, 0xFFFFFF);
			noise.noise(int(new Date()), 0, 255, 1, true);
			ImageUtil.applyFilter(noise, new BlurFilter(displaceX, displaceY));
			Adjustments.setLevels(noise, 100, 102, 105);

			var alpha:BitmapData = ImageUtil.getChannelData(bitmapData, BitmapDataChannel.ALPHA);
			alpha.draw(noise, null, new ColorTransform(1, 1, 1, Math.min(1, _amount*.2)), BlendMode.MULTIPLY);
			
			bitmapData.copyChannel(alpha, alpha.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
		}
	
	}
	
}