package com.atensys.imake.draw.stylepanels {
	import com.atensys.imake.draw.styles.DStyle;
	
	import flash.events.Event;
	
	import mx.containers.HBox;
	import mx.core.UIComponent;

	/**
	 * Eyedropper style panel
	 */
	public class EyedropperStylePanel extends HBox implements DStylePanel {
		public function EyedropperStylePanel() {
			super();
		}

		public function getController():UIComponent {
			return this;
		}

		public function updateStyle(style:DStyle):void {
		}
		
		public function dStyleChanged(event:Event):void{
			
		}

	}
}