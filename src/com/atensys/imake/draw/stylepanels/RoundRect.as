package com.atensys.imake.draw.stylepanels {
	import mx.containers.Grid;
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.HSlider;
	import mx.controls.Label;
	import mx.controls.sliderClasses.Slider;
	import mx.core.UIComponent;
	import mx.events.SliderEvent;

	public class RoundRect extends VBox {
		private var topLeft:Slider;
		private var topRight:Slider;
		private var bottomLeft:Slider;
		private var bottomRight:Slider;
		private var sprite:UIComponent;
		private var ok:Button;
		private var cancel:Button;

		public function RoundRect() {
			super();
			this.setStyle("backgroundAlpha", 1.0);
			this.setStyle("top", 20);
			this.setStyle("bottom", 20);
			this.setStyle("backgroundColor", 0xeeeeee);
			initComponents();
		}

		private function initComponents():void {
			sprite=new UIComponent();
			sprite.width=200;
			sprite.height=160;
			sprite.setStyle("borderStyle", "solid");
			
			var sliders:Grid=new Grid();
			var topLeftR:GridRow=new GridRow();
			topLeft=new HSlider();
			topLeft.allowTrackClick=true;
			topLeft.tickInterval=10;
			topLeft.snapInterval=1;
			topLeft.labels=["0%", "50%"];
			topLeft.minimum=0;
			topLeft.maximum=50;
			topLeft.liveDragging=true;
			topLeft.addEventListener(SliderEvent.CHANGE, drawRect);

			var topLeftL:Label=new Label();
			topLeftL.text="Top Left Radius:"
			var tlgil:GridItem=new GridItem();
			tlgil.addChild(topLeftL);
			tlgil.setStyle("verticalAlign", "bottom");
			var tlgi:GridItem=new GridItem();
			tlgi.addChild(topLeft);
			tlgi.setStyle("verticalAlign", "bottom");
			topLeftR.addChild(tlgil);
			topLeftR.addChild(tlgi);
			sliders.addChild(topLeftR);


			var topRightR:GridRow=new GridRow();
			topRight=new HSlider();
			topRight.allowTrackClick=true;
			topRight.tickInterval=10;
			topRight.snapInterval=1;
			topRight.labels=["0%", "50%"];
			topRight.minimum=0;
			topRight.maximum=50;
			topRight.liveDragging=true;
			topRight.addEventListener(SliderEvent.CHANGE, drawRect);

			var topRightL:Label=new Label();
			topRightL.text="Top Right Radius:"
			var trgil:GridItem=new GridItem();
			trgil.addChild(topRightL);
			trgil.setStyle("verticalAlign", "bottom");
			var trgi:GridItem=new GridItem();
			trgi.addChild(topRight);
			trgi.setStyle("verticalAlign", "bottom");
			topRightR.addChild(trgil);
			topRightR.addChild(trgi);
			sliders.addChild(topRightR);

			var bottomLeftR:GridRow=new GridRow();
			bottomLeft=new HSlider();
			bottomLeft.allowTrackClick=true;
			bottomLeft.tickInterval=10;
			bottomLeft.snapInterval=1;
			bottomLeft.labels=["0%", "50%"];
			bottomLeft.minimum=0;
			bottomLeft.maximum=50;
			bottomLeft.liveDragging=true;
			bottomLeft.addEventListener(SliderEvent.CHANGE, drawRect);

			var bottomLeftL:Label=new Label();
			bottomLeftL.text="Bottom Left Radius:"
			var blgil:GridItem=new GridItem();
			blgil.addChild(bottomLeftL);
			blgil.setStyle("verticalAlign", "bottom");
			var blgi:GridItem=new GridItem();
			blgi.addChild(bottomLeft);
			blgi.setStyle("verticalAlign", "bottom");
			bottomLeftR.addChild(blgil);
			bottomLeftR.addChild(blgi);
			sliders.addChild(bottomLeftR);

			var bottomRightR:GridRow=new GridRow();
			bottomRight=new HSlider();
			bottomRight.allowTrackClick=true;
			bottomRight.tickInterval=10;
			bottomRight.snapInterval=1;
			bottomRight.labels=["0%", "50%"];
			bottomRight.minimum=0;
			bottomRight.maximum=50;
			bottomRight.liveDragging=true;
			bottomRight.addEventListener(SliderEvent.CHANGE, drawRect);

			var bottomRightL:Label=new Label();
			bottomRightL.text="Bottom Right Radius:"
			var brgil:GridItem=new GridItem();
			brgil.addChild(bottomRightL);
			brgil.setStyle("verticalAlign", "bottom");
			var brgi:GridItem=new GridItem();
			brgi.setStyle("verticalAlign", "bottom");
			brgi.addChild(bottomRight);

			bottomRightR.addChild(brgil);
			bottomRightR.addChild(brgi);

			sliders.addChild(bottomRightR);
			var h:HBox=new HBox();
			h.addChild(sprite);
			h.addChild(sliders);
			addChild(h);
			ok=new Button();
			ok.label="OK";
			cancel=new Button();
			cancel.label="Cancel";
			var h1:HBox=new HBox();
			h1.setStyle("horizontalAlign", "right");
			ok.setStyle("horizontalAlign", "right");
			cancel.setStyle("horizontalAlign", "right");
			var separator:HBox=new HBox();
			separator.width=370;
			h1.addChild(separator);
			h1.addChild(ok);
			h1.addChild(cancel);
			addChild(h1);
			drawRect();
		}

		private function drawRect(evt:SliderEvent=null):void {
			sprite.graphics.clear();
			sprite.graphics.beginFill(0xff0000);
			sprite.graphics.drawRoundRectComplex(20, 20, 160, 120, topLeft.value * 120 / 100, topRight.value * 120 / 100, bottomLeft.value * 120 / 100, bottomRight.value * 120 / 100);
		}

		public function getOkButton():Button {
			return ok;
		}

		public function getCancelButton():Button {
			return cancel;
		}

		public function getTopLeft():Number {
			return topLeft.value;
		}

		public function getTopRight():Number {
			return topRight.value;
		}

		public function getBottomLeft():Number {
			return bottomLeft.value;
		}

		public function getBottomRight():Number {
			return bottomRight.value;
		}
		public function setTopLeft(n:Number):void {
			topLeft.value=n;
			drawRect(null);
		}

		public function setTopRight(n:Number):void {
			topRight.value=n;
			drawRect(null);
		}

		public function setBottomLeft(n:Number):void {
			bottomLeft.value=n;
			drawRect(null);
		}

		public function setBottomRight(n:Number):void {
			bottomRight.value=n;
			drawRect(null);
		}

	}
}