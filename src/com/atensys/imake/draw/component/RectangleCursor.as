package com.atensys.imake.draw.component {
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;

	public class RectangleCursor extends Sprite {

		public function RectangleCursor() {
			super();
			graphics.lineStyle(2, 0x000000, 1);
			graphics.moveTo(0, -6);
			graphics.lineTo(0, 6);
			graphics.moveTo(-6, 0);
			graphics.lineTo(6, 0);
			graphics.lineStyle(2, 0xFFFFFF, 1);
			graphics.drawRect(-3, -3, 6, 6);
		}

	}
}