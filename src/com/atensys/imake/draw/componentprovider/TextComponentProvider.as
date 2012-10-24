package com.atensys.imake.draw.componentprovider
{
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.TextUIComponent;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.TextStyle;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class TextComponentProvider implements DComponentProvider
	{
		private var parent:DrawDesktop;
		private var style:TextStyle;
		private var active:Boolean;
		private var currentText:TextUIComponent;
		private var isInitialize:Boolean=false;
		private var iD:int=0;

		public function TextComponentProvider()
		{
			active=true;
		}

		public function setParent(parent:DrawDesktop):void
		{
			this.parent=parent;

		}

		public function setDStyle(style:DStyle):void
		{
			this.style=TextStyle(style);
			currentText.setDStyle(this.style);
		}

		public function setActive(active:Boolean):void
		{
			this.active=active;
			if (active)
			{
				this.style=new TextStyle();
				enableDrawingEvents();
			}
			else
			{
				if (currentText!=null&&!currentText.style.isEffectEnable)
					setEfect();
				disableDrawingEvents();
			}
		}

		public function enableDrawingEvents():void
		{
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 5);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 5);
		}

		public function disableDrawingEvents():void
		{
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		public function mouseDown(evt:MouseEvent):void
		{
			currentText=new TextUIComponent(++iD, this.style, this.parent, new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			parent.registerTempComponent(currentText);
			currentText.setStartPoint(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			isInitialize=true;
			evt.stopPropagation();
		}

		public function mouseDownMove(evt:MouseEvent):void
		{
			currentText.lineTo(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			evt.stopPropagation();
		}

		public function mouseUp(evt:MouseEvent):void
		{
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			parent.unregisterTempComponent();
			currentText.getRectu();
			currentText.initComponents();
			parent.registerComponent(currentText);
			disableDrawingEvents();
			currentText.dispatchEvent(new Event("repaint"));
			evt.stopPropagation();
		}

		public function setEfect():void
		{
			currentText.setTextEffect();
		}

		public function getTextUIComponent():TextUIComponent
		{
			return this.currentText;
		}

		public function setDComponent(comp:DComponent):void
		{
			this.currentText=TextUIComponent(comp);
		}
	}
}