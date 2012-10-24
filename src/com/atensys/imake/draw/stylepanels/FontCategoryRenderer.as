package com.atensys.imake.draw.stylepanels
{
    import mx.controls.Label;
	    import mx.events.FlexEvent;
	 
	    public class FontCategoryRenderer extends Label
	    {
	        public function FontCategoryRenderer()
	        {
	            super();
	        }
	        override public function set data(value:Object):void{
	            super.data = value;
	            //setStyle("fontFamily",value.fontName);
	            text = value.fontCategory;
	            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
	        }
	    }
}