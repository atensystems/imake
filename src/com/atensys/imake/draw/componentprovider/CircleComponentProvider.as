package com.atensys.imake.draw.componentprovider {
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.CircleComponent;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.DComponentType;
	import com.atensys.imake.draw.component.RectangleCursor;
	import com.atensys.imake.draw.stylepanels.CircleStylePanel;
	import com.atensys.imake.draw.stylepanels.StyleProvider;
	import com.atensys.imake.draw.styles.CircleStyle;
	import com.atensys.imake.draw.styles.DStyle;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.Application;
	import mx.managers.CursorManager;


	/**
	 *Provider of components associated to circle instrument from the pallete.
	 * @author Andrei Sirghi.
	 *
	 */
	public class CircleComponentProvider implements DComponentProvider {

		private var parent:DrawDesktop;
		private var style:CircleStyle;
		private var active:Boolean;
		private var currentStroke:CircleComponent;

		public function CircleComponentProvider() {
			style=new CircleStyle();
			active=true;
		}

		public function setParent(parent:DrawDesktop):void {
			this.parent=parent;
			//enableDrawingEvents();
		}

		public function setDStyle(style:DStyle):void {
			this.style=CircleStyle(style);
			if (currentStroke != null) {
				currentStroke.style=this.style;
				currentStroke.dispatchEvent(new Event("styleChanged"));
			}
		}

		public function setActive(active:Boolean):void {
			this.active=active;
			if (active) {
				enableDrawingEvents();
			} else {
				disableDrawingEvents();
			}
		}

		public function mouseDown(evt:MouseEvent):void {
				var cs:CircleStyle = new CircleStyle();
			cs=CircleStylePanel(StyleProvider.getInstance().currentStylePanel).getStyleFromPanel();
		
			currentStroke=new CircleComponent(ProviderUtils.newID(), cs, new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY), new Point(parent.getDrawable().width, parent.getDrawable().height));
			parent.registerTempComponent(currentStroke);
			currentStroke.setStartPoint(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			evt.stopPropagation();
		}

		public function mouseDownMove(evt:MouseEvent):void {
			currentStroke.lineTo(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			evt.stopPropagation();
		}

		public function mouseUp(evt:MouseEvent):void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			currentStroke.setActive(false);
			parent.unregisterTempComponent();
			currentStroke.getRectu();
			parent.registerComponent(currentStroke);
			setActive(false);
			CursorManager.removeAllCursors();
			currentStroke.dispatchEvent(new Event("repaint"));
			StyleProvider.getInstance().removeAllChildren();
			Application.application.pallete.setInstrument(DComponentType.POINTER);
			evt.stopPropagation();
		}

		public function mouseOut(evt:MouseEvent):void {
			CursorManager.removeAllCursors();
			evt.stopPropagation();
		}

		public function mouseOver(evt:MouseEvent):void {
			CursorManager.setCursor(RectangleCursor, 2);
			evt.stopPropagation();
		}

		public function disableDrawingEvents():void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}

		public function enableDrawingEvents():void {
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 5);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 5);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 5);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 5);
		}

		public function setDComponent(comp:DComponent):void {
			this.currentStroke=CircleComponent(comp);
		}
	}
}