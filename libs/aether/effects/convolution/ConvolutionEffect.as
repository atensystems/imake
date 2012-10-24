package aether.effects.convolution {
	
	import aether.effects.ImageEffect;
	
	import flash.display.BitmapData;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Point;
	
	public class ConvolutionEffect extends ImageEffect {

		public static const SHARPEN:Array = [0,-1,0,-1,5,-1,0,-1,0];
		public static const OUTLINE:Array = [-5,5,0,-5,5,0,-5,5,0];
		public static const EMBOSS:Array = [-2,-1,0,-1,1,1,0,1,2];
	
		private var _filter:ConvolutionFilter;

		public function ConvolutionEffect(
			matrix:Array,
			divisor:Number=1,
			bias:Number=0,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			var numEntries:uint = matrix.length/3;
			_filter = new ConvolutionFilter(numEntries, numEntries, matrix, divisor, bias);
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			bitmapData.applyFilter(bitmapData, bitmapData.rect, new Point(), _filter);
		}
	
	}
	
}