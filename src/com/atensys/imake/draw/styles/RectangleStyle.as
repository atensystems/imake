package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;

	/**
	 *Defines style for rectangle tool.
	 *
	 * @author Andrei Sirghi
	 */
	public class RectangleStyle implements DStyle {
		private var _lineOpacity:int=100;
		private var _lineDiameter:int=1;
		private var _lineColor:uint=0x00000000;
		private var _fillOpacity:int=100;
		private var _fillColor:uint=0;
		private var _topLeftRound:int=0;
		private var _topRightRound:int=0;
		private var _bottomLeftRound:int=0;
		private var _bottomRightRound:int=0;
		private var _isSquare:Boolean=false;
		private var _effect:ComponentEffects;

		public function RectangleStyle() {
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

		public function set topLeftRound(round:int):void {
			this._topLeftRound=round;
		}

		public function set topRightRound(round:int):void {
			this._topRightRound=round;
		}

		public function set bottomLeftRound(round:int):void {
			this._bottomLeftRound=round;
		}

		public function set bottomRightRound(round:int):void {
			this._bottomRightRound=round;
		}

		public function get topLeftRound():int {
			return this._topLeftRound;
		}

		public function get topRightRound():int {
			return this._topRightRound;
		}

		public function get bottomLeftRound():int {
			return this._bottomLeftRound;
		}

		public function get bottomRightRound():int {
			return this._bottomRightRound;
		}

		public function set isSquare(square:Boolean):void {
			this._isSquare=square;
		}

		public function get isSquare():Boolean {
			return _isSquare;
		}

		public function toXML():XML {
			var root:XML=<rectangleStyle></rectangleStyle>;
			root.@['lineOpacity']=lineOpacity;
			root.@['lineDiameter']=lineDiameter;
			root.@['lineColor']=color2;
			root.@['fillOpacity']=fillOpacity;
			root.@['fillColor']=color;
			root.@['topLeftRound']=topLeftRound;
			root.@['topRightRound']=topRightRound;
			root.@['bottomLeftRound']=bottomLeftRound;
			root.@['bottomRightRound']=bottomRightRound;
			root.appendChild(effect.toXML());
			return root;
		}

		public function clone():DStyle {
			var s:RectangleStyle=new RectangleStyle();
			s._lineOpacity=this._lineOpacity;
			s._lineDiameter=this._lineDiameter;
			s._lineColor=this._lineColor;
			s._fillOpacity=this._fillOpacity;
			s._fillColor=this._fillColor;
			s._topLeftRound=this._topLeftRound;
			s._topRightRound=this._topRightRound;
			s._bottomLeftRound=this._bottomLeftRound;
			s._bottomRightRound=this._bottomRightRound;
			s._isSquare=this._isSquare;
			s._effect=this._effect.clone();
			return s;
		}
	}
}