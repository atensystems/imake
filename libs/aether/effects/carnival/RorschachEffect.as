package aether.effects.carnival {
	
	import aether.effects.ImageEffect;
	import aether.utils.Adjustments;
	import aether.utils.ImageUtil;
	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class RorschachEffect extends ImageEffect {
	
		private var _foregroundColor:uint;
		private var _backgroundColor:uint;
		
		public function RorschachEffect(
			foregroundColor:uint=0xFF000000,
			backgroundColor:uint=0xFFFFFFFF,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_foregroundColor = foregroundColor;
			_backgroundColor = backgroundColor;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			ImageUtil.applyFilter(bitmapData, new BlurFilter(8, 8));
			Adjustments.threshold(bitmapData, 120);
			var clone:BitmapData = bitmapData.clone();
			var width:Number = bitmapData.width;
			var height:Number = bitmapData.height;
			var matrix:Matrix = new Matrix();
			matrix.scale(-1, 1);
			matrix.translate(width, 0);
			bitmapData.draw(clone, matrix, null, null, new Rectangle(0, 0, width/2, height));
			var foreground:BitmapData = new BitmapData(width, height, true, 0x00000000);
			var background:BitmapData = foreground.clone();
			foreground.fillRect(foreground.rect, _foregroundColor);
			background.fillRect(background.rect, _backgroundColor);
			background.copyChannel(bitmapData, bitmapData.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
			Adjustments.invert(bitmapData);
			foreground.copyChannel(bitmapData, bitmapData.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
			bitmapData.fillRect(bitmapData.rect, 0x00000000);
			var sprite:Sprite = new Sprite();
			var fg:Shape = new Shape();
			fg.graphics.beginBitmapFill(foreground);
			fg.graphics.drawRect(0, 0, width, height);
			fg.graphics.endFill();
			fg.alpha = (_foregroundColor >> 24 & 0xFF)/0xFF;
			sprite.addChild(fg);
			var bg:Shape = new Shape();
			bg.graphics.beginBitmapFill(background);
			bg.graphics.drawRect(0, 0, width, height);
			bg.graphics.endFill();
			bg.alpha = (_backgroundColor >> 24 & 0xFF)/0xFF;
			sprite.addChild(bg);
			bitmapData.draw(sprite);
		}
	
	}
	
}