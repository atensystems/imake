package aether.textures.natural {
	
	import aether.effects.adjustments.GradientMapEffect;
	import aether.textures.ITexture;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class MarbleTexture implements ITexture {
		
		private var _color:uint;
		private var _width:Number;
		private var _height:Number;
		
		public function MarbleTexture(width:Number, height:Number, color:uint) {
			_color = color;
			_width = width;
			_height = height;
		}
	
		public function draw():BitmapData {
			var baseX:Number = 100;
			var baseY:Number = 100;
			var numOctaves:uint = 5;
			var fractal:Boolean = false;
			var marble:BitmapData = new BitmapData(_width, _height, false, 0xFFFFFFFF);
			marble.perlinNoise(baseX, baseY, numOctaves, int(new Date()), true, fractal, 1, true);
			var marbleClip:Sprite = new Sprite();
			marbleClip.graphics.beginFill(_color);
			marbleClip.graphics.drawRect(0, 0, _width, _height);
			marbleClip.graphics.endFill();
			var gmc:Bitmap = new Bitmap(marble);
			marbleClip.addChild(gmc);
			var colors:Array = [0x999999, 0x777777, 0x555555, 0xAAAAAA, 0x888888, 0x6F6F6F, 0x999999];
			var ratios:Array = [10, 40, 60, 140, 160, 200, 215];
			new GradientMapEffect(colors, ratios).apply(marble);
			gmc.blendMode = BlendMode.HARDLIGHT;
			var noise:BitmapData = new BitmapData(_width, _height);
			var nmc:Bitmap = new Bitmap(noise);
			noise.draw(nmc, new Matrix());
			noise.noise(Number(new Date()), 200, 255, 7, true);
			nmc.blendMode = BlendMode.MULTIPLY;
			nmc.filters = [new BlurFilter(2, 2, 1)];
			var composite:BitmapData = new BitmapData(_width, _height);
			composite.draw(marbleClip, new Matrix());
			marble.dispose();
			noise.dispose();
			return composite;
		}
	
	}
	
}