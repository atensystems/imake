package aether.textures.natural {
	
	import aether.textures.ITexture;
	import aether.utils.Adjustments;
	import aether.utils.ImageUtil;

	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.filters.BlurFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class BarkTexture implements ITexture {
		
		private var _color:uint;
		private var _width:Number;
		private var _height:Number;
		
		public function BarkTexture(width:Number, height:Number, color:uint=0xBB6600) {
			_color = color;
			_width = width;
			_height = height;
		}
	
		public function draw():BitmapData {
			var baseX:Number = 40;
			var baseY:Number = 200;
			var numOctaves:uint = 5;
			var fractal:Boolean = false;
			var threshold:Number = 57;

			var bitmap:BitmapData = new BitmapData(_width, _height, false, 0);
			bitmap.perlinNoise(baseX, baseY, numOctaves, int(new Date()), true, fractal, 1, true);
			
			var filtered:BitmapData = new BitmapData(_width, _height, false, 0x999999);
			filtered.draw(bitmap, null, new ColorTransform(1, 1, 1, .5));

			var matrix:Array=[
				-50, 50, 0,
				-50, 50, 0,
				-50, 50, 0
			];
			var filter:ConvolutionFilter = new ConvolutionFilter(3, 3, matrix, 2);
			ImageUtil.applyFilter(filtered, filter);

			var fill:BitmapData = new BitmapData(_width, _height, false, _color);
			fill.draw(filtered, null, new ColorTransform(1, 1, 1, .7));
			Adjustments.setLevels(fill, 20, 150, 255);
			ImageUtil.applyFilter(fill, new BlurFilter(1, 1));

			var noise:BitmapData = new BitmapData(_width, _height, false);
			noise.noise(int(new Date()), 0, 255, 7, true);
			fill.draw(noise, null, new ColorTransform(1, 1, 1, .1), BlendMode.MULTIPLY);

			return fill;
		}
	
	}
	
}