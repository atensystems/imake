package com.atensys.imake.draw.componentprovider {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.EraserCursor;
	import com.atensys.imake.draw.component.EraserLayer;
	import com.atensys.imake.draw.component.EraserStroke;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.EraserStyle;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;


	public class EraserComponentProvider implements DComponentProvider {

		private var parent:DrawDesktop;
		private var style:EraserStyle;
		private var active:Boolean;
		private var currentStroke:EraserStroke;
		private var mDownMove:Boolean=false;
		private var mOut:Boolean=false;
		private var iD:int=0;
		private var source:Bitmap;
		private var dComp:DComponent;

		public function EraserComponentProvider() {
			style=new EraserStyle();
			active=true;
		}

		public function setParent(parent:DrawDesktop):void {
			this.parent=parent;
			//enableDrawingEvents();
		}

		public function setDStyle(style:DStyle):void {
			this.style=EraserStyle(style);
			EraserCursor.SIZE=this.style.diameter;
			EraserCursor.TYPE=this.style.style;
			EraserCursor.COLOR=this.style.color2;
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
			if(parent.dComponentList.length==0){
				CursorManager.removeAllCursors();
				setActive(false);
				return;
			} 
			source = DComponent(parent.getComponentAt(parent.dComponentList.length-1)).getSource();
			dComp = parent.getComponentAt(parent.dComponentList.length-1);
			currentStroke=new EraserStroke(++iD,parent.dComponentList.length-1,this.style, new Point(evt.localX, evt.localY), new Point(parent.getDrawable().width, parent.getDrawable().height),dComp);
			currentStroke.setStartPoint(new Point(source.mouseX,source.mouseY));
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			mDownMove=true;
		}

		public function mouseDownMove(evt:MouseEvent):void {
			currentStroke.lineTo(new Point(source.mouseX,source.mouseY));//evt.localX, evt.localY
		}

		public function mouseUp(evt:MouseEvent):void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
			mDownMove=false;
			currentStroke.setActive(false);
			var xml:XML = currentStroke.toXML();
			xml.appendChild(<size width={dComp.getController().width.toString()} height = {dComp.getController().height.toString()}/>);
			var eraseLayer:EraserLayer = new EraserLayer(currentStroke.shapeErase,dComp.getController().width,dComp.getController().height,xml);
			Util.flipEraseLayer(eraseLayer,dComp.getDStyle().effect.flipH,dComp.getDStyle().effect.flipV);
			dComp.eraserLayers.push(eraseLayer);
			currentStroke.points = new ArrayCollection();
		}

		public function mouseOut(evt:MouseEvent):void {
			if (mDownMove) {
				parent.getDrawable().removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
				mOut=true;
			}
			CursorManager.removeAllCursors();
		}

		public function mouseOver(evt:MouseEvent):void {
			if (mDownMove && mOut) {
				parent.getDrawable().addEventListener(MouseEvent.MOUSE_MOVE, mouseDownMove);
				mOut=false;
				currentStroke.setStartPoint(new Point(source.mouseX,source.mouseY));
			}
			CursorManager.setCursor(EraserCursor, 2);
		}

		public function disableDrawingEvents():void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}

		public function enableDrawingEvents():void {
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		public function setDComponent(comp:DComponent):void{
			this.currentStroke = EraserStroke(comp);
			//if(comp!=null)this.style = comp.style;
		}

	}
}