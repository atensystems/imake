package com.atensys.imake.draw.stylepanels
{
    import mx.controls.Label;
	    import mx.events.FlexEvent;
	 
	    public class FontListRenderer extends Label
	    {
	        public function FontListRenderer()
	        {
	            super();
	        }
	        override public function set data(value:Object):void{
	            super.data = value;
	            setStyle("fontFamily",value.fontName);
	            setStyle("fontSize",15);
	            text = value.fontName;
	            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
	        }
	    }
}