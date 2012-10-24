package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;
	
	import flash.display.CapsStyle;


	public class EraserStyle implements DStyle {
		private var _smoth:int=5;
		private var _diameter:int=1;
		private var _style:String=CapsStyle.SQUARE;
		private var _color2:uint=0xFFFFFF;
		private var _effect:ComponentEffects;

		public function EraserStyle() {
			effect = new ComponentEffects();
		}

		public function set smoth(smothh:int):void {
			this._smoth=smothh;
		}

		public function get smoth():int {
			return this._smoth;
		}
		public function set effect(value:ComponentEffects):void
		{
			_effect=value;
		}

		public function get effect():ComponentEffects
		{
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
		}

		public function get color():uint {
			return 0;
		}

		public function set color2(color:uint):void {
			this._color2=color;
		}

		public function get color2():uint {
			return _color2;
		}
		public function toXML():XML{
			var root:XML=<eraserStyle></eraserStyle>;
			root.@['diameter']=diameter;
			root.@['style']=style;
			root.@['smoth']=smoth;
			return root;
		}
		
		public function clone():DStyle{
			return null;
		}

	}
}