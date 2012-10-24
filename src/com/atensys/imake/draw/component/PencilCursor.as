package com.atensys.imake.draw.component {
	import flash.display.CapsStyle;
	import flash.display.Sprite;

	public class PencilCursor extends Sprite {
		public static var SIZE:int=1;
		public static var TYPE:String=CapsStyle.SQUARE;
		public static var COLOR:uint=0;


		public function PencilCursor() {
			super();
			graphics.lineStyle(1, 0x000000, 1);
			graphics.beginFill(COLOR);
			if (TYPE == CapsStyle.SQUARE || TYPE == CapsStyle.NONE) {
				graphics.drawRect(0 - SIZE / 2, 0 - SIZE / 2, SIZE, SIZE);
			} else {
				graphics.drawCircle(0, 0, SIZE / 2);
			}
			graphics.endFill();
			graphics.lineStyle(1, 0xFFFFFF, 1);
			if (TYPE == CapsStyle.SQUARE || TYPE == CapsStyle.NONE) {
				graphics.drawRect(2 - SIZE / 2, 2 - SIZE / 2, SIZE - 4, SIZE - 4);
			} else {
				graphics.drawCircle(0, 0, SIZE / 2 - 2);
			}
		}

	}
}