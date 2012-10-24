package com.atensys.imake.draw.componentprovider {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.RectangleCursor;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.EyedropperStyle;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.Application;
	import mx.managers.CursorManager;


	/**
	 *Provider of components associated to rectangle instrument from the pallete.
	 * @author Andrei Sirghi.
	 *
	 */
	public class EyedropperComponentProvider implements DComponentProvider {

		private var parent:DrawDesktop;
		private var style:EyedropperStyle;
		private var active:Boolean;
		private var bitmap:BitmapData;

		public function EyedropperComponentProvider() {
			style=new EyedropperStyle();
			active=true;
		}

		public function setParent(parent:DrawDesktop):void {
			this.parent=parent;
			bitmap=new BitmapData(parent.getDrawable().width, parent.getDrawable().height, true, 0xFFFFFFFF);
			var cv:Point=new Point(0, 0);
			cv=parent.getDrawable().localToGlobal(cv);
			var dr:Point=new Point(0, 0);
			dr=parent.localToGlobal(dr);
			bitmap.draw(parent.getDrawable());
			enableDrawingEvents();
		}

		public function setDStyle(style:DStyle):void {
			this.style=EyedropperStyle(style);
		}

		public function setActive(active:Boolean):void {
			this.active=false;
			if (active) {
				enableDrawingEvents();
			} else {
				disableDrawingEvents();
			}
		}

		public function mouseDown(evt:MouseEvent):void {
			var p:Point=Util.getMousePointer(evt);
			var color:uint=bitmap.getPixel32(p.x, p.y);
			if(color==0xffffffff){
				color=0xffffff;
			}
			Application.application.pallete.getColors().changeColor(color);
		}

		public function mouseOut(evt:MouseEvent):void {
			CursorManager.removeAllCursors();
		}

		public function mouseOver(evt:MouseEvent):void {
			CursorManager.setCursor(RectangleCursor, 2);
		}

		public function disableDrawingEvents():void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}

		public function enableDrawingEvents():void {
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		public function setDComponent(comp:DComponent):void{
		}
	}
}