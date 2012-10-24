package com.atensys.imake.draw.stylepanels {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.BitmapAsset;
	import mx.core.UIComponent;
	import mx.events.ListEvent;
	import mx.managers.PopUpManager;


	public class BrushFormRenderer extends HBox {

		private var image:Image;
		private var brushLabel:Label;
		[Bindable]
		[Embed(source="assets/combo.png")]
		private var selectBrushIcon:Class;
		private var bitmap:BitmapData;
		private var chooseBrush:Button;
		public var popup:BrushesPopup;
		private var images:Array=new Array("assets/brushes/brush_1.png", "assets/brushes/brush_2.png", "assets/brushes/brush_3.png", "assets/brushes/dry_brush_1.png", "assets/brushes/dry_brush_2.png", "assets/brushes/chalk_1.png", "assets/brushes/chalk_2.png", "assets/brushes/chalk_3.png", "assets/brushes/oil_brush_1.png", "assets/brushes/oil_brush_2.png", "assets/brushes/oil_brush_3.png", "assets/brushes/oil_brush_4.png", "assets/brushes/oil_brush_5.png", "assets/brushes/oil_brush_6.png", "assets/brushes/oil_brush_7.png", "assets/brushes/oil_brush_8.png", "assets/brushes/air_brush_1.png", "assets/brushes/air_brush_2.png", "assets/brushes/air_brush_3.png", "assets/brushes/air_brush_4.png", "assets/brushes/air_brush_5.png", "assets/brushes/circle.png", "assets/brushes/ellipse.png", "assets/brushes/thin_ellipse.png", "assets/brushes/diamond.png", "assets/brushes/star_1.png", "assets/brushes/star_2.png", "assets/brushes/star_3.png", "assets/brushes/hexagon.png", "assets/brushes/square.png", "assets/brushes/moon.png", "assets/brushes/triangle.png", "assets/brushes/leaf_1.png", "assets/brushes/leaf_2.png", "assets/brushes/leaf_3.png", "assets/brushes/leaf_4.png", "assets/brushes/heart.png", "assets/brushes/club.png", "assets/brushes/spade.png", "assets/brushes/diamond_2.png", "assets/brushes/diamond_icon.png", "assets/brushes/star_icon_1.png", "assets/brushes/star_icon_2.png", "assets/brushes/star_icon_3.png", "assets/brushes/hexagon_icon.png", "assets/brushes/square_icon.png", "assets/brushes/moon_icon.png", "assets/brushes/triangle_icon.png", "assets/brushes/spiral.png", "assets/brushes/snowflake.png", "assets/brushes/ornament.png", "assets/brushes/wheel.png", "assets/brushes/jing-jang.png", "assets/brushes/circle_icon.png", "assets/brushes/spatter.png", "assets/brushes/radioactive.png", "assets/brushes/flora_1.png", "assets/brushes/flora_2.png", "assets/brushes/flora_3.png", "assets/brushes/flora_4.png", "assets/brushes/flora_5.png", "assets/brushes/flora_6.png", "assets/brushes/flora_7.png", "assets/brushes/flora_8.png", "assets/brushes/cube.png", "assets/brushes/cube_invert.png", "assets/brushes/cat.png", "assets/brushes/planet_1.png", "assets/brushes/planet_2.png", "assets/brushes/ball.png", "assets/brushes/balls.png", "assets/brushes/drops.png");
		private var loader:Loader;

		public function BrushFormRenderer() {
			super();
			setStyle("horizontalGap", 0);
			var hbox:HBox=new HBox();
			hbox.setStyle("backgroundColor", "white");
			hbox.setStyle("backgroundAlpha", 1);
			hbox.setStyle("cornerRadius", 5);
			hbox.setStyle("borderStyle", "solid");
			hbox.setStyle("horizontalGap", 0);

			popup=new BrushesPopup();
			popup.list.selectedIndex=0;

			var sep1:UIComponent=new UIComponent();
			sep1.width=5;

			hbox.addChild(sep1);
			image=new Image();
			image.source=Application.application.brushes[0].icon;
			image.width=20;
			image.height=20;
			image.setStyle("cornerRadius", 5);
			hbox.addChild(image);

			var sep2:UIComponent=new UIComponent();
			sep2.width=5;

			hbox.addChild(sep2);

			brushLabel=new Label();
			brushLabel.width=100;
			brushLabel.text="Un Brush";

			hbox.addChild(brushLabel);

			addChild(hbox);
			chooseBrush=new Button();
			chooseBrush.setStyle("icon", selectBrushIcon);
			chooseBrush.setStyle("cornerRadius", 5);
			chooseBrush.width=20;
			addChild(chooseBrush);
			chooseBrush.addEventListener(MouseEvent.CLICK, showBrushes);

			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, setBitmap);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			var bt:BitmapAsset = new Application.application.brushes[0].icon() as BitmapAsset;
			this.bitmap = bt.bitmapData;
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Unable to load image: " + Application.application.brushes[0].icon);
		}

		private function setBitmap(event:Event):void {
			var loader:Loader=Loader(event.target.loader);
			this.bitmap=Bitmap(loader.content).bitmapData;
			var evt:ListEvent=new ListEvent(ListEvent.CHANGE);
			this.dispatchEvent(evt);
		}

		private function showBrushes(evt:MouseEvent):void {
			popup.x=this.localToGlobal(new Point(0, 0)).x;
			popup.y=this.localToGlobal(new Point(0, 0)).y + this.height + 5;
			popup.width=380;
			popup.setStyle('borderStyle', 'solid');
			popup.setStyle('borderThickness', 3);
			popup.setStyle('cornerRadius', 5);
			popup.list.addEventListener(ListEvent.CHANGE, hidePopup);
			PopUpManager.addPopUp(popup, this.parent, false);
		}

		public function hidePopup(evt:ListEvent):void {
			this.image.source=Application.application.brushes[popup.list.selectedIndex].icon;
			var request:URLRequest=new URLRequest(images[popup.list.selectedIndex]);
			loader.load(request);
			PopUpManager.removePopUp(popup);
		}

		public function getBitmapData():BitmapData {
			/* if (bitmap == null) {
				this.image.source=Application.application.brushes[0].icon;
				var request:URLRequest=new URLRequest(images[0]);
				var loader:Loader=new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, setBitmap);
				loader.load(request);
			} */
			return this.bitmap;
		}

		public function setBitmapData(bit:BitmapData):void {
			this.image.source=Application.application.brushes[popup.list.selectedIndex].icon;
			var request:URLRequest=new URLRequest(images[popup.list.selectedIndex]);
			loader.load(request);
			this.bitmap=bit;
			var evt:ListEvent=new ListEvent(ListEvent.CHANGE);
			this.dispatchEvent(evt);
		}
	}
}