package com.atensys.imake.draw.colors {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.controls.ColorPicker;
	import mx.controls.Image;
	import mx.events.ColorPickerEvent;
	import com.atensys.imake.draw.stylepanels.StyleProvider;

	/**
	 *Colors pallete.
	 *
	 * @author Andrei Sirghi
	 *
	 */
	public class ColorsPallete extends Canvas {
		private var top:ColorPicker;
		private var bottom:ColorPicker;
		private var change:Image;
		private var ls:int=0;

		public function ColorsPallete() {
			super();
			initColors();
		}

		private function initColors():void {
			top=new ColorPicker();
			top.addEventListener(ColorPickerEvent.CHANGE, changeTop);
			top.addEventListener(MouseEvent.CLICK, changeTop);
			bottom=new ColorPicker();
			bottom.addEventListener(ColorPickerEvent.CHANGE, changeBottom);
			bottom.addEventListener(MouseEvent.CLICK, changeBottom);
			top.selectedColor=0;
			bottom.selectedColor=0xFFFFFF;
			top.height=30;
			top.width=30;
			bottom.height=30;
			bottom.width=30;
			top.x=10;
			top.y=10;
			bottom.x=25;
			bottom.y=25;
			addChild(bottom);
			addChild(top);
			change=new Image();
			change.source="assets/changeColor.png";
			change.width=14;
			change.height=14;
			change.x=41;
			change.y=9;
			addChild(change);
			change.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, changeColors);
		}

		private function changeColors(event:MouseEvent):void {
			var tc:uint=top.selectedColor;
			top.selectedColor=bottom.selectedColor;
			bottom.selectedColor=tc;
			top.dispatchEvent(new Event(ColorPickerEvent.CHANGE));
			bottom.dispatchEvent(new Event(ColorPickerEvent.CHANGE));
		}

		public function setTopColor(color:uint):void {
			ls=0;
			top.selectedColor=color;
		}

		public function getTopColor():uint {
			return top.selectedColor;
		}

		public function setBottomColor(color:uint):void {
			ls=1;
			bottom.selectedColor=color;
		}

		public function getBottomColor():uint {
			return bottom.selectedColor;
		}

		public function changeColor(c:uint):void {
			if (ls == 0) {
				this.top.selectedColor=c;
				changeTop(null);
			} else {
				this.bottom.selectedColor=c;
				changeBottom(null);
			}
		}

		public function getColor():uint {
			if (ls == 0) {
				return this.top.selectedColor;
			} else {
				return this.bottom.selectedColor;
			}
		}

		private function changeTop(evt:Event):void {
			StyleProvider.getInstance().currentStylePanel.dStyleChanged(null);
			ls=0;
		}

		private function changeBottom(evt:Event):void {
			ls=1;
			StyleProvider.getInstance().currentStylePanel.dStyleChanged(null);
		}

		public function addColorsChangeEvents():void {
			top.addEventListener(ColorPickerEvent.CHANGE, changeTop);
			bottom.addEventListener(ColorPickerEvent.CHANGE, changeBottom);
		}
	}

}