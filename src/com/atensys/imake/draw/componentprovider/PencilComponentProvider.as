package com.atensys.imake.draw.componentprovider {
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.PencilCursor;
	import com.atensys.imake.draw.component.PencilStroke;
	import com.atensys.imake.draw.stylepanels.PencilStylePanel;
	import com.atensys.imake.draw.stylepanels.StyleProvider;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.PencilStyle;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.managers.CursorManager;


	/**
	 *Provider of components associated to pencil instrument from the pallete.
	 * @author Andrei Sirghi.
	 *
	 */
	public class PencilComponentProvider implements DComponentProvider {

		private var parent:DrawDesktop;
		private var style:PencilStyle;
		private var active:Boolean;
		private var currentStroke:PencilStroke;
		private var mDownMove:Boolean=false;
		private var mOut:Boolean=false;
		private var iD:int=0;
		private var mdown:int=0;

		public function PencilComponentProvider() {
			style=new PencilStyle();
			active=true;
		}

		public function setParent(parent:DrawDesktop):void {
			this.parent=parent;
			//enableDrawingEvents();
		}

		public function setDStyle(style:DStyle):void {
			this.style=PencilStyle(style);
			if (currentStroke != null) {
				currentStroke.style=this.style;
				currentStroke.dispatchEvent(new Event("styleChanged"));
			}
			PencilCursor.SIZE=this.style.diameter;
			PencilCursor.TYPE=this.style.style;
			PencilCursor.COLOR=this.style.color;
		}

		public function setActive(active:Boolean):void {
			this.active=active;
			if (active) {
				enableDrawingEvents();
			} else {
				disableDrawingEvents();
				mdown=0
			}
		}

		public function mouseDown(evt:MouseEvent):void {
			if (mdown == 0) {
				var ps:PencilStyle=new PencilStyle();
				ps=PencilStylePanel(StyleProvider.getInstance().currentStylePanel).getStyleFromPanel();
				currentStroke=new PencilStroke(++iD, ps, new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY), new Point(parent.getDrawable().width, parent.getDrawable().height));
				parent.registerTempComponent(currentStroke);
			}
			mdown++;
			currentStroke.setStartPoint(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			mDownMove=true;
			evt.stopPropagation();
		}

		public function mouseDownMove(evt:MouseEvent):void {
			currentStroke.lineTo(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			evt.stopPropagation();
		}

		public function mouseUp(evt:MouseEvent):void {
			if (currentStroke == null) {
				return;
			}
			mDownMove=false;
			currentStroke.setActive(false);
			setActive(false);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			evt.stopPropagation();
			parent.unregisterTempComponent();
			currentStroke.getRectu();
			parent.registerComponent(currentStroke);
			CursorManager.removeAllCursors();
			currentStroke.dispatchEvent(new Event("repaint"));
		}

		public function mouseOut(evt:MouseEvent):void {
			if (mDownMove) {
				parent.getDrawable().removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
				mOut=true;
			}
			CursorManager.removeAllCursors();
			evt.stopPropagation();
		}

		public function mouseOver(evt:MouseEvent):void {
			if (mDownMove && mOut) {
				parent.getDrawable().addEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
				mOut=false;
				currentStroke.setStartPoint(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			}
			CursorManager.setCursor(PencilCursor, 2);
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
			this.currentStroke=PencilStroke(comp);
		}
	}
}