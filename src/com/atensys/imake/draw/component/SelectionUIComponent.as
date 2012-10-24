package com.atensys.imake.draw.component {

	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.componentprovider.ImageComponentProvider;
	import com.atensys.imake.draw.layers.LayerData;
	import com.atensys.imake.draw.stylepanels.StyleProvider;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.SelectionStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	
	import mx.collections.IList;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ItemClickEvent;

	public class SelectionUIComponent extends UIComponent implements DComponent {

		private var style:SelectionStyle;
		public var startPoint:Point;
		private var movePoint:Point;
		private var endPoint:Point;
		private var size:Point;
		private var backgroundBitmapData:BitmapData;
		private var whiteBMPData:BitmapData;
		private var sourceSprite:Sprite;
		public var sourceBitmap:Bitmap;
		private var desktop:DrawDesktop;
		public var typeShape:Shape=new Shape();
		private var shapeStartPoint:Point=new Point();
		private var shapeEndPoint:Point=new Point();
		private var borderBMData:BitmapData;
		public var shapeBMData:BitmapData;
		private var selectionMode:uint;

		private var layers:Array;

		public static var SELECTION_COPY:int=1;
		public static var SELECTION_CUT:int=2;
		public static var SELECTION_DELETE:int=3;


		public function SelectionUIComponent(style:SelectionStyle, parent:DrawDesktop) {
			super();
			this.style=style;

			this.desktop=parent;
			whiteBMPData=new BitmapData(parent.width, parent.height);
			borderBMData=new BitmapData(parent.width, parent.height, true, 0xFFFFFFFF);
			shapeBMData=new BitmapData(parent.width, parent.height, true, 0xFFFFFFFF);
			this.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
		}

		private function pixelInComponent(pixel:Point, comp:UIComponent):Boolean {
			if (pixel.x >= comp.x && pixel.x <= comp.x + comp.width)
				if (pixel.y >= comp.y && pixel.y <= comp.y + comp.height)
					return true;
			return false;
		}

		private function sortOnIndex(a:LayerData, b:LayerData):Number {
			var aUIComp:UIComponent=a.component.getController();
			var bUIComp:UIComponent=b.component.getController();

			if (aUIComp.parent.getChildIndex(aUIComp) > bUIComp.parent.getChildIndex(bUIComp)) {
				return 1;
			} else if (aUIComp.parent.getChildIndex(aUIComp) < bUIComp.parent.getChildIndex(bUIComp)) {
				return -1;
			} else {
				return 0;
			}
		}

		/**
		 * Get pixels
		 * */
		public function getPixelsFromShape(white:BitmapData, mode:int):BitmapData {
			var y1:int;
			var x1:int;
			var scaledBMD:BitmapData=new BitmapData(white.width, white.height, true, 0xFFFFFFFF);

			var returnBitmapData:BitmapData=new BitmapData(Math.abs(shapeEndPoint.x - shapeStartPoint.x), Math.abs(shapeEndPoint.y - shapeStartPoint.y), true, 0x00FFFFFF);

			var dComponent:DComponent;
			this.layers=Application.application.layersView.selectedItems;
			this.layers.sort(sortOnIndex);
			for (y1=0; y1 < desktop.height; y1++)
				for (x1=0; x1 < desktop.width; x1++) {
					if (white.getPixel(x1, y1) == 0x000000) {
						for (var i:int=0; i < layers.length; i++) {
							var lay:LayerData=LayerData(layers[i]);
							dComponent=lay.component;
							if (pixelInComponent(new Point(x1, y1), dComponent.getController()))
								if (dComponent.getSource().bitmapData.getPixel32(x1 - dComponent.getController().x, y1 - dComponent.getController().y) != 0x00000000) {
									switch (mode) {
										case SELECTION_COPY:  {
											returnBitmapData.setPixel32(x1 - shapeStartPoint.x, y1 - shapeStartPoint.y, dComponent.getSource().bitmapData.getPixel32(x1 - dComponent.getController().x, y1 - dComponent.getController().y));
											break;
										}
										case SELECTION_CUT:  {
											returnBitmapData.setPixel32(x1 - shapeStartPoint.x, y1 - shapeStartPoint.y, dComponent.getSource().bitmapData.getPixel32(x1 - dComponent.getController().x, y1 - dComponent.getController().y));
											dComponent.getSource().bitmapData.setPixel32(x1 - dComponent.getController().x, y1 - dComponent.getController().y, 0x00000000);
											break
										}
										case SELECTION_DELETE:  {
											dComponent.getSource().bitmapData.setPixel32(x1 - dComponent.getController().x, y1 - dComponent.getController().y, 0x00000000);
											break
										}
									}
								}
						}
					}
				}
			if (mode == SELECTION_CUT || mode == SELECTION_DELETE) {
				for (var j:int=0; j < layers.length; j++) {
					var layr:LayerData=LayerData(layers[j]);
					dComponent=layr.component;
				}
			}
			return returnBitmapData;
		}

		public function setStartPoint(startPoint:Point):void {
			switch (this.style.getMode()) {
				case SelectionStyle.ADD_MODE:
					selectionMode=0xFF000000;
					break;
				case SelectionStyle.REM_MODE:
					selectionMode=0x00FFFFFF;
					break;
				case SelectionStyle.NEW_MODE:
					selectionMode=0xFF000000;
					break;
			}
			this.startPoint=startPoint;
			this.movePoint=startPoint;
			this.shapeStartPoint=this.startPoint.clone();
			this.shapeEndPoint=this.startPoint.clone();

			this.graphics.lineStyle(this.style.getBorderThickness(), this.style.color);
			this.typeShape.graphics.beginFill(selectionMode, 1);
			this.typeShape.graphics.moveTo(movePoint.x, movePoint.y);
		}

		public function setEndPoint(endPoint:Point):void {
			this.endPoint=endPoint;

		}

		public function lineTo(point:Point):void {
			switch (this.style.getType()) {
				case SelectionStyle.RECTANGLE:
					rectangleTo(point);
					break;
				case SelectionStyle.CIRCLE:
					circleTo(point);
					break;
				case SelectionStyle.ELIPSE:
					elipseTo(point);
					break;
				case SelectionStyle.LINE:
					linesTo(point);
					break;
				case SelectionStyle.MOUSE:
					mouseTo(point);
					break;

				default:
					break;
			}
		}

		private function rectangleTo(point:Point):void {
			this.graphics.clear();
			this.typeShape.graphics.clear();
			this.graphics.lineStyle(this.style.getBorderThickness(), this.style.color);

			this.typeShape.graphics.lineStyle(2, 0x00000000, 0.5);
			this.typeShape.graphics.beginFill(selectionMode, 1);
			this.graphics.drawRect(startPoint.x < point.x ? startPoint.x : point.x, startPoint.y < point.y ? startPoint.y : point.y, Math.abs(point.x - startPoint.x), Math.abs(point.y - startPoint.y));
			this.typeShape.graphics.drawRect(startPoint.x < point.x ? startPoint.x : point.x, startPoint.y < point.y ? startPoint.y : point.y, Math.abs(point.x - startPoint.x), Math.abs(point.y - startPoint.y));
			this.typeShape.graphics.endFill();
		}

		private function circleTo(point:Point):void {
			this.graphics.clear();
			this.typeShape.graphics.clear();
			this.graphics.lineStyle(this.style.getBorderThickness(), this.style.color);

			this.typeShape.graphics.lineStyle(2, 0x00000000, 0.5);
			this.typeShape.graphics.beginFill(selectionMode, 1);

			this.graphics.drawEllipse(startPoint.x < point.x ? startPoint.x : point.x, startPoint.y < point.y ? startPoint.y : point.y, Math.abs(point.x - startPoint.x), Math.abs(point.x - startPoint.x));

			this.typeShape.graphics.drawEllipse(startPoint.x < point.x ? startPoint.x : point.x, startPoint.y < point.y ? startPoint.y : point.y, Math.abs(point.x - startPoint.x), Math.abs(point.x - startPoint.x));
			this.typeShape.graphics.endFill();
		}

		private function elipseTo(point:Point):void {
			this.graphics.clear();
			this.typeShape.graphics.clear();
			this.graphics.lineStyle(this.style.getBorderThickness(), this.style.color);

			this.typeShape.graphics.lineStyle(2, 0x00000000, 0.5);
			this.typeShape.graphics.beginFill(selectionMode, 1);

			this.graphics.drawEllipse(startPoint.x < point.x ? startPoint.x : point.x, startPoint.y < point.y ? startPoint.y : point.y, Math.abs(point.x - startPoint.x), Math.abs(point.y - startPoint.y));
			this.typeShape.graphics.drawEllipse(startPoint.x < point.x ? startPoint.x : point.x, startPoint.y < point.y ? startPoint.y : point.y, Math.abs(point.x - startPoint.x), Math.abs(point.y - startPoint.y));

			this.typeShape.graphics.endFill();
		}

		private function linesTo(point:Point):void {

		}

		private function mouseTo(point:Point):void {
			this.graphics.lineStyle(this.style.getBorderThickness(), this.style.color);
			this.graphics.moveTo(movePoint.x, movePoint.y);
			this.graphics.lineTo(point.x, point.y);
			this.typeShape.graphics.lineStyle(2, 0x00000000, 0.5);
			this.typeShape.graphics.lineTo(point.x, point.y);

			movePoint=point;
		}

		private function setStartEndShapePoint(x1:int, y1:int):void {
			if (x1 < this.shapeStartPoint.x)
				this.shapeStartPoint.x=x1;
			if (y1 < this.shapeStartPoint.y)
				this.shapeStartPoint.y=y1;
			if (x1 > this.shapeEndPoint.x)
				this.shapeEndPoint.x=x1;
			if (y1 > this.shapeEndPoint.y)
				this.shapeEndPoint.y=y1;
		}

		public function showBorder():void {
			Application.application.toolbar.disableCopyCutButtons();
			var y1:int;
			var x1:int;
			borderBMData=new BitmapData(borderBMData.width, borderBMData.height, true, 0x00FFFFFF);
			if (this.style.getMode() == SelectionStyle.NEW_MODE) {
				shapeBMData=new BitmapData(borderBMData.width, borderBMData.height, true, 0xFFFFFFFF);
				shapeBMData.draw(typeShape);
			}

			for (y1=0; y1 < shapeBMData.height; y1++)
				for (x1=0; x1 < shapeBMData.width; x1++) {
					if ((shapeBMData.getPixel(x1, y1) != 0x000000) && (shapeBMData.getPixel(x1, y1) != 0xFFFFFF))
						if ((shapeBMData.getPixel(x1 - 1, y1) == 0x000000) || (shapeBMData.getPixel(x1 + 1, y1) == 0x000000) || (shapeBMData.getPixel(x1, y1 - 1) == 0x000000) || (shapeBMData.getPixel(x1, y1 + 1) == 0x000000)) {
							borderBMData.setPixel32(x1, y1, 0xFF000000 + this.style.color);
							setStartEndShapePoint(x1, y1);
						}
				}
			this.graphics.clear();
			if (this.numChildren > 0)
				this.removeChildAt(0);
			if (this.style.getBorderVisible())
				this.addChild(new Bitmap(borderBMData));

			if(shapeBMData.height>0&&shapeBMData.width>0){
				initPopupMenu();
			}
		}

		public function setBorderVisible(vis:Boolean):void {
			if (!vis) {
				if (this.numChildren > 0)
					this.removeChildAt(0);
			}
		}

		private function initPopupMenu():void {
			Application.application.toolbar.enableCopyCutButtons();
			Application.application.toolbar.editButtons.addEventListener(ItemClickEvent.ITEM_CLICK, doAction);
		}
		
		private function doAction(event:ItemClickEvent):void{
			if(event.index==0){
				doCopy();
			}	
			else if(event.index==1){
				doCut();
			}
			else if(event.index==2){
				doPaste();
			}
		}

		public function setDStyle(dstyle:SelectionStyle):void {
			this.style=dstyle;
		}

		public function getDStyle():DStyle {
			return this.style;
		}

		public function setSourceBitmap(bitmap:Bitmap):void {
			this.sourceSprite.removeChildAt(0);
			this.sourceBitmap=bitmap;
			this.sourceSprite.addChild(this.sourceBitmap);
		}

		public function setActive(active:Boolean):void {
		}

		public function getName():String {
			return this.name;
		}

		public function setName(name:String):void {
			this.name=name;
		}

		public function setPosition(x:Number, y:Number):void {
			// set position
		}

		public function setSize(width:Number, height:Number):void {
			// set size
		}

		public function rotate(degrees:Number):void {
			// rotate
		}

		public function getController():UIComponent {
			return this;
		}

		public function toBitmapData():BitmapData {
			return sourceBitmap.bitmapData;
		}

		private function doCopy():void {
			sourceBitmap=new Bitmap(getPixelsFromShape(shapeBMData, SELECTION_COPY));
			this.removeChildAt(0);
			Application.application.toolbar.getPasteButton().enabled=true;
			this.shapeBMData=new BitmapData(shapeBMData.width, shapeBMData.height, true, 0xFFFFFFFF);
		}

		private function doCut():void {
			sourceBitmap=new Bitmap(getPixelsFromShape(shapeBMData, SELECTION_CUT));
			this.removeChildAt(0);
			Application.application.toolbar.getPasteButton().enabled=true;
			this.shapeBMData=new BitmapData(shapeBMData.width, shapeBMData.height, true, 0xFFFFFFFF);
		}

		private function doPaste():void {
			Application.application.pallete.setComponentType(DComponentType.IMAGE);
			StyleProvider.getInstance().setStyleBar(DComponentType.IMAGE);
			Application.application.desktop.currentComponentProvider.setActive(false);
			var exists:Boolean=false;
			var i:int;
			var componentProviders:IList=Application.application.desktop.getComponentProviders();
			for (i=0; i < componentProviders.length; i++) {
				if (componentProviders.getItemAt(i) is ImageComponentProvider) {
					Application.application.desktop.currentComponentProvider=ImageComponentProvider(componentProviders.getItemAt(i));
					exists=true;
				}
			}
			if (!exists) {
				Application.application.desktop.currentComponentProvider=new ImageComponentProvider();
			}
			ImageComponentProvider(Application.application.desktop.currentComponentProvider).setParent1(Application.application.desktop, sourceBitmap);
		}

		private function keyHandler(event:KeyboardEvent):void {
		}

		public function toXML():XML {
			return null;
		}

		public function getSource():Bitmap {
			return null;
		}

		public function get eraserLayers():Array {
			return null;
		}

		public function set eraserLayers(bit:Array):void {
		}

		public function clone():DComponent {
			return null;
		}

	}

}