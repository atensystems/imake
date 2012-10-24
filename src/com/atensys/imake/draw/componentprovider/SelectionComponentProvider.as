package com.atensys.imake.draw.componentprovider {
	import aether.utils.ScreenCapture;
	
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.SelectionUIComponent;
	import com.atensys.imake.draw.stylepanels.SelectionStylePanel;
	import com.atensys.imake.draw.stylepanels.StyleProvider;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.SelectionStyle;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Canvas;

	public class SelectionComponentProvider implements DComponentProvider {
		private var active:Boolean;
		private var style:SelectionStyle;
		private var currentSelection:SelectionUIComponent;
		private var parent:DrawDesktop;

		public function SelectionComponentProvider() {
			this.style=new SelectionStyle();
			this.active=true;
		}

		public function setParent(parent:DrawDesktop):void {
			this.parent=parent;
		}

		public function setDStyle(style:DStyle):void {
			this.style=SelectionStyle(style);
		}

		public function setActive(active:Boolean):void {
			this.active=active;
			if (this.active) {
				this.style=new SelectionStyle();
				enableDrawingEvents();
				currentSelection=new SelectionUIComponent(this.style, parent);
				parent.registerTempComponent(currentSelection);
				(SelectionStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).setDstyle(this.style);
				enableDrawingEvents();
			} else {
				disableDrawingEvents();
				if (currentSelection.numChildren > 0)
					currentSelection.removeChildAt(0);
			}
		}

		private function getSnapshot(source:Canvas):BitmapData {
			return ScreenCapture.drawFromObject(source);
		}

		public function mouseDown(evt:MouseEvent):void {
			currentSelection.graphics.clear();
			currentSelection.typeShape.graphics.clear();
			currentSelection.setStartPoint(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			evt.stopPropagation();
		}

		public function mouseDownMove(evt:MouseEvent):void {

			currentSelection.lineTo(new Point(parent.getDrawable().mouseX, parent.getDrawable().mouseY));
			evt.stopPropagation();
		}

		public function mouseUp(evt:MouseEvent):void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			currentSelection.setEndPoint(new Point(evt.localX, evt.localY));
			if (this.style.getType() == SelectionStyle.MOUSE) {
				currentSelection.graphics.moveTo(evt.localX, evt.localY);
				currentSelection.graphics.lineTo(currentSelection.startPoint.x, currentSelection.startPoint.y);
			}
			currentSelection.shapeBMData.draw(currentSelection.typeShape);
			currentSelection.showBorder();
			evt.stopPropagation();
		}


		public function disableDrawingEvents():void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		public function enableDrawingEvents():void {
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 5);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 5);
		}

		public function setBitmapImage():void {
			currentSelection.setSourceBitmap(this.style.getImageBitmap());
		}

		public function setDComponent(comp:DComponent):void {
		}

	}
}