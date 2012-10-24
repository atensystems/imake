package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.core.Application;
	import mx.core.BitmapAsset;

	/**
	 *Defines style for brush tool.
	 *
	 * @author Andrei Sirghi
	 */
	public class BrushStyle extends Sprite implements DStyle {
		private var _opacity:int=100;
		private var _diameter:int=1;
		private var _color:uint=0;
		private var _bitmap:BitmapData;
		private var _selectedBrush:int=0;
		private var _symmetryPoints:int=2;
		private var _isSymmetry:Boolean=false;
		private var _backgroundColor:uint=0xFFFFFFFF;
		private var _effect:ComponentEffects;

		public function BrushStyle() {
			effect=new ComponentEffects();
		}

		public function set opacity(opacity:int):void {
			this._opacity=opacity;
		}

		public function get opacity():int {
			return this._opacity;
		}

		public function set effect(value:ComponentEffects):void {
			_effect=value;
		}

		public function get effect():ComponentEffects {
			return _effect;
		}

		public function set diameter(diameter:int):void {
			this._diameter=diameter;
		}

		public function get diameter():int {
			return this._diameter;
		}

		public function set selectedBrush(s:int):void {
			this._selectedBrush=s;
		}

		public function get selectedBrush():int {
			return this._selectedBrush;
		}

		public function set bitmap(bitmap:BitmapData):void {
			this._bitmap=bitmap;
		}

		public function get bitmap():BitmapData {
			return this._bitmap;
		}

		public function set color(color:uint):void {
			this._color=color;
		}

		public function get color():uint {
			return this._color;
		}

		public function set color2(color:uint):void {
		}

		public function get color2():uint {
			return 0;
		}

		public function set backgroundColor(color:uint):void {
			_backgroundColor=color;
		}

		public function get backgroundColor():uint {
			return _backgroundColor;
		}

		public function get isSymmetry():Boolean {
			return this._isSymmetry;
		}

		public function set isSymmetry(isSymmetry:Boolean):void {
			this._isSymmetry=isSymmetry;
		}

		public function set symmetryPoints(symmetryPoints:int):void {
			this._symmetryPoints=symmetryPoints;
		}

		public function get symmetryPoints():int {
			return this._symmetryPoints;
		}
		private static function argb2int(a:Number, rgb:Number):uint
		{
			return (a << 24) | rgb;
		}

		private function completeHandler(event:Event):void {
			var loader:Loader=Loader(event.target.loader);
			var image:Bitmap=Bitmap(loader.content);

			this.bitmap=image.bitmapData;
		}

		public function toXML():XML {
			var root:XML=<brushStyle></brushStyle>;
			root.@['selectedBrush']=selectedBrush;
			root.@['opacity']=opacity;
			root.@['diameter']=diameter;
			root.@['color']=color;
			root.@['symmetryPoints']=symmetryPoints;
			root.@['isSymmetry']=isSymmetry;
			root.appendChild(effect.toXML());
			return root;
		}

		public function clone():DStyle {
			var s:BrushStyle=new BrushStyle();
			s._opacity=this._opacity;
			s._diameter=this._diameter;
			s._color=this._color;
			s._bitmap=this._bitmap;
			s._selectedBrush=this._selectedBrush;
			s._symmetryPoints=this._symmetryPoints;
			s._isSymmetry=this._isSymmetry;
			s._backgroundColor=this._backgroundColor;
			s._effect=this._effect.clone();
			return s;
		}
	}
}
