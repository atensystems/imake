package aether.effects.texture {
	
	import aether.effects.ImageEffect;

	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	public class NoiseEffect extends ImageEffect {
	
		private var _strength:Number;

		public function NoiseEffect(strength:Number=1, blendMode:String=null, alpha:Number=1) {
			init(blendMode, alpha);
			_strength = strength;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			var noise:BitmapData = new BitmapData(bitmapData.width, bitmapData.height, true, 0x00000000);
			noise.fillRect(noise.rect, 0xFFFFFF);
			var seed:uint = (Math.random()*1000)|0;
			noise.noise(seed, 0, 255, 1, true);
			var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, _strength, 0, 0, 0, 0);
			bitmapData.draw(noise, new Matrix(), colorTransform, BlendMode.MULTIPLY);
		}
	
	}
	
}