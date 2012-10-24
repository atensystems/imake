package com.atensys.imake.draw.component
{
	import mx.events.FlexEvent;
	
	public class ComponentResizeEvent extends FlexEvent
	{
		public static var COMPONENT_RESIZE:String = "ComponentResize";
		
		public function ComponentResizeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}