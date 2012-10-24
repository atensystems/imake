package com.atensys.imake.draw.component {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.componentprovider.ProviderUtils;
	import com.atensys.imake.draw.styles.CircleStyle;
	import com.atensys.imake.draw.styles.DStyle;
	
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

	public class CircleComponent extends UIComponent implements DComponent {
		public var style:CircleStyle;
		private var startPoint:Point;
		private var size:Point;
		private var sprite:Sprite;
		private var btmdToerase:BitmapData;
		private var source:Bitmap;
		private var oldH:int;
		private var oldW:int;
		private var _eraserLayers:Array=new Array();
		private var ePoint:Point=new Point();
		private var sPoint:Point=new Point();
		private var cx:int, cy:int, cw:int, ch:int;
		private var circleID:int;

		public function CircleComponent(id:int, style:CircleStyle, startPoint:Point, size:Point) {
			super();
			this.circleID=id;
			this.style=style;
			this.startPoint=startPoint;
			this.size=size;
			btmdToerase=new BitmapData(size.x, size.y, true, 0x00FFFFFF);
			source=new Bitmap();
			sprite=new Sprite();
			addChild(sprite);

			this.addEventListener(ResizeEvent.RESIZE, resizeing);
			this.addEventListener("styleChanged", reDraw);
		}

		public function resizeing(evt:ResizeEvent):void {
			reDraw(null);
		}

		public function setProperties(sPoint:Point, ePoint:Point, dComXY:Point, dComWH:Point, oldWH:Point):void {
			this.sPoint=sPoint;
			this.ePoint=ePoint;
			this.x=dComXY.x;
			this.y=dComXY.y;
			this.width=dComWH.x;
			this.height=dComWH.y;
			this.oldW=oldWH.x;
			this.oldH=oldWH.y;
		}

		public function reDraw(evt:Event):void {
			sprite.graphics.clear();
			sprite.graphics.lineStyle(style.lineDiameter, style.color2, style.lineOpacity / 100);
			sprite.graphics.beginFill(style.color, style.fillOpacity / 100);
			sprite.graphics.drawEllipse(sPoint.x, sPoint.y, ePoint.x, ePoint.y);
			sprite.graphics.endFill();

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

		public function setDStyle(dstyle:CircleStyle):void {
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
			sprite.graphics.clear();
			sprite.graphics.lineStyle(style.lineDiameter, style.color2, style.lineOpacity / 100);
			sprite.graphics.beginFill(style.color, style.fillOpacity / 100);
			if (this.style.isCircle) {
				cw=ch=Math.max(Math.abs(point.x - startPoint.x), Math.abs(point.y - startPoint.y));
				cx=startPoint.x < point.x ? startPoint.x : startPoint.x - cw;
				cy=startPoint.y < point.y ? startPoint.y : startPoint.y - cw;
				sprite.graphics.drawEllipse(cx, cy, cw, ch);
			} else {
				cw=Math.abs(point.x - startPoint.x);
				ch=Math.abs(point.y - startPoint.y);
				cx=startPoint.x < point.x ? startPoint.x : startPoint.x - cw;
				cy=startPoint.y < point.y ? startPoint.y : startPoint.y - ch;
				sprite.graphics.drawEllipse(cx, cy, cw, ch);
			}
			sPoint.x=cx;
			sPoint.y=cy;
			ePoint.x=cw;
			ePoint.y=ch;
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

			return BitmapData(btmdToerase);
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
			sPoint.x=sPoint.x - this.x;
			sPoint.y=sPoint.y - this.y;
		}

		public function setSource():void {
			this.removeChildAt(0);
			btmdToerase=new BitmapData(oldW, oldH, true, 0x00000000);
			source=new Bitmap(btmdToerase);
			source.filters = style.effect.filters;
			this.addChild(source);
		}


		public function toXML():XML {
			var root:XML=<circle></circle>;
			root.@['id']=this.circleID;
			root.@['x']=sPoint.x;
			root.@['y']=sPoint.y;
			root.@['width']=ePoint.x;
			root.@['height']=ePoint.y;

			root.@['dcX']=this.x;
			root.@['dcY']=this.y;
			root.@['dcWidth']=this.width;
			root.@['dcHeight']=this.height;

			root.@['oldWidth']=oldW;
			root.@['oldHeight']=oldH;

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
			var c:CircleComponent=new CircleComponent(ProviderUtils.newID(), CircleStyle(this.style.clone()), this.startPoint, this.size);
			c.eraserLayers = this.eraserLayers;
			c.setProperties(this.sPoint,this.ePoint,new Point(this.x+10,this.y+20),new Point(this.width,this.height),new Point(this.oldW,this.oldH));
			c.setSource();
			c.reDraw(null);
			return c;
		}
	}
}