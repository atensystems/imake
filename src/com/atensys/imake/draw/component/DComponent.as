package com.atensys.imake.draw.component
{
	import com.atensys.imake.draw.styles.DStyle;
	
	import flash.display.Bitmap;
	
	import mx.core.UIComponent;

	/**
	 * The super interface for each component which can be drawn on the drawdesktop.
	 *
	 * @author Andrei Sirghi.
	 */
	public interface DComponent
	{

		/**
		 * Gets component name.
		 * @return component name.
		 */
		function getName():String;

		/**
		 * Sets component name.
		 *  @param name component name to set.
		 */
		function setName(name:String):void;

		/**
		 * Sets component position.
		 *  @param x represents component x position.
		 *  @param y represents component y position.
		 */
		function setPosition(x:Number, y:Number):void;

		/**
		 * Sets component size.
		 *  @param width represents new component width.
		 *  @param height represents new component height.
		 */
		function setSize(width:Number, height:Number):void;

		/**
		 * This methods rotates current component with the given degrees.
		 *  @param degrees the degrees to rotate component with.
		 */
		function rotate(degrees:Number):void;
		function setActive(active:Boolean):void;
		function getController():UIComponent;
		function getSource():Bitmap;
		function toXML():XML;
		function getDStyle():DStyle;
		function get eraserLayers():Array;
		function set eraserLayers(arr:Array):void;
		function clone():DComponent;
	}
}