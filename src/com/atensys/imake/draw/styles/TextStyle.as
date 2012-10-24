package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;

	import flash.display.Bitmap;

	import mx.core.mx_internal;
	use namespace mx_internal;

	public class TextStyle implements DStyle {
		private var _effect:ComponentEffects;
		private var _isEffectEnable:Boolean;

		public function TextStyle() {
			effect=new ComponentEffects();
		}

		public function set effect(value:ComponentEffects):void {
			_effect=value;
		}

		public function get effect():ComponentEffects {
			return _effect;
		}

		public function set isEffectEnable(value:Boolean):void {
			_isEffectEnable=value;
		}

		public function get isEffectEnable():Boolean {
			return _isEffectEnable;
		}



		public function set color(color:uint):void {
		}

		public function get color():uint {
			return 0;
		}

		public function set color2(color:uint):void {
		}

		public function get color2():uint {
			return 0;
		}

		public function toXML():XML {
			var root:XML=<textStyle></textStyle>;
			root.appendChild(effect.toXML());
			return root;
		}

		public function clone():DStyle {
			var s:TextStyle=new TextStyle();
			s._effect=this._effect.clone();
			s._isEffectEnable=this._isEffectEnable;
			return s;
		}

	}
}