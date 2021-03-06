
/**
 * 	Generated by mxmlc 2.0
 *
 *	Package:	com.atensys.imake.draw
 *	Class: 		ProductChooser
 *	Source: 	D:\Work\imake.md\imake\src\com\atensys\imake\draw\ProductChooser.mxml
 *	Template: 	flex2/compiler/mxml/gen/ClassDef.vm
 *	Time: 		2010.11.28 10:20:16 EET
 */

package com.atensys.imake.draw
{

import flash.accessibility.*;
import flash.debugger.*;
import flash.display.*;
import flash.errors.*;
import flash.events.*;
import flash.events.MouseEvent;
import flash.external.*;
import flash.filters.*;
import flash.geom.*;
import flash.media.*;
import flash.net.*;
import flash.printing.*;
import flash.profiler.*;
import flash.system.*;
import flash.text.*;
import flash.ui.*;
import flash.utils.*;
import flash.xml.*;
import mx.binding.*;
import mx.containers.HBox;
import mx.containers.Panel;
import mx.controls.Button;
import mx.controls.Image;
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.UIComponentDescriptor;
import mx.core.mx_internal;
import mx.events.FlexEvent;
import mx.styles.*;



//	begin class def

public class ProductChooser
	extends mx.containers.Panel
{

	//	instance variables
	[Bindable]
/**
 * @private
 **/
	public var productImage : mx.controls.Image;


	//	type-import dummies


	//	Container document descriptor
private var _documentDescriptor_ : mx.core.UIComponentDescriptor = 
new mx.core.UIComponentDescriptor({
  type: mx.containers.Panel
  ,
  propertiesFactory: function():Object { return {
    childDescriptors: [
      new mx.core.UIComponentDescriptor({
        type: mx.containers.HBox
        ,
        events: {
          creationComplete: "___ProductChooser_HBox1_creationComplete"
        }
        ,
        propertiesFactory: function():Object { return {
          childDescriptors: [
            new mx.core.UIComponentDescriptor({
              type: mx.controls.Image
              ,
              id: "productImage"
              ,
              stylesFactory: function():void {
                this.horizontalAlign = "center";
              }
              ,
              propertiesFactory: function():Object { return {
                width: 35,
                height: 35
              }}
            })
          ,
            new mx.core.UIComponentDescriptor({
              type: mx.controls.Button
              ,
              events: {
                click: "___ProductChooser_Button1_click"
              }
              ,
              stylesFactory: function():void {
                this.icon = _embed_mxml_assets_right_png_349014260;
              }
              ,
              propertiesFactory: function():Object { return {
                height: 35,
                width: 15
              }}
            })
          ]
        }}
      })
    ]
  }}
})

	//	constructor (Flex display object)
    /**
     * @private
     **/
	public function ProductChooser()
	{
		super();

		mx_internal::_document = this;

		//	our style settings
		//	initialize component styles
		if (!this.styleDeclaration)
		{
			this.styleDeclaration = new CSSStyleDeclaration();
		}

		this.styleDeclaration.defaultFactory = function():void
		{
			this.backgroundAlpha = 0.5;
		};



		//	properties
		this.layout = "absolute";
		this.title = "Products";

		//	events

	}

	//	initialize()
    /**
     * @private
     **/
	override public function initialize():void
	{
 		mx_internal::setDocumentDescriptor(_documentDescriptor_);



		super.initialize();
	}

	//	scripts
	//	<Script>, line 19 - 48

			import mx.events.ListEvent;
			import mx.managers.PopUpManager;
			import com.atensys.imake.draw.colors.ProductsList;

			private var popup:ProductsList = new ProductsList();

			private function show():void {
				popup.x=this.localToGlobal(new Point(0, 0)).x;
				popup.y=this.localToGlobal(new Point(0, 0)).y + this.height + 5;
				popup.setStyle('borderStyle', 'solid');
				popup.setStyle('borderThickness', 3);
				popup.setStyle('cornerRadius', 5);
				PopUpManager.addPopUp(popup, this.parent, false);
				popup.addEventListener(FocusEvent.FOCUS_OUT, hidePopup);
			}
			
			private function initPopup():void{
//				popup.addEventListener(ListEvent.CHANGE, hidePopup);
				popup.addEventListener(ListEvent.ITEM_CLICK, hidePopup);
			}
			
			private function hidePopup(evt:Event):void{
				PopUpManager.removePopUp(popup);
			}
			
			public function getPopupList():ProductsList{
				return this.popup;
			}
		

	//	end scripts


    //	supporting function definitions for properties, events, styles, effects
/**
 * @private
 **/
public function ___ProductChooser_HBox1_creationComplete(event:mx.events.FlexEvent):void
{
	initPopup();
}

/**
 * @private
 **/
public function ___ProductChooser_Button1_click(event:flash.events.MouseEvent):void
{
	{show()}
}





	//	embed carrier vars
[Embed(source='assets/right.png')]
 private var _embed_mxml_assets_right_png_349014260:Class;

	//	end embed carrier vars


//	end class def
}

//	end package def
}
