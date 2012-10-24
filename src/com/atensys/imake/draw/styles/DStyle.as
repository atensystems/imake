package com.atensys.imake.draw.styles
{
	import com.atensys.imake.draw.effect.ComponentEffects;
	
	
	/**
	 * Super interface for each style in IDraw.
	 * 
	 * 
	 *@author Andrei Sirghi. 
	 */ 
	public interface DStyle
	{
		function set color(color:uint):void;
		function get color():uint;
		
		function set color2(color:uint):void;
		function get color2():uint;
		
		function set effect(ef:ComponentEffects):void;
		function get effect():ComponentEffects;
		
		function clone():DStyle;

	}
}