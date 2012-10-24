package com.atensys.imake.draw.component {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	public class BrushCursor extends Sprite {
		public static var SIZE:int=1;
		public static var TYPE:BitmapData=null;
		public static var COLOR:uint=0;

		public function BrushCursor() {
			if (TYPE == null) {
				graphics.lineStyle(1, 0x000000, 1);
				graphics.beginFill(COLOR);
				graphics.drawRect(0 - SIZE / 2, 0 - SIZE / 2, SIZE, SIZE);
				graphics.endFill();
				graphics.lineStyle(1, 0xFFFFFF, 1);
				graphics.drawRect(2 - SIZE / 2, 2 - SIZE / 2, SIZE - 4, SIZE - 4);
			} else {
				var m:Matrix=new Matrix();
				m.scale(SIZE / TYPE.width, SIZE / TYPE.height);
				m.translate(0 - SIZE / 2, 0 - SIZE / 2);
				graphics.beginBitmapFill(TYPE, m, false);
				graphics.drawRect(0 - SIZE / 2, 0 - SIZE / 2, SIZE, SIZE);
			}
		}
	}
}