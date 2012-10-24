package com.atensys.imake.draw.component
{
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.componentprovider.ProviderUtils;
	import com.atensys.imake.draw.stylepanels.StyleProvider;
	import com.atensys.imake.draw.stylepanels.TextStylePanel;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.TextStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.controls.TextArea;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.ResizeEvent;
	use namespace mx_internal;

	/**/
	public class TextUIComponent extends UIComponent implements DComponent, Selectable
	{
		private var textArea:TextArea;
		private var _style:TextStyle;
		private var selected:Boolean=true;
		private var startPoint:Point;
		private var textID:int;
		private var rx:int, ry:int, rw:int, rh:int;
		public var desktop:DrawDesktop;
		public var source_sprite:Sprite;
		private var source:Bitmap;
		private var sourceSet:Boolean=false;
		private var htmlText:String;
		private var _eraserLayers:Array=new Array();
		private var oldH:int;
		private var oldW:int;

		public function TextUIComponent(id:int, style:TextStyle, parent:DrawDesktop, startPoint:Point)
		{
			super();
			this.textID=id;
			this.style=style;
			this.desktop=parent;
			source=new Bitmap();
			source_sprite=new Sprite();
			addChild(source_sprite);
			this.addEventListener(ResizeEvent.RESIZE, resizeing);
		}

		public function resizeing(evt:ResizeEvent):void
		{
			textArea.height=this.height;
			textArea.width=this.width;
			reDraw(null);
		}

		public function reDraw(evt:Event):void
		{
			var uic:UIComponent=new UIComponent();
			source_sprite.scaleX*=this.width / oldW;
			source_sprite.scaleY*=this.height / oldH;
			uic.addChild(source_sprite);
			source.bitmapData=new BitmapData(this.width, this.height, true, 0x00FFFFFF);
			source.bitmapData.draw(uic);
			uic=new UIComponent();
			for (var i:int=0; i < _eraserLayers.length; i++)
			{
				EraserLayer(_eraserLayers[i]).shape.scaleX=this.width / EraserLayer(_eraserLayers[i]).width;
				EraserLayer(_eraserLayers[i]).shape.scaleY=this.height / EraserLayer(_eraserLayers[i]).height;
				uic.addChild(EraserLayer(_eraserLayers[i]).shape);
			}
			source.bitmapData.draw(uic, null, null, BlendMode.ERASE);
			source_sprite.scaleX=1.0;
			source_sprite.scaleY=1.0;
			for (var j2:int=0; j2 < _eraserLayers.length; j2++)
			{
				EraserLayer(_eraserLayers[j2]).shape.scaleX=1;
				EraserLayer(_eraserLayers[j2]).shape.scaleY=1;
			}
			if(style.effect.isDistress){
				Util.makeDistress(source.bitmapData,style.effect.distress.distressN);
			}
			Util.makeFlip(this);
		}

		public function initComponents():void
		{
			textArea=new TextArea();
			textArea.verticalScrollPolicy="off";
			textArea.horizontalScrollPolicy="off";
			textArea.width=this.width;
			textArea.height=this.height;
			textArea.text="Input text Here";
			textArea.setStyle("backgroundAlpha", 0);
			textArea.setStyle("focusAlpha", 0);
			textArea.setStyle("borderStyle", "none");
			textArea.addEventListener(MouseEvent.CLICK, updateStylePanel);
			textArea.addEventListener(KeyboardEvent.KEY_UP, keyUHandler);
			textArea.addEventListener(KeyboardEvent.KEY_DOWN, keyDHandler);
			addChild(textArea);
		}
		public function setTextAreaHtmlText(html:String):void{
			this.textArea.htmlText = html;
			htmlText = html;
			
		}

		public function lineTo(point:Point):void
		{
			source_sprite.graphics.clear();
			source_sprite.graphics.lineStyle(1, 0x000000000, .2);
			rx=startPoint.x < point.x ? startPoint.x : point.x;
			ry=startPoint.y < point.y ? startPoint.y : point.y;
			rw=Math.abs(point.x - startPoint.x);
			rh=Math.abs(point.y - startPoint.y);
			source_sprite.graphics.drawRect(rx, ry, rw, rh);
			source_sprite.graphics.endFill();
		}

		public function getRectu():void
		{
			removeAllChildren();
			this.height=rh;
			this.width=rw;
			this.x=rx;
			this.y=ry;
			if (rh == 0)
			{
				this.height=40;
			}
			if (rw == 0)
			{
				this.width=100;
			}
			if (rx == 0)
			{
				this.x=desktop.getDrawable().mouseX;
			}
			if (ry == 0)
			{
				this.y=desktop.getDrawable().mouseY;
			}
		}

		public function updateStylePanel(event:MouseEvent):void
		{
			Application.application.desktop.addListenerVisibilitiButton();
			StyleProvider.getInstance().setStyleBar(DComponentType.TEXT);
			(TextStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).setEnablePanel(true);
			(TextStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).getTextStyles(this.textArea);
			(TextStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).setDstyle(this.style);
			(TextStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).setTextarea(this.textArea);
			if (textArea.text == "Input text Here")
			{
				textArea.htmlText="";

			}

		}

		private function keyUHandler(event:KeyboardEvent):void
		{

			(TextStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).getTextStyles(this.textArea);
		}

		private function keyDHandler(event:KeyboardEvent):void
		{
			if ((TextStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).textFormatChanged)
			{
				this.textArea.getTextField().defaultTextFormat=(TextStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).previousTextFormat;
				(TextStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).textFormatChanged=false;
			}
		}

		public function removeAllChildren():void
		{
			for (var i:int=0; i < numChildren; i++)
			{
				trace("Copkilu " + i + "  " + this.getChildAt(i));
				this.removeChildAt(i);
			}
		}

		/**
		 * Set Text Area in place textEfect
		 * */
		public function setTextArea(evt:MouseEvent):void
		{
			Util.clean(eraserLayers);
			textArea.htmlText=htmlText;
			textArea.validateDisplayList();
			this.doubleClickEnabled=false;
			this.removeEventListener(MouseEvent.DOUBLE_CLICK, setTextArea);
			if (this.contains(source))
			this.removeChild(source);
			removeAllChildren();
			this.addChild(textArea);
			this.style.isEffectEnable=false;
			if(evt!=null)evt.stopPropagation();
		}

		/**
		 * Set TextEfect in place textArea
		 * */
		public function setTextEffect():void
		{
			htmlText=textArea.htmlText;
			removeAllChildren();
			source=new Bitmap(toBitmapData());
			source.filters = style.effect.filters;
			sourceSet=true;
			source_sprite=new Sprite();
			oldH=this.height;
			oldW=this.width;
			source_sprite.addChild(new Bitmap(source.bitmapData.clone()));
			this.doubleClickEnabled=true;
			this.addEventListener(MouseEvent.DOUBLE_CLICK, setTextArea, false, 5);
			this.addChild(source);
			source.filters = style.effect.filters;
			this.style.isEffectEnable=true;
			reDraw(null);
		}

		private function createRectShape(rect:Rectangle, color:uint):Shape
		{
			var rectShape:Shape=new Shape();
			rectShape.graphics.lineStyle(0, color);
			rectShape.graphics.drawRect(rect.left, rect.top, rect.width, rect.height);
			return rectShape;
		}

		public function getTextArea():TextArea
		{
			return this.textArea;
		}

		public function set style(value:TextStyle):void
		{
			_style=value;
		}

		public function get style():TextStyle
		{
			return _style;
		}

		public function getDStyle():DStyle
		{
			return style;
		}

		public function setDStyle(dstyle:TextStyle):void
		{
			this.style=dstyle;
		}

		public function getName():String
		{
			return "";
		}

		public function setName(name:String):void
		{
		}

		public function rotate(degrees:Number):void
		{
		}

		public function setPosition(x:Number, y:Number):void
		{
		}

		public function setSize(width:Number, heigth:Number):void
		{
		}

		public function setActive(active:Boolean):void
		{
			if (!active)
			{
				dispatchEvent(new Event("repaint"));
			}
		}

		public function getController():UIComponent
		{
			return this;
		}

		public function toBitmapData():BitmapData
		{
			var efectBitmapData:BitmapData=new BitmapData(this.textArea.width, this.textArea.height, true, 0x00FFFFFF);
			efectBitmapData.draw(this.textArea);
			return efectBitmapData;
		}

		public function setSelected(selected:Boolean):void
		{
			this.selected=selected;
		}
		public function setProperties(dComXY:Point,oldWH:Point):void{
			this.x = dComXY.x;
			this.y = dComXY.y;
			this.width = oldWH.x;//dComWH.x;
			this.height = oldWH.y;//dComWH.y;
			//this.oldW = oldWH.x;
			//this.oldH = oldWH.y;
		}

		public function isSelected():Boolean
		{
			return this.selected;
		}

		public function setStartPoint(startPoint:Point):void
		{
			this.startPoint=startPoint;
		}

		public function toXML():XML
		{
			var root:XML=<text></text>;
			root.@['id']=this.textID;
			root.@['dcX']=this.x;
			root.@['dcY']=this.y;
			
			root.@['dcWidth']=this.width;
			root.@['dcHeight']=this.height;
			root.@['oldWidth']=oldW;
			root.@['oldHeight']=oldH;
			var htmlText:XML=<htmlText>{textArea.htmlText}</htmlText>;
			root.appendChild(htmlText);
			root.appendChild(this.style.toXML());
			return root;
		}

		public function getSource():Bitmap
		{
			if (sourceSet)
			{
				return source;
			}
			var myFormat:TextFormat=new TextFormat();
			myFormat.font="Verdana";
			myFormat.size=12;
			var textBitmd:BitmapData=new BitmapData(40, 40, true, 0x00FFFFFF);
			var textField:TextField=new TextField();
			textField.defaultTextFormat=myFormat;
			textField.embedFonts=true;
			textField.text="Text" + textID;
			textBitmd.draw(textField);
			return new Bitmap(textBitmd);
		}

		public function get eraserLayers():Array
		{
			return _eraserLayers;
		}

		public function set eraserLayers(bit:Array):void
		{
			this._eraserLayers=bit;
		}

		public function clone():DComponent
		{
			var t:TextUIComponent=new TextUIComponent(ProviderUtils.newID(), TextStyle(this.style.clone()), this.desktop, this.startPoint);
			t.eraserLayers=this.eraserLayers;
			t.setProperties(new Point(this.x+10,this.y+20),new Point(this.oldW,this.oldH));
			t.removeAllChildren();
			t.initComponents();
			t.setTextAreaHtmlText(this.textArea.htmlText);
			t.setTextArea(null);
			t.setProperties(new Point(this.x+10,this.y+20),new Point(this.width,this.height));
			return t;
		}
	}
}