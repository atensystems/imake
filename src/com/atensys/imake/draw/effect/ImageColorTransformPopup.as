package com.atensys.imake.draw.effect
{
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.HSlider;
	import mx.controls.Label;

	public class ImageColorTransformPopup extends VBox
	{
		//private var dstyle:ImageStyle;
		private var redMultiplier:HSlider;
		private var greenMultiplier:HSlider;
		private var blueMultiplier:HSlider;
		private var alfaMultiplier:HSlider;
		private var redOffset:HSlider;
		private var greenOffset:HSlider;
		private var blueOffset:HSlider;
		private var alfaOffset:HSlider;
		private var ok:Button;
		private var cancel:Button;
		private var defolt:Button;

		public function ImageColorTransformPopup()
		{
			super();
			this.setStyle("backgroundAlpha", 1.0);
			this.setStyle("top", 20);
			this.setStyle("bottom", 20);
			this.setStyle("backgroundColor", 0xeeeeee);
			initComponents();
		}

		private function initComponents():void
		{
			this.blueMultiplier=new HSlider();
			this.alfaMultiplier=new HSlider();
			this.blueOffset=new HSlider();
			this.alfaOffset=new HSlider();
			this.greenMultiplier=new HSlider();
			this.greenOffset=new HSlider();
			this.redMultiplier=new HSlider();
			this.redOffset=new HSlider();

			this.ok=new Button();
			this.cancel=new Button();
			this.defolt=new Button();
			//this.defolt.addEventListener(MouseEvent.CLICK, changeDefault);

			this.ok.label="OK";
			this.cancel.label="Cancel";
			this.defolt.label="Default";
			var butonBox:HBox=new HBox();
			butonBox.addChild(defolt);
			butonBox.addChild(ok);
			butonBox.addChild(cancel);

			this.alfaMultiplier.minimum=0;
			this.alfaMultiplier.maximum=1;
			this.alfaMultiplier.snapInterval=.01;
			this.alfaMultiplier.value=1;
			this.alfaMultiplier.setStyle("labelOffset", 3);
			this.alfaMultiplier.labels=["0", "1"];

			this.alfaOffset.minimum=-255;
			this.alfaOffset.maximum=255;
			this.alfaOffset.snapInterval=1;
			this.alfaOffset.value=0;
			this.alfaOffset.setStyle("labelOffset", 3);
			this.alfaOffset.labels=["-255", "255"];
			var am:Label=new Label();
			am.text="Alfa Multiplier:";
			am.width=100;
			var ao:Label=new Label();
			ao.text="Alfa Offset:";
			ao.width=80;

			var alfaBox:HBox=new HBox();
			alfaBox.addChild(am);
			alfaBox.addChild(alfaMultiplier);
			alfaBox.addChild(ao);
			alfaBox.addChild(alfaOffset);

			this.blueMultiplier.minimum=0;
			this.blueMultiplier.maximum=4;
			this.blueMultiplier.snapInterval=.1;
			this.blueMultiplier.value=1;
			this.blueMultiplier.setStyle("labelOffset", 3);
			this.blueMultiplier.labels=["0", "4"];

			this.blueOffset.minimum=-255;
			this.blueOffset.maximum=255;
			this.blueOffset.snapInterval=1;
			this.blueOffset.value=0;
			this.blueOffset.setStyle("labelOffset", 3);
			this.blueOffset.labels=["-255", "255"];
			var bm:Label=new Label();
			bm.text="Blue Multiplier:";
			bm.width=100;
			var bo:Label=new Label();
			bo.text="Blue Offset:";
			bo.width=80;

			var blueBox:HBox=new HBox();
			blueBox.addChild(bm);
			blueBox.addChild(blueMultiplier);
			blueBox.addChild(bo);
			blueBox.addChild(blueOffset);

			this.greenMultiplier.minimum=0;
			this.greenMultiplier.maximum=4;
			this.greenMultiplier.snapInterval=.1;
			this.greenMultiplier.value=1;
			this.greenMultiplier.setStyle("labelOffset", 3);
			this.greenMultiplier.labels=["0", "4"];

			this.greenOffset.minimum=-255;
			this.greenOffset.maximum=255;
			this.greenOffset.snapInterval=1;
			this.greenOffset.value=0;
			this.greenOffset.setStyle("labelOffset", 3);
			this.greenOffset.labels=["-255", "255"];
			var gm:Label=new Label();
			gm.text="Green Multiplier:";
			gm.width=100;
			var go:Label=new Label();
			go.text="Green Offset:";
			go.width=80;

			var greenBox:HBox=new HBox();
			greenBox.addChild(gm);
			greenBox.addChild(greenMultiplier);
			greenBox.addChild(go);
			greenBox.addChild(greenOffset);

			this.redMultiplier.minimum=0;
			this.redMultiplier.maximum=4;
			this.redMultiplier.snapInterval=.1;
			this.redMultiplier.value=1;
			this.redMultiplier.setStyle("labelOffset", 3);
			this.redMultiplier.labels=["0", "4"];

			this.redOffset.minimum=-255;
			this.redOffset.maximum=255;
			this.redOffset.snapInterval=1;
			this.redOffset.value=0;
			this.redOffset.setStyle("labelOffset", 3);
			this.redOffset.labels=["-255", "255"];
			var rm:Label=new Label();
			rm.text="Red Multiplier:";
			rm.width=100;
			var ro:Label=new Label();
			ro.text="Red Offset:";
			ro.width=80;

			var redBox:HBox=new HBox();
			redBox.addChild(rm);
			redBox.addChild(redMultiplier);
			redBox.addChild(ro);
			redBox.addChild(redOffset);

			addChild(alfaBox);
			addChild(blueBox);
			addChild(greenBox);
			addChild(redBox);
			addChild(butonBox);
		}

		public function getOkButton():Button
		{
			return this.ok;
		}

		public function getDefaultButton():Button
		{
			return this.defolt;
		}

		public function getCancelButton():Button
		{
			return this.cancel;
		}

		public function getRedMultiplier():HSlider
		{
			return this.redMultiplier;
		}

		public function getGreenMultiplier():HSlider
		{
			return this.greenMultiplier;
		}

		public function getBlueMultiplier():HSlider
		{
			return this.blueMultiplier;
		}

		public function getAlfaMultiplier():HSlider
		{
			return this.alfaMultiplier;
		}

		public function getRedOffset():HSlider
		{
			return this.redOffset;
		}

		public function getGreenOffset():HSlider
		{
			return this.greenOffset;
		}

		public function getBlueOffset():HSlider
		{
			return this.blueOffset;
		}

		public function getAlfaOffset():HSlider
		{
			return this.alfaOffset;
		}
	}
}