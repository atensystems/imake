package com.atensys.imake.draw.componentprovider {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.ImageUIComponent;
	import com.atensys.imake.draw.component.RequestTitleWindow;
	import com.atensys.imake.draw.stylepanels.ImageStylePanel;
	import com.atensys.imake.draw.stylepanels.StyleProvider;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.ImageStyle;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ImageComponentProvider implements DComponentProvider {
		private var parent:DrawDesktop;
		private var style:ImageStyle;
		private var active:Boolean;
		private var currentImage:ImageUIComponent;


		public function ImageComponentProvider() {
		}

		public function setParent(parent:DrawDesktop):void {
			this.parent=parent;
		}

		public function setParent1(parent:DrawDesktop, bitmp:Bitmap):void {
			this.style=new ImageStyle();
			this.parent=parent;
			currentImage=new ImageUIComponent(ProviderUtils.newID(),Util.currentTime(), this.style, this.parent);
			initImage(bitmp);
			parent.registerComponent(currentImage);
			currentImage.dispatchEvent(new Event("repaint"));
		}

		public function initImage(imageBitmapSource:Bitmap):void {
			currentImage.setBitmapImage(imageBitmapSource);
			style.imageBitmap=imageBitmapSource;
			style.initialImageBitmap=new Bitmap(imageBitmapSource.bitmapData);
			(ImageStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).setDstyle(style);
		}

		public function setDStyle(style:DStyle):void {
			this.style=ImageStyle(style);
			currentImage.setDStyle(this.style);
		}

		public function setActive(active:Boolean):void {
			this.active=active;
			if (active) {
			this.style=new ImageStyle();
			currentImage=new ImageUIComponent(ProviderUtils.newID(),Util.currentTime(), this.style, this.parent);
			new RequestTitleWindow(currentImage, parent);
				enableDrawingEvents();
			} else {
				disableDrawingEvents();
			}
		}

		public function enableDrawingEvents():void {
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		public function disableDrawingEvents():void {
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.getDrawable().removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		public function mouseUp(evt:MouseEvent):void {
		}

		public function mouseDown(evt:MouseEvent):void {
		}

		public function imageClick(evt:MouseEvent):void {
			currentImage=ImageUIComponent(evt.currentTarget);
			this.style=ImageStyle(currentImage.getDStyle());
		}

		public function setBitmapImage():void {
			currentImage.setBitmapImage(this.style.imageBitmap);
			trace(currentImage.toXML());
		}

		public function setDComponent(comp:DComponent):void {
			this.currentImage=ImageUIComponent(comp);
		}

	}
}