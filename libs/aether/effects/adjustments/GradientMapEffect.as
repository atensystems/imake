package aether.effects.adjustments {

	import aether.effects.ImageEffect;
	import aether.utils.Adjustments;

	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class GradientMapEffect extends ImageEffect {
		
		private var _colors:Array;
		private var _ratios:Array;
		
		public function GradientMapEffect(
			colors:Array,
			ratios:Array,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_colors = colors;
			_ratios = ratios;
		}
	
		private function createLookUp(colors:Array, ratios:Array):Object {
			var lU:Object = {};
			lU.r = [];
			lU.g = [];
			lU.b = [];
			var gC:Array = [];
			var r:Number;
			var g:Number;
			var b:Number;
			var c:Number;
			var c1:Object;
			var c2:Object;
			var r1:Number;
			var r2:Number;
			var index:Number = 0;
			var cI:Number = 0;
			var br:Number;
			var cL:Number = colors.length;
			for (var i:uint = 0; i < cL; i++){
				c = colors[i];
				gC.push({r:c>>16&255,g:c>>8&255,b:c&255});
			}
			for (i = 0; i < 256; i++){
				cI = findColorIndex(i, ratios, cL, index);
				index = (cI < 0) ? 0 : cI;
				c1 = gC[index];
				c2 = gC[index + 1];
				r1 = ratios[index];
				r2 = ratios[index + 1];
				if (c2 == null || cI < 0){
					r = c1.r;
					g = c1.g;
					b = c1.b;
				} else {
					br = (i - r1)/(r2 - r1);
					r = ((c2.r - c1.r)|0) * br + c1.r;
					g = ((c2.g - c1.g)|0) * br + c1.g;
					b = ((c2.b - c1.b)|0) * br + c1.b;
				}
				lU.r.push(r << 16);
				lU.g.push(g << 8);
				lU.b.push(b);
			}
			return lU;
		}
	
		private function findColorIndex(
			pos:uint,
			ratios:Array,
			rLength:uint,
			index:uint
		):Number {
			var r1:Number;
			var r2:Number;
			if (pos < ratios[index]) return -1;
			for (var i:uint = index; i < rLength; i++){
				r1 = ratios[i];
				r2 = ratios[i + 1];
				if ((pos >= r1 && pos < r2) || isNaN(r2)) return i;
			}
			return 0;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var grayscaleImage:BitmapData = bitmapData.clone();
			Adjustments.desaturate(grayscaleImage);
			var map:Object = createLookUp(_colors, _ratios);
			bitmapData.copyPixels(grayscaleImage, grayscaleImage.rect, new Point());
			bitmapData.paletteMap(bitmapData, bitmapData.rect, new Point(), map.r, map.g, map.b);
		}
	
	}
	
}