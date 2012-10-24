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
	
	public class StoneTexture implements ITexture {
		
		private var _color:uint;
		private var _width:Number;
		private var _height:Number;
		private var _fractal:Boolean;
		
		public function StoneTexture(
			width:Number,
			height:Number,
			color:uint=0x999999,
			fractal:Boolean=true
		) {
			_color = color;
			_width = width;
			_height = height;
			_fractal = fractal;
		}
	
		public function draw():BitmapData {
			var baseX:Number = 100;
			var baseY:Number = 100;
			var numOctaves:uint = 5;

			var perlined:BitmapData = new BitmapData(_width, _height, false, 0);
			perlined.perlinNoise(baseX, baseY, numOctaves, int(new Date()), true, _fractal, 1, true);
			
			var filtered:BitmapData = new BitmapData(_width, _height, false, 0x999999);
			filtered.draw(perlined, null, new ColorTransform(1, 1, 1, .6));

			var pMatrix:Array=[
				-50, 50, 0,
				-50, 50, 0,
				-50, 50, 0
			];
			var filter:ConvolutionFilter = new ConvolutionFilter(3, 3, pMatrix, 2);
			ImageUtil.applyFilter(filtered, filter);
			Adjustments.adjustBrightness(filtered, 20);

			var fill:BitmapData = new BitmapData(_width, _height, false, _color);
			fill.draw(filtered, null, new ColorTransform(1, 1, 1, .8));
			ImageUtil.applyFilter(fill, new BlurFilter(2, 2));
			Adjustments.setLevels(fill, 20, 120, 255);

			var noise:BitmapData = new BitmapData(_width, _height, false);
			noise.noise(int(new Date()), 0, 255, 7, true);
			fill.draw(noise, null, new ColorTransform(1, 1, 1, .1), BlendMode.MULTIPLY);
			
			return fill;
		}
	
	}
	
}