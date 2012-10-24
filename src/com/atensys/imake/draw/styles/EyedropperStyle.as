package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;
	

	/**
	 * Eyedropper style.
	 */
	public class EyedropperStyle implements DStyle {
		public function EyedropperStyle() {
		}

		public function set color(color:uint):void {
		}

		public function get color():uint {
			return 0;
		}
		public function set effect(value:ComponentEffects):void
		{
			
		}

		public function get effect():ComponentEffects
		{
			return null;
		}
		public function set color2(color:uint):void {
		}

		public function get color2():uint {
			return 0;
		}
		
		public function clone():DStyle{
			return null;
		}

	}
}