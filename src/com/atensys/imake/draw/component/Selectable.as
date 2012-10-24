package com.atensys.imake.draw.component {
	import flash.sampler.getSetterInvocationCount;

	public interface Selectable {
		function setSelected(selected:Boolean):void;
		function isSelected():Boolean;

	}
}