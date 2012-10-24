package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;

	import flash.display.CapsStyle;

	/**
	 *Defines style for line tool.
	 *
	 * @author Andrei Sirghi
	 */
	public class LineStyle implements DStyle {
		private var _opacity:int=100;
		private var _diameter:int=1;
		private var _style:String=CapsStyle.NONE;
		private var _color:uint=0;
		private var _pixelHinting:Boolean=false;
		private var _shapeTrails:Boolean=false;
		private var _effect:ComponentEffects;

		public function LineStyle() {
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

		public function set style(style:String):void {
			this._style=style;
		}

		public function get style():String {
			return this._style;
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

		public function get pixelHinting():Boolean {
			return this._pixelHinting;
		}

		public function set pixelHinting(pixelHinting:Boolean):void {
			this._pixelHinting=pixelHinting;
		}

		public function set shapeTrails(shapeTrails:Boolean):void {
			this._shapeTrails=shapeTrails;
		}

		public function get shapeTrails():Boolean {
			return this._shapeTrails;
		}

		public function toXML():XML {
			var root:XML=<lineStyle></lineStyle>;
			root.@['opacity']=opacity;
			root.@['diameter']=diameter;
			root.@['style']=style;
			root.@['color']=color;
			root.@['pixelHinting']=pixelHinting;
			root.@['shapeTrails']=shapeTrails;
			root.appendChild(effect.toXML());
			return root;
		}

		public function clone():DStyle {
			var s:LineStyle=new LineStyle();
			s._opacity=this._opacity;
			s._diameter=this._diameter;
			s._style=this._style;
			s._color=this._color;
			s._pixelHinting=this._pixelHinting;
			s._shapeTrails=this._shapeTrails;
			s._effect=this._effect.clone();
			return s;
		}

	}
}