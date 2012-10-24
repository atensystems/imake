package aether.effects.transformations {
	
	import aether.effects.ImageEffect;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class SimplifyEffect extends ImageEffect {
	
		private var _amount:Number;
		
		public function SimplifyEffect(pAmount:Number, blendMode:String=null, alpha:Number=1) {
			init(blendMode, alpha);
			_amount = pAmount;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var bw:Number = bitmapData.width;
			var bh:Number = bitmapData.height;
			var w:uint = bw/_amount;
			var h:uint = bh/_amount;
			var m:Matrix = new Matrix();
			m.scale(w/bw, h/bh);
			var b:BitmapData = new BitmapData(w, h, true, 0x000000);
			b.draw(bitmapData, m);
			m = new Matrix();
			m.scale(bw/w, bh/h);
			bitmapData.draw(b, m);
		}
	
	}
	
}