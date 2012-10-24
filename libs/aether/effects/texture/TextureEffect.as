package aether.effects.texture {
	
	import aether.effects.ImageEffect;
	import aether.textures.ITexture;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	public class TextureEffect extends ImageEffect {
	
		private var _texture:ITexture;

		public function TextureEffect(texture:ITexture, blendMode:String=null, alpha:Number=1) {
			init(blendMode, alpha);
			_texture = texture;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var pattern:BitmapData = _texture.draw();
			var shape:Shape = new Shape();
			shape.graphics.beginBitmapFill(pattern);
			shape.graphics.drawRect(0, 0, bitmapData.width, bitmapData.height);
			shape.graphics.endFill();
			bitmapData.draw(shape);
		}
	
	}
	
}