package com.atensys.imake.draw.component {

	import com.atensys.imake.Util;
	import com.atensys.imake.draw.componentprovider.ProviderUtils;
	import com.atensys.imake.draw.styles.BrushStyle;
	import com.atensys.imake.draw.styles.DStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	public class BrushStroke extends UIComponent implements DComponent {

		private var style:BrushStyle;
		private var startPoint:Point;
		private var line:Boolean=false;
		private var sourceBitmap:BitmapData;
		private var backgroundBitmapData:BitmapData;
		private var brushID:int;
		private var points:ArrayCollection=new ArrayCollection();
		private var source:Bitmap;
		private var oldH:int;
		private var oldW:int;
		private var size:Point;
		private var _eraserLayers:Array=new Array();

		public function BrushStroke(id:int, style:BrushStyle, start:Point, size:Point) {
			this.size=size;
			this.brushID=id;
			this.style=style;
			if (this.style.diameter == 1) {
				this.style.diameter=2;
			}
			backgroundBitmapData=new BitmapData(size.x, size.y, true, 0x00FFFFFF);
			this.alpha=style.opacity / 100.0;
			source=new Bitmap(backgroundBitmapData);
			addChild(source);
			startPoint=start;
			initStyle();
			this.addEventListener(ResizeEvent.RESIZE, resizeing);
			this.addEventListener("styleChanged", reDraw);
		}

		public function initStyle():void {
			sourceBitmap=style.bitmap;
			if (style.bitmap == null) {
				return;
			}
			for (var iy:int=0; iy < style.bitmap.height; iy++) {
				for (var ix:int=0; ix < style.bitmap.width; ix++) {
					var red:int=(style.bitmap.getPixel(ix, iy) >> 16) & 0xFF;
					var green:int=(style.bitmap.getPixel(ix, iy) >> 8) & 0xFF;
					var blue:int=style.bitmap.getPixel(ix, iy) & 0xFF;
					var a:Number=(255 - 0.3 * red + 0.59 * blue + 0.11 * blue);
					style.bitmap.setPixel(ix, iy, argb2int(a, style.color));
				}
			}
		}

		private function resizeing(evt:ResizeEvent):void {
			reDraw(null);
		}

		public function lineTo(point:Point):void {
			if (!style.isSymmetry) {
				var m:Matrix=new Matrix();
				m.translate(point.x - style.diameter / 2, point.y - style.diameter / 2);
				var bitm:Bitmap=new Bitmap(sourceBitmap);
				bitm.scaleX*=style.diameter / style.bitmap.width;
				bitm.scaleY*=style.diameter / style.bitmap.height;
				var spr:Sprite=new Sprite();
				spr.addChild(bitm);
				backgroundBitmapData.draw(spr, m);
				points.addItem(point);
				line=true;
			} else {
				var center:Point=new Point();
				center.x=Application.application.desktop.getDrawable().width / 2;
				center.y=Application.application.desktop.getDrawable().height / 2;

				var p:Point=point;
				for (var k:int=0; k < style.symmetryPoints; k++) {
					m=new Matrix();
					m.translate(p.x - style.diameter / 2, p.y - style.diameter / 2);
					bitm=new Bitmap(sourceBitmap);
					bitm.scaleX*=style.diameter / style.bitmap.width;
					bitm.scaleY*=style.diameter / style.bitmap.height;
					spr=new Sprite();
					spr.addChild(bitm);
					backgroundBitmapData.draw(spr, m);
					if (k == 0) {
						points.addItem(point);
						line=true;
					}
					p=symmetryPoint(center, p, style.symmetryPoints);
				}
			}
		}

		public function reDraw(evt:Event):void {
			initStyle();
			this.alpha=style.opacity / 100.0;
			source.bitmapData=new BitmapData(this.width, this.height, true, 0x00FFFFFF);
			if (!style.isSymmetry) {
				for (var j:int=0; j < points.length; j++) {
					var m:Matrix=new Matrix();
					m.translate(Point(points[j]).x - style.diameter / 2, Point(points[j]).y - style.diameter / 2);
					m.scale(this.width / oldW, this.height / oldH);
					var bitm:Bitmap=new Bitmap(sourceBitmap.clone());
					bitm.scaleX*=style.diameter / style.bitmap.width;
					bitm.scaleY*=style.diameter / style.bitmap.height;
					var spr:Sprite=new Sprite();
					spr.addChild(bitm);
					source.bitmapData.draw(spr, m);
				}
			} else {
				var center:Point=new Point();

				center.x=Application.application.desktop.getDrawable().width / 2;
				center.y=Application.application.desktop.getDrawable().height / 2;

				for (j=0; j < points.length; j++) {
					var p:Point=Point(points[j]);
					for (var k:int=0; k < style.symmetryPoints; k++) {
						m=new Matrix();
						m.translate(p.x - style.diameter / 2, p.y - style.diameter / 2);
						m.scale(this.width / oldW, this.height / oldH);
						bitm=new Bitmap(sourceBitmap.clone());
						bitm.scaleX*=style.diameter / style.bitmap.width;
						bitm.scaleY*=style.diameter / style.bitmap.height;
						spr=new Sprite();
						spr.addChild(bitm);
						source.bitmapData.draw(spr, m);
						p=symmetryPoint(center, p, style.symmetryPoints);
					}
				}
			}
			doErase();
			if (style.effect.isDistress) {
				Util.makeDistress(source.bitmapData, style.effect.distress.distressN);
			}
			Util.makeFlip(this);
		}

		private function symmetryPoint(center:Point, start:Point, sp:int):Point {
			var r:Number=Math.sqrt((center.x - start.x)*(center.x - start.x) + (center.y - start.y)*(center.y - start.y));
			var length:Number=2 * Math.PI * r / sp;
			var cosB:Number=Math.abs(center.x - start.x) / r;
			var sinB:Number=Math.abs(center.y - start.y) / r;

			var b:Number=Math.asin(sinB);
			b=b * 180 / Math.PI;
			var a:Number=360 / sp;

			var f:Point=new Point();
			if(start.x<center.x){
				f.x=center.x - r * Math.cos(Math.abs(b - a) * Math.PI / 180);
			}
			else{
				f.x=center.x+r * Math.cos(Math.abs(b - a) * Math.PI / 180);
			}
			if(start.y<center.y){
				f.y=center.y + r * Math.sin(Math.abs(b - a) * Math.PI / 180);
			}
			else{
				f.y=center.y - r * Math.sin(Math.abs(b - a) * Math.PI / 180);
			}
			return f;
		}

		private function doErase():void {
			var uic:UIComponent=new UIComponent();
			for (var i:int=0; i < eraserLayers.length; i++) {
				EraserLayer(eraserLayers[i]).shape.scaleX=this.width / EraserLayer(eraserLayers[i]).width;
				EraserLayer(eraserLayers[i]).shape.scaleY=this.height / EraserLayer(eraserLayers[i]).height;
				uic.addChild(EraserLayer(eraserLayers[i]).shape);
			}
			source.bitmapData.draw(uic, null, null, BlendMode.ERASE);
			for (var j2:int=0; j2 < eraserLayers.length; j2++) {
				EraserLayer(eraserLayers[j2]).shape.scaleX=1;
				EraserLayer(eraserLayers[j2]).shape.scaleY=1;
			}
		}

		public function setDStyle(dstyle:BrushStyle):void {
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
			this.line=false;
			this.startPoint=startPoint;
		}

		public function setActive(active:Boolean):void {
			if (!active && !line) {
				var m:Matrix=new Matrix();
				m.scale(style.diameter / style.bitmap.width, style.diameter / style.bitmap.height);
				m.translate(startPoint.x - style.diameter / 2, startPoint.y - style.diameter / 2);
				backgroundBitmapData.draw(sourceBitmap, m);
			}
			if (!active) {
				dispatchEvent(new Event("repaint"));
			}
		}

		public function getController():UIComponent {
			return this;
		}

		public function toBitmapData():BitmapData {
			return backgroundBitmapData;
		}

		public function getRectu():void {
			var rect:Rectangle=backgroundBitmapData.getColorBoundsRect(0xFF000000, 0x00000000, false);
			var bmdLine:BitmapData=new BitmapData(rect.width, rect.height, true, 0xFF000000);
			var bytes:ByteArray=backgroundBitmapData.getPixels(rect);
			bytes.position=0;
			bmdLine.setPixels(new Rectangle(0, 0, rect.width, rect.height), bytes);
			backgroundBitmapData=bmdLine;
			source=new Bitmap(backgroundBitmapData);
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

		private static function argb2int(a:Number, rgb:Number):uint {
			return (a << 24) | rgb;
		}

		public function toXML():XML {
			var root:XML=<brush></brush>;
			root.@['id']=this.brushID;
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
			for (var j2:int=0; j2 < eraserLayers.length; j2++) {
				root.appendChild(EraserLayer(eraserLayers[j2]).xml);
			}
			return root;
		}

		public function getSource():Bitmap {
			return source;
		}

		public function setSource():void {
			backgroundBitmapData=new BitmapData(oldW, oldH, true, 0x00000000);
			source=new Bitmap(backgroundBitmapData);
			this.removeChildAt(0);
			this.addChild(source);
			this.source.filters=style.effect.filters;
		}

		public function setProperties(dComXY:Point, dComWH:Point, oldWH:Point, points:ArrayCollection):void {
			this.x=dComXY.x;
			this.y=dComXY.y;
			this.width=dComWH.x;
			this.height=dComWH.y;
			this.oldW=oldWH.x;
			this.oldH=oldWH.y;
			this.points=points;
		}

		public function get eraserLayers():Array {
			return this._eraserLayers;
		}

		public function set eraserLayers(bit:Array):void {
			this._eraserLayers=bit;
		}

		public function clone():DComponent {
			var b:BrushStroke=new BrushStroke(ProviderUtils.newID(), BrushStyle(this.style.clone()), this.startPoint, this.size);
			b.eraserLayers=this.eraserLayers;
			b.setProperties(new Point(this.x + 10, this.y + 20), new Point(this.width, this.height), new Point(this.oldW, this.oldH), this.points);
			b.setSource();
			b.reDraw(null);
			return b;
		}
	}
}