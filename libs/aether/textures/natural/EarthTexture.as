package aether.textures.natural {
	
	import aether.effects.adjustments.GradientMapEffect;
	import aether.textures.ITexture;
	import aether.utils.Adjustments;
	
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	
	public class EarthTexture implements ITexture {
		
		private var _colors:Array;
		private var _ratios:Array;
		private var _levels:Array;
		private var _width:Number;
		private var _height:Number;
		
		public function EarthTexture(
			width:Number,
			height:Number,
			colors:Array=null,
			ratios:Array=null,
			levels:Array=null
		) {
			_width = width;
			_height = height;
			_colors = colors || [0x344F70, 0x9A7D60, 0x9A7D60, 0x64673E, 0x6D794C, 0xFFFFFF];
			_ratios = ratios || [38, 63, 80, 160, 240, 255];
			_levels = levels || [120, 140, 200];
		}
	
		public function draw():BitmapData {
			var baseX:Number = 50;
			var baseY:Number = 50;
			var numOctaves:uint = 5;

			var bitmapData:BitmapData = new BitmapData(_width, _height, false, 0);
			bitmapData.perlinNoise(baseX, baseY, numOctaves, int(new Date()), true, true, 1, true);
			Adjustments.setLevels(bitmapData, _levels[0], _levels[1], _levels[2]);
			new GradientMapEffect(_colors, _ratios).apply(bitmapData);
			return bitmapData;
		}
	
	}
	
}