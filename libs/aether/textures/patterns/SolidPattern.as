package aether.textures.patterns {
	
	import aether.textures.ITexture;
	
	import flash.display.BitmapData;
	
	public class SolidPattern implements ITexture {
		
		private var _color:uint;
	
		public function SolidPattern(color:uint) {
			_color = color;
		}
		
		public function draw():BitmapData {
			return new BitmapData(1, 1, true, _color);
		}
	
	}
	
}