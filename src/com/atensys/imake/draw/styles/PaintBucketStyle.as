package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;


	public class PaintBucketStyle implements DStyle {
		private var _color:uint=0;
		private var _tolerance:uint=0;
		private var _effect:ComponentEffects;

		public function PaintBucketStyle() {
			effect=new ComponentEffects();
		}

		public function set color(color:uint):void {
			this._color=color;
		}

		public function get color():uint {
			return this._color;
		}

		public function set effect(value:ComponentEffects):void {
			this._effect=value;
		}

		public function get effect():ComponentEffects {
			return _effect;
		}

		public function set tolerance(_tolerance:uint):void {
			this._tolerance=_tolerance;
		}

		public function get tolerance():uint {
			return this._tolerance;
		}

		public function set color2(color:uint):void {
		}

		public function get color2():uint {
			return 0;
		}
		public function toXML():XML {
			var root:XML=<bucketStyle></bucketStyle>;
			root.@['color']=this.color;
			root.@['tolerance']=this.tolerance;
			root.appendChild(effect.toXML());
			return root;
		}

		public function clone():DStyle {
			var s:PaintBucketStyle=new PaintBucketStyle();
			s._color=this._color;
			s._tolerance=this._tolerance;
			s._effect=this._effect.clone();
			return s;
		}
	}
}