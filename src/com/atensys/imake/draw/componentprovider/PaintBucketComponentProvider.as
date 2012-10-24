package com.atensys.imake.draw.componentprovider {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.PaintBucketComponent;
	import com.atensys.imake.draw.component.RectangleCursor;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.PaintBucketStyle;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.managers.CursorManager;

	public class PaintBucketComponentProvider implements DComponentProvider {
		private var parent:DrawDesktop;
		private var style:PaintBucketStyle;
		private var currentComponent:PaintBucketComponent;
		private var active:Boolean;
		private var bitmap:BitmapData;

		public function PaintBucketComponentProvider() {
			style=new PaintBucketStyle();
			active=true;
		}

		public function setParent(parent:DrawDesktop):void {
			this.parent=parent;
		}

		public function setDStyle(style:DStyle):void {
			this.style=PaintBucketStyle(style);
			if (currentComponent != null) {
				currentComponent.setDStyle(style as PaintBucketStyle);
				currentComponent.dispatchEvent(new Event("styleChanged"));
			}
		}

		public function setActive(active:Boolean):void {
			this.active=active;
			if (active) {
			bitmap=new BitmapData(parent.getDrawable().width, parent.getDrawable().height, true, 0xFFFFFFFF);
			bitmap.draw(parent.getDrawable());
			enableDrawingEvents();
			} else {
				disableDrawingEvents();
			}
		}

		public function mouseDown(evt:MouseEvent):void {
			this.currentComponent=new PaintBucketComponent(ProviderUtils.newID(),Util.currentTime(),this.bitmap, Util.getMousePointer(evt), this.style, new Point(parent.getDrawable().width, parent.getDrawable().height));
		}

		public function disableDrawingEvents():void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		public function enableDrawingEvents():void {
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		public function mouseOut(evt:MouseEvent):void {
			CursorManager.removeAllCursors();
		}

		public function mouseUp(evt:MouseEvent):void {
			CursorManager.removeAllCursors();
			this.currentComponent.setActive(false);
			setActive(false);
			parent.registerComponent(this.currentComponent);
			this.currentComponent.dispatchEvent(new Event("repaint"));
		}

		public function mouseOver(evt:MouseEvent):void {
			CursorManager.setCursor(RectangleCursor, 2);
		}

		public function setDComponent(comp:DComponent):void {
			this.currentComponent=PaintBucketComponent(comp)
		}
	}
}