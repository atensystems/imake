package com.atensys.imake.draw.componentprovider {
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.BrushCursor;
	import com.atensys.imake.draw.component.BrushStroke;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.stylepanels.BrushStylePanel;
	import com.atensys.imake.draw.stylepanels.StyleProvider;
	import com.atensys.imake.draw.styles.BrushStyle;
	import com.atensys.imake.draw.styles.DStyle;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.managers.CursorManager;

	public class BrushComponentProvider implements DComponentProvider {
		private var parent:DrawDesktop;
		private var style:BrushStyle;
		private var active:Boolean;
		private var currentStroke:BrushStroke;
		private var mDownMove:Boolean=false;
		private var mOut:Boolean=false;
		private var mdown:int=0;

		public function BrushComponentProvider() {
			style=new BrushStyle();
			active=true;
		}

		public function setParent(parent:DrawDesktop):void {
			this.parent=parent;
			//enableDrawingEvents();
		}

		public function setDStyle(style:DStyle):void {
			this.style=BrushStyle(style);
			if (this.currentStroke != null) {
				this.currentStroke.setDStyle(this.style);
				currentStroke.dispatchEvent(new Event("styleChanged"));
			}
			BrushCursor.SIZE=this.style.diameter;
			BrushCursor.COLOR=this.style.color;
			BrushCursor.TYPE=this.style.bitmap;
			if (parent.getDrawable().mouseX > 0 && parent.getDrawable().mouseY > 0) {
				//CursorManager.setCursor(BrushCursor);
			}
		}

		public function setActive(active:Boolean):void {
			this.active=active;
			if (active) {
				enableDrawingEvents();
			} else {
				disableDrawingEvents();
				if (mdown != 0) {

				}
				mdown=0;
			}
		}


		public function mouseDown(evt:MouseEvent):void
		{
			if (mdown == 0)
			{
				var bs:BrushStyle = new BrushStyle();
				bs=BrushStylePanel(StyleProvider.getInstance().currentStylePanel).getStyleFromPanel();
				currentStroke=new BrushStroke(ProviderUtils.newID(), bs, new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY), new Point(parent.getDrawable().width, parent.getDrawable().height));
				parent.registerTempComponent(currentStroke);
			}
			mdown++;
			currentStroke.initStyle();
			currentStroke.setDStyle(this.style);

			currentStroke.setStartPoint(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			mDownMove=true;
			parent.stage.frameRate=120;
			evt.stopPropagation();
		}

		public function mouseDownMove(evt:MouseEvent):void {
			currentStroke.lineTo(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			evt.stopPropagation();
		}

		public function mouseUp(evt:MouseEvent):void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			mDownMove=false;
			currentStroke.setActive(false);
			setActive(false);
			parent.unregisterTempComponent();
			currentStroke.getRectu();
			parent.registerComponent(currentStroke);
			CursorManager.removeAllCursors();
			currentStroke.dispatchEvent(new Event("repaint"));
			evt.stopPropagation();
		}

		public function mouseOut(evt:MouseEvent):void {
			if (mDownMove) {
				currentStroke.setStartPoint(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
				parent.getDrawable().removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
				mOut=true;
			}
			CursorManager.removeAllCursors();
			evt.stopPropagation();
		}

		public function mouseOver(evt:MouseEvent):void {
			if (mDownMove && mOut) {
				currentStroke.setStartPoint(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
				parent.getDrawable().addEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
				mOut=false;
			}
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
			this.currentStroke=BrushStroke(comp);
		}
	}
}