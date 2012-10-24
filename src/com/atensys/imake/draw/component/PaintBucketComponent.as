package com.atensys.imake.draw.component {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.componentprovider.ProviderUtils;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.PaintBucketStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	public class PaintBucketComponent extends UIComponent implements DComponent {
		private var btFilled:BitmapData;
		private var btFinal:BitmapData;
		private var btSource:BitmapData;
		private var btTemp:BitmapData;
		private var point:Point;
		private var size:Point;
		private var source:Bitmap;
		private var startColor:uint;
		private var style:PaintBucketStyle;
		private var _eraserLayers:Array=new Array();
		public var bucketName:String;
		private var bucketID:int;

		public function PaintBucketComponent(id:int, bname:String, sourceBitmap:BitmapData, point:Point, style:PaintBucketStyle, size:Point) {
			this.btSource=sourceBitmap;
			this.bucketName=bname;
			this.bucketID=id;
			this.point=point;
			this.style=style;
			this.size=size;
			this.addEventListener("styleChanged", redraw);
			this.addEventListener(ResizeEvent.RESIZE, resize);
			if (sourceBitmap != null) {
				startColor=btSource.getPixel(point.x, point.y);
				redraw(null);
			}
		}

		public function get eraserLayers():Array {
			return _eraserLayers;
		}

		public function set eraserLayers(bit:Array):void {
			this._eraserLayers=bit;
		}
		public function setbtSource(bit:BitmapData):void {
			this.btSource=bit;
		}

		public function getController():UIComponent {
			return this;
		}

		public function getDStyle():DStyle {
			return this.style;
		}

		public function getName():String {
			return null;
		}

		public function getSource():Bitmap {
			return source;
		}
		public function setProperties(dComXY:Point, dComWH:Point):void{
			this.x= dComXY.x;
			this.y=dComXY.y;
			this.width = dComWH.x;
			this.height = dComWH.y;
		}
		public function setStartColor():void{
			this.startColor=btSource.getPixel(point.x, point.y);
		}

		public function redraw(evt:Event):void {
			if (source != null && contains(source)) {
				removeChildAt(0);
			}
			btFilled=new BitmapData(size.x, size.y, true, 0x00000000);
			btTemp=new BitmapData(size.x, size.y, true, 0x000000);
			var col:uint;
			var r:Rectangle=new Rectangle();
			r.height=1;
			r.width=1;
			for (var i:int=0; i < btTemp.width; i++) {
				for (var j:int=0; j < btTemp.height; j++) {
					col=btSource.getPixel(i, j)
					if (matchesTolerance(col)) {
						r.x=i;
						r.y=j;
						btTemp.setPixel32(i, j, 0xFFFF0000);
					}
				}
			}
			btTemp.floodFill(point.x, point.y, 0xFF00FF00);
			btFilled.threshold(btTemp, btTemp.rect, new Point(0, 0), "==", 0xFF00FF00, 0xFF000000 + style.color, 0xFF00FF00, false);
			r=btFilled.getColorBoundsRect(0xFFFFFFFF, 0xFF000000 + style.color, true);
			btFinal=new BitmapData(r.width, r.height, true, 0x00000000);
			btFinal.copyPixels(btFilled, r, new Point());
			source=new Bitmap(btFinal);
			this.x=r.x - 4;
			this.y=r.y - 4;
			this.width=r.width;
			this.height=r.height;
			addChild(source);
			source.filters = style.effect.filters;
			Application.application.desktop.setFocusC(this);
			resize(null);
		}

		public function resize(evt:Event):void {
			this.source.bitmapData=Util.getResizedBitmapData(btFinal, this.width, this.height);
			doErase();
			if(style.effect.isDistress){
				Util.makeDistress(source.bitmapData,style.effect.distress.distressN);
			}
			Util.makeFlip(this);
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

		public function rotate(degrees:Number):void {
		}

		public function setActive(active:Boolean):void {
			if (!active) {
				dispatchEvent(new Event("repaint"));
			}
		}

		public function setDStyle(style:PaintBucketStyle):void {
			this.style=style;
		}

		public function setName(name:String):void {
		}

		public function setPosition(x:Number, y:Number):void {
		}

		public function setSize(width:Number, height:Number):void {
		}

		public function toBitmapData():BitmapData {
			return this.btSource;
		}

		public function toXML():XML {
			var root:XML=<bucket></bucket>;
			root.@['id']=this.bucketID;
			root.@['name']=this.bucketName;
			root.@['pointX']=this.point.x;
			root.@['pointY']=this.point.y;
			root.@['sizeW']=this.size.x;
			root.@['sizeH']=this.size.y;
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

		private function matchesTolerance(color:uint):Boolean {
			var red:int=(color >> 16) & 0xFF;
			var green:int=(color >> 8) & 0xFF;
			var blue:int=color & 0xFF;

			var redT:int=(startColor >> 16) & 0xFF;
			var greenT:int=(startColor >> 8) & 0xFF;
			var blueT:int=startColor & 0xFF;
			var tol:Number=style.tolerance / 100.0 * 256;
			if (red >= redT - tol && red <= redT + tol && green >= greenT - tol && green <= greenT + tol && blue >= blueT - tol && blue <= blueT + tol) {
				return true;
			}
			return false;
		}

		public function clone():DComponent {
			var p:PaintBucketComponent=new PaintBucketComponent(ProviderUtils.newID(), Util.currentTime(), this.btSource.clone(), this.point, PaintBucketStyle(this.style.clone()), this.size);
			p.eraserLayers = this.eraserLayers;
			p.setProperties(new Point(this.x+10,this.y+20),new Point(this.width,this.height));
			p.redraw(null);
			return p;
		}
	}
}

