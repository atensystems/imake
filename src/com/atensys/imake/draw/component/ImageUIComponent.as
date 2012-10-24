package com.atensys.imake.draw.component {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.componentprovider.ProviderUtils;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.ImageStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	public class ImageUIComponent extends UIComponent implements DComponent {
		private var desktop:DrawDesktop;
		public var style:ImageStyle;
		private var source:Bitmap;
		private var _initialSource:BitmapData;
		public var imageID:int;
		public var imageName:String;
		private var _eraserLayers:Array=new Array();
		private static var url:String;

		public function ImageUIComponent(id:int,name:String, style:ImageStyle, parent:DrawDesktop) {
			this.imageID=id;
			this.imageName=name;
			this.desktop=parent;
			this.style=style;
			source=new Bitmap();
			this.addEventListener(ResizeEvent.RESIZE, resizeing);
		}

		public function resizeing(evt:ResizeEvent):void {
			reDraw();
		}

		private function reDraw():void {
			source.bitmapData=Util.getResizedBitmapData(_initialSource, this.width, this.height);
			var uic:UIComponent=new UIComponent();
			for (var i:int=0; i < _eraserLayers.length; i++) {
				EraserLayer(_eraserLayers[i]).shape.scaleX=this.width / EraserLayer(_eraserLayers[i]).width;
				EraserLayer(_eraserLayers[i]).shape.scaleY=this.height / EraserLayer(_eraserLayers[i]).height;
				uic.addChild(EraserLayer(_eraserLayers[i]).shape);
			}
			source.bitmapData.draw(uic, null, null, BlendMode.ERASE);
			for (var j2:int=0; j2 < _eraserLayers.length; j2++) {
				EraserLayer(_eraserLayers[j2]).shape.scaleX=1;
				EraserLayer(_eraserLayers[j2]).shape.scaleY=1;
			}
			if(style.effect.isDistress){
				Util.makeDistress(source.bitmapData,style.effect.distress.distressN);
			}
			Util.makeFlip(this);
		}


		private function setDragEnable(evt:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragImage);
		}

		private function setDragDisable(evt:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragImage);
		}

		private function dragImage(evt:MouseEvent):void {
			var location:Point=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY);
		}


		public function setDStyle(dstyle:ImageStyle):void {
			this.style=dstyle;
		}

		public function getDStyle():DStyle {
			return this.style;
		}

		public function setBitmapImage(img:Bitmap):void {
			this.source=img;
			_initialSource=source.bitmapData.clone();
			this.width=img.width;
			this.height=img.height;
			addChild(source);
		}
		public function setSource(img:Bitmap):void {
			this.source=img;
			_initialSource=source.bitmapData.clone();
			addChild(source);
			source.filters = style.effect.filters;
			var matrixArray:Array=[.33, .33, .33, 0, 0, .33, .33, .33, 0, 0, .33, .33, .33, 0, 0, 0, 0, 0, 1, 0];
			var normalmatrixArray:Array=[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
			var blackWhiteFilter:ColorMatrixFilter=new ColorMatrixFilter(style.blackWhite ? matrixArray : normalmatrixArray);
			var filts:Array=source.filters;
			filts.push(blackWhiteFilter);
			source.filters = filts;
			}

		public function getName():String {
			return null;
		}
		;

		public function setName(name:String):void {
		}
		;

		public function setPosition(x:Number, y:Number):void {
		}
		;

		public function setSize(width:Number, height:Number):void {
		}
		;

		public function rotate(degrees:Number):void {
		}
		;
		public function setProperties(dComXY:Point, dComWH:Point):void{
			this.x = dComXY.x;
			this.y = dComXY.y;
			this.width = dComWH.x;
			this.height = dComWH.y;
		}

		public function getController():UIComponent {
			return this;
		}

		public function setActive(active:Boolean):void {
			if (!active) {
				dispatchEvent(new Event("repaint"));
			}
		}

		public function toXML():XML {
			var root:XML=<image></image>;
			root.@['id']=this.imageID;
			root.@['name']=this.imageName;
			root.@['dcX']=this.x;
			root.@['dcY']=this.y;
			root.@['dcWidth']=this.width;
			root.@['dcHeight']=this.height;
			
			root.appendChild(this.style.toXML());
			for (var j2:int=0; j2 < eraserLayers.length; j2++) {
				root.appendChild(EraserLayer(eraserLayers[j2]).xml);
			}
			return root;
		}

		public function getSource():Bitmap {
			return source;
		}

		public function get eraserLayers():Array {
			return _eraserLayers;
		}

		public function set eraserLayers(bit:Array):void {
			this._eraserLayers=bit;
		}

		public function clone():DComponent {
			var i:ImageUIComponent=new ImageUIComponent(ProviderUtils.newID(),Util.currentTime(), ImageStyle(this.style.clone()), this.desktop);
			i.eraserLayers=this.eraserLayers.reverse().reverse();
			i.setProperties(new Point(this.x+10,this.y+20),new Point(this.width,this.height));
			i.setSource(i.style.imageBitmap);
			i.reDraw();
			return i;
		}
	}
}