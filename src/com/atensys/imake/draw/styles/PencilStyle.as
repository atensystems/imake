package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;

	import flash.display.CapsStyle;

	/**
	 *Defines style for pencil tool.
	 *
	 * @author Andrei Sirghi
	 */
	public class PencilStyle implements DStyle {
		private var _opacity:int=100;
		private var _diameter:int=1;
		private var _style:String=CapsStyle.NONE;
		private var _color:uint=0;
		private var _pixelHinting:Boolean=false;
		private var _lineJoint:String=null;
		private var _effect:ComponentEffects;

		public static var STYLE_SQUARE:int=1;
		public static var STYLE_ROUND:int=2;
		public static var STYLE_NARROW:int=3;

		public function PencilStyle() {
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

		public function set lineJoint(lineJoint:String):void {
			this._lineJoint=lineJoint;
		}

		public function get lineJoint():String {
			return this._lineJoint;
		}

		public function toXML():XML {
			var root:XML=<pencilStyle></pencilStyle>;
			root.@['opacity']=opacity;
			root.@['diameter']=diameter;
			root.@['style']=style;
			root.@['color']=color;
			root.@['pixelHinting']=pixelHinting;
			root.@['lineJoint']=lineJoint;
			root.appendChild(effect.toXML());
			return root;
		}

		public function clone():DStyle {
			var s:PencilStyle=new PencilStyle();
			s._opacity=this._opacity;
			s._diameter=this._diameter;
			s._style=this._style;
			s._color=this._color;
			s._pixelHinting=this._pixelHinting;
			s._lineJoint=this._lineJoint;
			s._effect=this._effect.clone();
			return s;
		}

	}
}