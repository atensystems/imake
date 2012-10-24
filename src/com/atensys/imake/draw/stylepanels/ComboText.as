package com.atensys.imake.draw.stylepanels {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;

	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import mx.controls.sliderClasses.Slider;
	import mx.core.Application;
	import mx.events.SliderEvent;
	import mx.events.ValidationResultEvent;
	import mx.managers.PopUpManager;
	import mx.validators.NumberValidator;

	public class ComboText extends HBox {
		private var lbl:Label;
		private var text:TextInput;
		private var combo:Button;
		private var pop1:*;

		private var snapInterval:Number = 1;
		private var tickInterval:Number = 1;
		private var liveDragging:Boolean;
		private var allowTrackClick:Boolean;
		private var labels:Array;
		private var minimum:Number;
		private var maximum:Number;
		[Embed(source="assets/combo.png")]
		[Bindable]
		public var iconSymbol:Class;
		private var validator:NumberValidator;

		public function ComboText() {
			initComponents();
		}

		private function initComponents():void {
			this.text=new TextInput();
			text.setStyle("verticalAlign", "middle");
			text.text="1";
			text.width=30;
			text.setStyle("cornerRadius", 5);
			text.setStyle("borderStyle", "solid");
			text.addEventListener(Event.CHANGE, changeText);
			this.lbl=new Label();
			lbl.setStyle("verticalAlign", "middle");
			addChild(lbl);
			addChild(text);
			this.combo=new Button();
			combo.width=20;
			combo.setStyle("verticalAlign", "middle");
			this.combo.setStyle("cornerRadius", "5");
			combo.addEventListener(MouseEvent.CLICK, showSlider);
			addChild(combo);
			combo.setStyle("icon", iconSymbol);
			setStyle("verticalGap", 1);
			setStyle("horizontalGap", 1);
		}

		private function change(event:SliderEvent):void {
			text.text="" + Slider(event.target).value;
			var evt:Event=new Event(Event.CHANGE);
			text.dispatchEvent(evt);
		}

		private function changeText(event:Event):void {
			if (validator != null) {
				validator.validate();
			}
		}



		private function showSlider(evt:MouseEvent):void {
			pop1=PopUpManager.createPopUp(this.parent, SliderPanel, false);
			pop1.getSlider().setStyle("color", "white");
			pop1.getSlider().setStyle("backgroundColor", "white");
			pop1.y=this.text.localToGlobal(new Point(0, 0)).y + text.height + 5;
			pop1.x=this.text.localToGlobal(new Point(0, 0)).x;
			pop1.setSliderValues(minimum, maximum);
			pop1.setLiveDragging(this.liveDragging);
			pop1.getSlider().tickInterval=this.tickInterval;
			pop1.getSlider().snapInterval=this.snapInterval;
			pop1.setAllowTrackClick(this.allowTrackClick);
			pop1.setSliderLabels(this.labels);
			pop1.getSlider().addEventListener(SliderEvent.CHANGE, change);
			pop1.addEventListener(MouseEvent.ROLL_OUT, closeSlider);
			pop1.addEventListener(MouseEvent.ROLL_OVER, removeApplicationEvent);
			pop1.addEventListener(KeyboardEvent, closeSliderK);
			pop1.getSlider().value=int(text.text);
			Application.application.addEventListener(MouseEvent.MOUSE_DOWN, closeSlider);
			Application.application.addEventListener(KeyboardEvent.KEY_DOWN, closeSliderK);
		}

		private function removeApplicationEvent(evt:MouseEvent):void {
			Application.application.removeEventListener(MouseEvent.MOUSE_DOWN, closeSlider);
		}

		private function addApplicationEvent(evt:MouseEvent):void {
			Application.application.addEventListener(MouseEvent.MOUSE_DOWN, closeSlider);
		}

		private function closeSlider(evt:MouseEvent):void {
			PopUpManager.removePopUp(pop1);
			Application.application.removeEventListener(MouseEvent.MOUSE_DOWN, closeSlider);
			Application.application.removeEventListener(KeyboardEvent.KEY_DOWN, closeSliderK);
		}


		private function closeSliderK(evt:KeyboardEvent):void {
			if (evt.keyCode == Keyboard.ESCAPE) {
				PopUpManager.removePopUp(SliderPanel.(evt.target));
				Application.application.removeEventListener(KeyboardEvent.KEY_DOWN, closeSliderK);
			}
		}


		public function setSnapInterval(value:Number):void {
			this.snapInterval=value;
		}

		public function setTickInterval(value:Number):void {
			this.tickInterval=value;
		}

		public function setLiveDragging(value:Boolean):void {
			this.liveDragging=value;
		}

		public function setAllowTrackClick(value:Boolean):void {
			this.allowTrackClick=value;
		}

		public function setSliderLabels(value:Array):void {
			this.labels=value;
		}

		public function setSliderValues(minValue:Number, maxValue:Number):void {
			minimum=minValue;
			maximum=maxValue;
		}

		public function setLabel(value:String):void {
			this.lbl.text=value;
		}

		public function setValidator(validator:NumberValidator):void {
			this.validator=validator;
			this.validator.source=text;
			this.validator.property="text";
			this.validator.addEventListener(ValidationResultEvent.INVALID, selectText);
		}

		private function selectText(event:ValidationResultEvent):void {
			text.selectionBeginIndex=0;
			text.selectionEndIndex=text.text.length;
		}

		public function getText():TextInput {
			return this.text;
		}

		public function setTextWidth(width:Number):void {
			this.text.width=width;
		}
	}
}
