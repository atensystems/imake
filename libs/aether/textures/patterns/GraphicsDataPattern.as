package aether.textures.patterns {
	
	import aether.textures.ITexture;
	
	import flash.display.BitmapData;
	import flash.display.IGraphicsData;
	import flash.display.Shape;
	
	public class GraphicsDataPattern implements ITexture {
		
		private var _data:Vector.<IGraphicsData>;
	
		public function GraphicsDataPattern(data:Vector.<IGraphicsData>) {
			_data = data;
		}
		
		public function draw():BitmapData {
			var shape:Shape = new Shape();
			shape.graphics.drawGraphicsData(_data);
			var bitmap:BitmapData = new BitmapData(shape.width, shape.height, true, 0x00000000);
			bitmap.draw(shape);
			return bitmap;
		}
	
	}
	
}