package com.atensys.imake.draw.component {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.componentprovider.ProviderUtils;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.PencilStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	public class PencilStroke extends UIComponent implements DComponent {

		public var style:PencilStyle;
		private var startPoint:Point;
		private var line:Boolean=false;
		private var btmdToerase:BitmapData;
		private var source:Bitmap;
		private var points:ArrayCollection=new ArrayCollection();
		private var pencilID:int;
		private var sprite:Sprite;
		private var oldH:int;
		private var oldW:int;
		private var _eraserLayers:Array=new Array();
		private var size:Point;

		public function PencilStroke(id:int, style:PencilStyle, startPoint:Point, size:Point) {
			super();
			this.size=size;
			this.setStyle("themeColor", 0x00FF00);
			this.includeInLayout=false;
			this.pencilID=id;
			this.style=style;
			this.startPoint=startPoint;
			sprite=new Sprite();
			btmdToerase=new BitmapData(size.x, size.y, true, 0x00000000);
			source=new Bitmap(btmdToerase);
			addChild(sprite);
			this.addEventListener(ResizeEvent.RESIZE, resizing);
			this.addEventListener("styleChanged", reDraw);
		}

		public function resizing(evt:ResizeEvent):void {
			//reDraw(null);
		}



		public function clickComp(evt:MouseEvent):void {
			trace(evt.target);
		}

		public function reDraw(evt:Event):void {
			sprite.graphics.clear();
			sprite.graphics.moveTo(Point(points[0]).x, Point(points[0]).y);
			sprite.graphics.lineStyle(style.diameter, style.color, style.opacity / 100.0, style.pixelHinting, LineScaleMode.NORMAL, style.style, style.lineJoint);
			for (var j:int=1; j < points.length; j++) {
				sprite.graphics.lineTo(Point(points[j]).x, Point(points[j]).y);
			}
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
			//Util.rotate(this);
		}

		public function setDStyle(dstyle:PencilStyle):void {
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

		public function rotate(radians:Number):void {
			this.style.effect.rotation=radians;
			//this.source.rotation
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
			this.line=false;
			sprite.graphics.moveTo(startPoint.x, startPoint.y);
			sprite.graphics.lineStyle(style.diameter, style.color, style.opacity / 100.0, style.pixelHinting, LineScaleMode.NORMAL, style.style, style.lineJoint);
			points.addItem(startPoint);
		}

		public function lineTo(point:Point):void {
			sprite.graphics.lineTo(point.x, point.y);
			line=true;
			points.addItem(point);
		}



		public function setActive(active:Boolean):void {
			if (!active && !line) {
				sprite.graphics.lineStyle(1, 0, 0);
				sprite.graphics.beginFill(style.color, style.opacity / 100.0);

				if (style.style == CapsStyle.SQUARE || style.style == CapsStyle.NONE) {
					sprite.graphics.drawRect(startPoint.x - style.diameter / 2, startPoint.y - style.diameter / 2, style.diameter, style.diameter);
				} else if (style.style == CapsStyle.ROUND) {
					sprite.graphics.drawCircle(startPoint.x, startPoint.y, style.diameter / 2);
				}
				sprite.graphics.endFill();
			}
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

		public function toXML():XML {
			var root:XML=<pencil></pencil>;
			root.@['id']=this.pencilID;
			root.@['dcX']=this.x;
			root.@['dcY']=this.y;
			root.@['dcWidth']=this.width;
			root.@['dcHeight']=this.height;
			root.@['oldWidth']=this.oldW;
			root.@['oldHeight']=this.oldH;
			root.appendChild(this.style.toXML());
			var point:XML;
			var p:String="<point></point>";
			for (var i:int=0; i < points.length; i++) {
				point=new XML(p);
				point.@['x']=Point(points[i]).x;
				point.@['y']=Point(points[i]).y;
				root.appendChild(point);
			}
			for (var j2:int=0; j2 < eraserLayers.length; j2++)
			{
				root.appendChild(EraserLayer(eraserLayers[j2]).xml);
			}
			return root;
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
			for (var i:int=0; i < points.length; i++) {
				Point(points[i]).x=Point(points[i]).x - this.x;
				Point(points[i]).y=Point(points[i]).y - this.y;
			}
		}
		public function setProperties(dComXY:Point,dComWH:Point,oldWH:Point,points:ArrayCollection):void{
			this.x = dComXY.x;
			this.y = dComXY.y;
			this.width = dComWH.x;
			this.height= dComWH.y;
			this.oldW = oldWH.x;
			this.oldH = oldWH.y;
			this.points = points;
		}

		public function getSource():Bitmap {
			return this.source;
		}
		public function setSource():void{
			this.removeChildAt(0);
			btmdToerase = new BitmapData(oldW, oldH, true, 0x00000000);
			source=new Bitmap(btmdToerase);
			this.addChild(source);
			this.source.filters = style.effect.filters;
		}

		public function get eraserLayers():Array {
			return this._eraserLayers;
		}

		public function set eraserLayers(bit:Array):void {
			this._eraserLayers=bit;
		}
		public function getOldW():Number{
			return this.oldW;
		}
		public function getOldH():Number{
			return this.oldH;
		}

		public function clone():DComponent {
			var p:PencilStroke=new PencilStroke(ProviderUtils.newID(), PencilStyle(this.style.clone()), this.startPoint, this.size);
			p.eraserLayers=this.eraserLayers;
			p.setProperties(new Point(this.x+10,this.y+20),new Point(this.width,this.height),new Point(this.oldW,this.oldH),this.points);
			p.setSource();
			p.reDraw(null);
			return p;
		}
	}
}