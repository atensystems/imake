package com.atensys.imake.draw.stylepanels {
	import mx.containers.VBox;
	import mx.controls.Image;
	import mx.controls.TileList;
	import mx.core.Application;
	import mx.events.ListEvent;

	public class BrushesPopup extends VBox {
		private var _list:TileList;
		private var _image:Image;

		public function BrushesPopup() {
			super();
			list=new TileList()
			list.dataProvider=Application.application.brushes;
			list.columnCount=80
			list.columnWidth=40;
			list.rowHeight=40;
			list.setStyle("paddingBottom", 2);
			list.setStyle("paddingTop", 2);
			list.setStyle("paddingLeft", 2);
			list.setStyle("paddingRight", 2);
			addChild(list);
			list.percentHeight=100;
			list.percentWidth=100;
			list.addEventListener(ListEvent.CHANGE, selectionChange);
		}

		private function selectionChange(evt:ListEvent):void {
			this._image=new Image();
			this._image.source=Application.application.brushes[list.selectedIndex].icon;
		}

		public function get image():Image {
			return _image;
		}

		public function get list():TileList {
			return this._list;
		}
		public function set list(l:TileList):void {
			this._list=  l;
		}



	}
}