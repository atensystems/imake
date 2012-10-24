package com.atensys.imake.draw.component {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.componentprovider.ProviderUtils;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.LineStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	public class LineStroke extends UIComponent implements DComponent {

		public var style:LineStyle;
		private var startPoint:Point;
		private var endPoint:Point;
		private var size:Point;
		private var sprite:Sprite;
		private var btmdToerase:BitmapData;
		private var source:Bitmap;
		private var oldH:int;
		private var oldW:int;
		private var _eraserLayers:Array=new Array();
		private var lineID:int;

		public function LineStroke(id:int, style:LineStyle, startPoint:Point, size:Point) {
			super();
			this.lineID=id;
			this.style=style;
			this.startPoint=startPoint;
			this.size=size;
			btmdToerase=new BitmapData(size.x, size.y, true, 0x00FFFFFF);
			source=new Bitmap(btmdToerase);
			sprite=new Sprite();
			addChild(sprite);
			this.addEventListener(ResizeEvent.RESIZE, resizing);
			this.addEventListener("styleChanged", reDraw);
		}

		public function resizing(evt:ResizeEvent):void {
			reDraw(null);
		}

		public function reDraw(evt:Event):void {
			sprite.graphics.clear();
			sprite.graphics.lineStyle(style.diameter, style.color, style.opacity / 100, style.pixelHinting, "normal", style.style);
			sprite.graphics.moveTo(startPoint.x, startPoint.y);
			sprite.graphics.lineTo(endPoint.x, endPoint.y);

			var uic:UIComponent=new UIComponent();
			sprite.scaleX*=this.width / oldW;
			sprite.scaleY*=this.height / oldH;
			uic.addChild(sprite);
			source.bitmapData=new BitmapData(this.width, this.height, true, 0x00FFFFFF);
			source.bitmapData.draw(uic);

			uic=new UIComponent();
			for (var i:int=0; i < _eraserLayers.length; i++) {
				EraserLayer(_eraserLayers[i]).shape.scaleX=this.width / EraserLayer(_eraserLayers[i]).width;
				EraserLayer(_eraserLayers[i]).shape.scaleY=this.height / EraserLayer(_eraserLayers[i]).height;
				uic.addChild(EraserLayer(_eraserLayers[i]).shape);
			}
			source.bitmapData.draw(uic, null, null, BlendMode.ERASE);
			sprite.scaleX=1.0;
			sprite.scaleY=1.0;
			for (var j2:int=0; j2 < _eraserLayers.length; j2++) {
				EraserLayer(_eraserLayers[j2]).shape.scaleX=1;
				EraserLayer(_eraserLayers[j2]).shape.scaleY=1;
			}
			if(style.effect.isDistress){
				Util.makeDistress(source.bitmapData,style.effect.distress.distressN);
			}
			Util.makeFlip(this);
		}

		public function setDStyle(dstyle:LineStyle):void {
			this.style=dstyle;
		}

		public function getDStyle():DStyle {
			return this.style;
		}

		public function getName():String {
			return this.name;
		}

		public function setName(name:String):void {
			this.name=name;
		}

		public function rotate(degrees:Number):void {
			this.rotation=Util.degreesToRadians(degrees);
		}

		public function setPosition(x:Number, y:Number):void {
			this.x=x;
			this.y=y;
		}

		public function setSize(width:Number, heigth:Number):void {
			this.width=width;
			this.height=heigth;
		}

		public function setStartPoint(startPoint:Point):void {
			this.startPoint=startPoint;
		}

		public function lineTo(point:Point):void {
			endPoint=point;
			if (style.shapeTrails) {
				sprite.graphics.lineStyle(style.diameter, style.color, style.opacity / 100, style.pixelHinting, "normal", style.style);
				sprite.graphics.moveTo(startPoint.x, startPoint.y);
				sprite.graphics.lineTo(point.x, point.y);
			} else {
				sprite.graphics.clear();
				sprite.graphics.lineStyle(style.diameter, style.color, style.opacity / 100, style.pixelHinting, "normal", style.style);
				sprite.graphics.moveTo(startPoint.x, startPoint.y);
				sprite.graphics.lineTo(point.x, point.y);

			}
		}

		public function setActive(active:Boolean):void {
			if (!active) {
				dispatchEvent(new Event("repaint"));
			}
		}

		public function getController():UIComponent {
			return this;
		}

		public function toBitmapData():BitmapData {
			return source.bitmapData;
		}

		public function getRectu():void {
			btmdToerase.draw(sprite);
			var rect:Rectangle=btmdToerase.getColorBoundsRect(0xFF000000, 0x00000000, false);
			var bmdLine:BitmapData=new BitmapData(rect.width, rect.height, true, 0xFF000000);
			var bytes:ByteArray=btmdToerase.getPixels(rect);
			bytes.position=0;
			bmdLine.setPixels(new Rectangle(0, 0, rect.width, rect.height), bytes);
			btmdToerase=bmdLine;
			source=new Bitmap(btmdToerase);
			this.removeChildAt(0);
			this.height=rect.height;
			this.width=rect.width;
			this.x=rect.x;
			this.y=rect.y;
			this.addChild(source);
			oldH=this.height;
			oldW=this.width;
			startPoint.x=startPoint.x - this.x;
			startPoint.y=startPoint.y - this.y;
			endPoint.x=endPoint.x - this.x;
			endPoint.y=endPoint.y - this.y;
		}

		public function toXML():XML {
			var root:XML=<line></line>;
			root.@['id']=this.lineID;
			root.@['startX']=this.startPoint.x;
			root.@['startY']=this.startPoint.y;
			root.@['endX']=this.endPoint.x;
			root.@['endY']=this.endPoint.y;
			root.@['dcX']=this.x;
			root.@['dcY']=this.y;
			root.@['dcWidth']=this.width;
			root.@['dcHeight']=this.height;
			root.@['oldWidth']=this.oldW;
			root.@['oldHeight']=this.oldH;
			root.appendChild(this.style.toXML());
			for (var j2:int=0; j2 < eraserLayers.length; j2++)
			{
				root.appendChild(EraserLayer(eraserLayers[j2]).xml);
			}
			return root;
		}
		public function setProperties(sPoint:Point,ePoint:Point,dComXY:Point,dComWH:Point,oldWH:Point):void{
			this.startPoint=sPoint;
			this.endPoint=ePoint;
			this.x = dComXY.x;
			this.y = dComXY.y;
			this.width = dComWH.x;
			this.height= dComWH.y;
			this.oldW = oldWH.x;
			this.oldH = oldWH.y;
		}

		public function getSource():Bitmap {
			return source;
		}
		public function setSource():void{
			this.removeChildAt(0);
			btmdToerase = new BitmapData(oldW, oldH, true, 0x00000000);
			source=new Bitmap(btmdToerase);
			this.addChild(source);
			this.source.filters = style.effect.filters;
		}

		public function get eraserLayers():Array {
			return _eraserLayers;
		}

		public function set eraserLayers(bit:Array):void {
			this._eraserLayers=bit;
		}

		public function clone():DComponent {
			var l:LineStroke=new LineStroke(ProviderUtils.newID(), LineStyle(this.style.clone()), this.startPoint, this.size);
			l.eraserLayers=this.eraserLayers;
			l.setProperties(this.startPoint,this.endPoint,new Point(this.x+10,this.y+20),new Point(this.width,this.height),new Point(this.oldW,this.oldH));
			l.setSource();
			l.reDraw(null);
			return l;
		}
	}
}