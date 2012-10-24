package com.atensys.imake.draw{
   
import flash.display.*;

import mx.core.UIComponent;
	
	/*
	 *Shapes factory class.
	 */
	public class ShapesFactory extends Sprite{
	    
	    //some initial values
	    public var topleftx:int=300;
	    public var toplefty:int=100;
	    public var downrightx:int=500;
	    public var downrighty:int=500;
	    public var radius:int=50;
	    public var color:int=0x0000FF;
	
	    public function Rectangle():UIComponent{
		    var rect:UIComponent=new UIComponent();
		    rect.graphics.lineStyle(1);
		    rect.graphics.beginFill(0x0000FF,1);
		    rect.graphics.drawRect(topleftx,toplefty,downrightx,downrighty);
		    rect.graphics.endFill();
		    return rect;
	    }
	   
	    public function Circle():UIComponent{
		    var circle:UIComponent=new UIComponent();
		    circle.graphics.lineStyle(1);
		    circle.graphics.beginFill(0x00FF00,1);
		    circle.graphics.drawCircle(topleftx,toplefty,radius);
		    circle.graphics.endFill();
		    return circle;
	    }
	}
}