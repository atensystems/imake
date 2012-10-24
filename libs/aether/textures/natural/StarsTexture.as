package aether.textures.natural {
	
	import aether.textures.ITexture;
	import aether.utils.Adjustments;
	import aether.utils.ImageUtil;
	import aether.utils.MathUtil;
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.filters.BlurFilter;
	
	public class StarsTexture implements ITexture {
		
		private var _density:Number;
		private var _width:Number;
		private var _height:Number;
		
		public function StarsTexture(width:Number, height:Number, density:Number=.5) {
			_density = MathUtil.clamp(density, 0, 1);
			_width = width;
			_height = height;
		}
	
		public function draw():BitmapData {
			var noise:BitmapData = new BitmapData(_width, _height, false);
			var perlin:BitmapData = noise.clone();
			noise.noise(int(new Date()), 0, 255, 7, true);
			ImageUtil.applyFilter(noise, new BlurFilter(2, 2));
			var black:uint = 160 - 80*_density;
			var mid:uint = (200 - black)/2 + black;
			Adjustments.setLevels(noise, black, mid, 200);
			perlin.perlinNoise(50, 50, 2, Math.random(), false, true, 7, true);
			noise.draw(perlin, null, null, BlendMode.MULTIPLY);
			perlin.dispose();
			return noise;
		}
	
	}
	
}