package aether.textures.patterns {
	
	import aether.textures.ITexture;

	import flash.display.BitmapData;
	
	public class PixelPattern implements ITexture {
	
		private var _definition:Array;
	
		public function PixelPattern(definition:Array) {
			_definition = definition;
		}
	
		public function draw():BitmapData {
			var w:Number = _definition[0].length;
			var h:Number = _definition.length;
			var pattern:BitmapData = new BitmapData(w, h, true, 0x00FFFFFF);
			var c:uint;
			for (var r:uint = 0; r < h; r++) {
				for (c = 0; c < w; c++) {
					pattern.setPixel32(c, r, _definition[r][c]);
				}
			}
			return pattern;
		}
	
	}
	
}