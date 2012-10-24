package com.atensys.imake.draw.component {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.componentprovider.ProviderUtils;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.RectangleStyle;
	
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

	public class RectangleComponent extends UIComponent implements DComponent {
		public var style:RectangleStyle;
		private var lineToPoint:Point;
		private var size:Point;
		private var sprite:Sprite;
		private var btmdToerase:BitmapData;
		private var source:Bitmap;
		private var oldH:int;
		private var oldW:int;
		private var _eraserLayers:Array=new Array();
		private var startPoint:Point;
		private var ePoint:Point=new Point();
		private var sPoint:Point=new Point();
		private var rectID:int;
		private var rx:int, ry:int, rw:int, rh:int;


		public function RectangleComponent(id:int, style:RectangleStyle, startPoint:Point, size:Point) {
			super();
			rectID=id;
			this.style=style;
			this.startPoint=startPoint;
			this.size=size;
			btmdToerase=new BitmapData(size.x, size.y, true, 0x00000000);
			sprite=new Sprite();
			addChild(sprite);
			this.addEventListener(ResizeEvent.RESIZE, resizeing);
			this.addEventListener("styleChanged", reDraw);
		}

		public function resizeing(evt:ResizeEvent):void {
			reDraw(null);
		}

		public function getController():UIComponent {
			return this;
		}

		public function getName():String {
			return this.name;
		}

		public function lineTo(point:Point):void {
			this.lineToPoint=point;
			sprite.graphics.clear();
			sprite.graphics.lineStyle(style.lineDiameter, style.color2, style.lineOpacity / 100);
			sprite.graphics.beginFill(style.color, style.fillOpacity / 100);

			if (this.style.isSquare) {
				rh=rw=Math.max(Math.abs(point.x - startPoint.x), Math.abs(point.y - startPoint.y));
				rx=startPoint.x < point.x ? startPoint.x : startPoint.x - rh;
				ry=startPoint.y < point.y ? startPoint.y : startPoint.y - rh;
				sprite.graphics.drawRoundRectComplex(rx, ry, rw, rh, style.topLeftRound / 100 * rh, style.topRightRound / 100 * rh, style.bottomLeftRound / 100 * rh, style.bottomRightRound / 100 * rh);
			} else {
				rx=startPoint.x < point.x ? startPoint.x : point.x;
				ry=startPoint.y < point.y ? startPoint.y : point.y;
				rw=Math.abs(point.x - startPoint.x);
				rh=Math.abs(point.y - startPoint.y);
				sprite.graphics.drawRoundRectComplex(rx, ry, rw, rh, style.topLeftRound / 100 * Math.min(rw, rh), style.topRightRound / 100 * Math.min(rw, rh), style.bottomLeftRound / 100 * Math.min(rw, rh), style.bottomRightRound / 100 * Math.min(rw, rh));
			}
			sprite.graphics.endFill();
			sPoint.x=rx;
			sPoint.y=ry;
			ePoint.x=rw;
			ePoint.y=rh;
		}

		public function reDraw(evt:Event):void {
			sprite.graphics.clear();
			sprite.graphics.lineStyle(style.lineDiameter, style.color2, style.lineOpacity / 100);
			sprite.graphics.beginFill(style.color, style.fillOpacity / 100);
			sprite.graphics.drawRoundRectComplex(sPoint.x, sPoint.y, ePoint.x, ePoint.y, style.topLeftRound / 100 * rh, style.topRightRound / 100 * rh, style.bottomLeftRound / 100 * rh, style.bottomRightRound / 100 * rh);
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
			//Util.rotate(this,);
		}

		public function rotate(degrees:Number):void {
			this.rotation=Util.degreesToRadians(degrees);
		}

		public function setActive(active:Boolean):void {
			if (!active) {
				dispatchEvent(new Event("repaint"));
			}
		}

		public function setDStyle(dstyle:RectangleStyle):void {
			this.style=dstyle;
		}

		public function getDStyle():DStyle {
			return this.style;
		}

		public function setName(name:String):void {
			this.name=name;
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

		public function toBitmapData():BitmapData {
			return BitmapData(btmdToerase);
		}

		public function getRectu():void {
			btmdToerase.draw(sprite);
			var bmdLine:BitmapData=new BitmapData(rw, rh, true, 0xFF000000);
			var rect:Rectangle=new Rectangle(rx, ry, rw, rh);
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

		public function toXML():XML {
			var root:XML=<rectange></rectange>;
			root.@['id']=this.rectID;
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
		public function setSource():void {
			this.removeChildAt(0);
			btmdToerase=new BitmapData(oldW, oldH, true, 0x00000000);
			source=new Bitmap(btmdToerase);
			this.addChild(source);
			this.source.filters = style.effect.filters;
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

		public function get eraserLayers():Array {
			return _eraserLayers;
		}

		public function set eraserLayers(bit:Array):void {
			this._eraserLayers=bit;
		}

		public function clone():DComponent {
			var r:RectangleComponent=new RectangleComponent(ProviderUtils.newID(), RectangleStyle(this.style.clone()), this.startPoint, this.size);
			r.eraserLayers=this.eraserLayers;
			r.setProperties(this.sPoint,this.ePoint,new Point(this.x+10,this.y+20),new Point(this.width,this.height),new Point(this.oldW,this.oldH));
			r.setSource();
			r.reDraw(null);
			return r;
		}
	}
}