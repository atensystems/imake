package com.atensys.imake.draw.component
{
	import flash.display.Sprite;
	
	public class EraserLayer
	{
		private var _shape:Sprite;
		private var _height:Number;
		private var _width:Number;
		private var _xml:XML;
		
		public function EraserLayer(shap:Sprite,w:Number,h:Number,x:XML)
		{
			shape=shap;
			height=h;
			width=w;
			xml=x;
		}
		public function set shape(sh:Sprite):void{
			this._shape = sh;
		}
		public function get shape():Sprite{
			return this._shape;
		}
		public function set height(h:Number):void{
			this._height = h;
		}
		public function get height():Number{
			return this._height;
		}
		public function set width(w:Number):void{
			this._width = w;
		}
		public function get width():Number{
			return this._width;
		}
		public function set xml(w:XML):void{
			this._xml = w;
		}
		public function get xml():XML{
			return this._xml;
		}
		
	}
}