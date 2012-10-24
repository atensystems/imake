package com.atensys.imake.draw.stylepanels
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class FontEx
	{

		private var _fontName:String;

		private var _fontStyle:String;

		private var _fontType:String;

		private var _fontCategory:String;

	public function FontEx(fontName:String, fontStyle:String, fontType:String,fontCategory:String)
		{
			super();
			this.fontName = fontName;
			this.fontStyle = fontStyle;
			this.fontType = fontType;
			this.fontCategory=fontCategory;

		}

		public function set fontName(name:String):void
		{
			this._fontName = name;
		}

		public function get fontName():String
		{
			return this._fontName;
		}

		public function set fontStyle(style:String):void
		{
			this._fontStyle = style;
		}

		public function get fontStyle():String
		{
			return this._fontStyle;
		}

		public function set fontType(type:String):void
		{
			this._fontType = type;
		}

		public function get fontType():String
		{
			return this._fontType;
		}

		public function set fontCategory(category:String):void
		{
			this._fontCategory = category;
		}

		public function get fontCategory():String
		{
			return this._fontCategory;
		}

	}
}