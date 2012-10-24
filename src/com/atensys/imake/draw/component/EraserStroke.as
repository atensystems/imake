package com.atensys.imake.draw.component
{
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.EraserStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.CapsStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;

	public class EraserStroke extends UIComponent implements DComponent
	{
		private var style:EraserStyle=new EraserStyle();
		private var startPoint:Point;
		private var line:Boolean=false;
		private var sourceBitmap:Sprite;
		private var bitmaptoErase:BitmapData;
		private var bitmapReserve:BitmapData;
		private var recttoErase:Rectangle;
		private var _points:ArrayCollection=new ArrayCollection();
		private var eraserID:int;
		private var index:int;
		public var shapeErase:Sprite=new Sprite();               

		public function EraserStroke(id:int, index:int, style:EraserStyle, startPoint:Point, size:Point, comp:DComponent)
		{
			super();
			this.style=style;
			this.startPoint=startPoint;
			this.eraserID=id;
			this.index=index;
			bitmaptoErase=comp.getSource().bitmapData;
		}

		public function setDStyle(dstyle:EraserStyle):void
		{
			this.style=dstyle;
		}

		public function getDStyle():DStyle
		{
			return this.style;
		}

		public function getName():String
		{
			return this.name;
		}

		public function setName(name:String):void
		{
			this.name=name;
		}

		public function rotate(degrees:Number):void
		{
			this.rotation=Util.degreesToRadians(degrees);
		}

		public function setPosition(x:Number, y:Number):void
		{
			this.x=x;
			this.y=y;
		}

		public function setSize(width:Number, heigth:Number):void
		{
			this.width=width;
			this.height=heigth;
		}

		public function setStartPoint(startPoint:Point):void
		{
			this.startPoint=startPoint;
		}

		public function lineTo(point:Point):void
		{
			points.addItem(point);
			var shape:Shape=new Shape();
			shape.graphics.beginFill(0x00FFFFFF);
			if (style.style == CapsStyle.ROUND)
				shape.graphics.drawCircle(point.x, point.y, style.diameter / 2);
			else
			{
				shape.graphics.drawRect(point.x-style.diameter / 2, point.y-style.diameter / 2, style.diameter, style.diameter);
			}
			shape.graphics.endFill();

			var blur:BlurFilter=new BlurFilter(style.smoth, style.smoth, 1);
			shape.filters=[blur];
			shapeErase.addChild(shape);
			bitmaptoErase.draw(shape, null, null, BlendMode.ERASE, null, true);
		}

		public function setActive(active:Boolean):void
		{
		}

		public function getController():UIComponent
		{
			return this;
		}

		public function toBitmapData():BitmapData
		{
			return null;
		}

		public function toXML():XML
		{
			var root:XML=<eraser></eraser>;
			root.@['id']=this.eraserID;
			root.appendChild(this.style.toXML());
			var point:XML;
			var p:String="<point></point>";
			for (var i:int=0; i < points.length; i++)
			{
				point=new XML(p);
				point.@['x']=Point(points[i]).x;
				point.@['y']=Point(points[i]).y;
				root.appendChild(point);
			}
			return root;
		}

		public function getSource():Bitmap
		{
			return null;
		}
		public function get eraserLayers():Array
		{
			return null;
		}
		public function set eraserLayers(bit:Array):void
		{
		}

		public function clone():DComponent{
			return null; 
		}
		public function get points():ArrayCollection{
			return _points;
		}
		public function set points(arr:ArrayCollection):void{
			this._points=arr;
		}
	}
}