package com.atensys.imake.draw.stylepanels {
	import com.atensys.imake.draw.styles.DStyle;
	
	import flash.events.Event;
	
	import mx.core.UIComponent;

	public interface DStylePanel {
		function getController():UIComponent;
		function updateStyle(style:DStyle):void;
		function dStyleChanged(event:Event):void
	}
}