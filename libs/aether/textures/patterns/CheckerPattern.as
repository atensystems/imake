package aether.textures.patterns {
	
	import aether.textures.ITexture;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CheckerPattern implements ITexture {
		
		private var _checkWidth:Number;
		private var _checkHeight:Number;
		private var _color1:uint;
		private var _color2:uint;
	
		public function CheckerPattern(
			checkWidth:Number,
			checkHeight:Number,
			color1:uint,
			color2:uint
		) {
			_checkWidth = checkWidth;
			_checkHeight = checkHeight;
			_color1 = color1;
			_color2 = color2;
		}
		
		public function draw():BitmapData {
			var w:Number = _checkWidth*2;
			var h:Number = _checkHeight*2;
			var pattern:BitmapData = new BitmapData(w, h, true, 0x00000000);
			var count:uint = 0;
			var totalColumns:uint = 2;
			var totalRows:uint = 2;
			var c:uint;
			for (var r:uint = 0; r < totalRows; r++) {
				for (c = 0; c < totalColumns; c++) {
					pattern.fillRect(new Rectangle(c*_checkWidth, r*_checkHeight, _checkWidth, _checkHeight), count++%2>0 ? _color1 : _color2);
				}
				count++;
			}
			return pattern;
		}
	
	}
	
}