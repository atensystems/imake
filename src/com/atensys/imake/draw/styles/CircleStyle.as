package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;

	/**
	 *Defines style for circle tool.
	 *
	 * @author Andrei Sirghi
	 */
	public class CircleStyle implements DStyle {
		private var _lineOpacity:int=100;
		private var _lineDiameter:int=1;
		private var _lineColor:uint=0x00000000;
		private var _fillOpacity:int=100;
		private var _fillColor:uint=0;
		private var _isCircle:Boolean=false;
		private var _effect:ComponentEffects;

		public function CircleStyle() {
			effect=new ComponentEffects();
		}

		public function set lineOpacity(opacity:int):void {
			this._lineOpacity=opacity;
		}

		public function get lineOpacity():int {
			return this._lineOpacity;
		}

		public function set effect(value:ComponentEffects):void {
			_effect=value;
		}

		public function get effect():ComponentEffects {
			return _effect;
		}

		public function set fillOpacity(opacity:int):void {
			this._fillOpacity=opacity;
		}


		public function get fillOpacity():int {
			return this._fillOpacity;
		}

		public function set lineDiameter(diameter:int):void {
			this._lineDiameter=diameter;
		}

		public function get lineDiameter():int {
			return this._lineDiameter;
		}


		public function set color(color:uint):void {
			this._fillColor=color;
		}

		public function get color():uint {
			return this._fillColor;
		}

		public function set color2(color:uint):void {
			this._lineColor=color;
		}

		public function get color2():uint {
			return this._lineColor;
		}

		public function set isCircle(circle:Boolean):void {
			this._isCircle=circle;
		}

		public function get isCircle():Boolean {
			return _isCircle;
		}

		public function toXML():XML {
			var root:XML=<circleStyle></circleStyle>;
			root.@['lineOpacity']=lineOpacity;
			root.@['lineDiameter']=lineDiameter;
			root.@['lineColor']=color2;
			root.@['fillOpacity']=fillOpacity;
			root.@['fillColor']=color;
			root.appendChild(effect.toXML());
			return root;
		}

		public function clone():DStyle {
			var s:CircleStyle=new CircleStyle();
			s._lineOpacity=this._lineOpacity;
			s._lineDiameter=this._lineDiameter;
			s._lineColor=this._lineColor;
			s._fillOpacity=this._fillOpacity;
			s._fillColor=this._fillColor;
			s._isCircle=this._isCircle;
			s._effect=this._effect.clone();
			return s;
		}
	}
}