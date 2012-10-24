package com.atensys.imake.draw.styles
{
	import com.atensys.imake.draw.effect.ComponentEffects;
	
	import flash.display.Bitmap;

	public class SelectionStyle implements DStyle
	{
		public static var RECTANGLE:int=0;
		public static var CIRCLE:int=1;
		public static var ELIPSE:int=2;
		public static var MOUSE:int=3;
		public static var LINE:int=4;

		public static var NEW_MODE:int=0;
		public static var ADD_MODE:int=1;
		public static var REM_MODE:int=2;

		private var filters:Array;
		private var imageBitmap:Bitmap;
		private var _color:uint;
		private var _color2:uint;
		private var type:int=RECTANGLE;
		private var borderVisible:Boolean=true;
		private var borderThickness:int=1;
		private var selectionMode:int=0;

		public function SelectionStyle()
		{
		}

		public function setMode(mode:int):void
		{
			this.selectionMode=mode;
		}

		public function getMode():int
		{
			return this.selectionMode;
		}
		public function set effect(value:ComponentEffects):void
		{
			
		}

		public function get effect():ComponentEffects
		{
			return null;
		}
		public function setBorderThickness(th:int):void
		{
			this.borderThickness=th;
		}

		public function getBorderThickness():int
		{
			return this.borderThickness;
		}

		public function setBorderVisible(visible:Boolean):void
		{
			this.borderVisible=visible;
		}

		public function getBorderVisible():Boolean
		{
			return this.borderVisible;
		}

		public function setType(type:int):void
		{
			this.type=type;
		}

		public function getType():int
		{
			return this.type;
		}


		public function getFilters():Array
		{
			return this.filters;
		}

		public function setFilters(arr:Array):void
		{
			this.filters=arr;
		}

		public function getImageBitmap():Bitmap
		{
			return this.imageBitmap;
		}

		public function setImageBitmap(bitmap:Bitmap):void
		{
			this.imageBitmap=bitmap;
		}

		public function set color(color:uint):void
		{
			this._color=color;
		}

		public function get color():uint
		{
			return this._color;
		}

		public function set color2(color2:uint):void
		{
			this._color2=_color2;
		}

		public function get color2():uint
		{
			return this._color2;
		}
		
		public function clone():DStyle{
			return null;
		}

	}
}