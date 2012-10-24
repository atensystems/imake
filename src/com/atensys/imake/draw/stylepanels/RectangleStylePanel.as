package com.atensys.imake.draw.stylepanels {
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.RectangleStyle;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	import mx.validators.NumberValidator;

	public class RectangleStylePanel extends HBox implements DStylePanel {
		private var lineOpacity:ComboText;
		private var lineDiameter:ComboText;
		private var fillOpacity:ComboText;
		private var isSquare:CheckBox;
		private var dstyle:RectangleStyle;
		private var rounds:Button;
		private var popup:RoundRect;
		private var ok:Boolean=false;

		public function RectangleStylePanel() {
			super();
			dstyle = new RectangleStyle();
			initOpacity();
			addChild(lineOpacity);
			var b:Box=new Box();
			b.width=15;
			addChild(b);
			initDiameter();
			addChild(lineDiameter);
			b=new Box();
			b.width=15;
			addChild(b);
			addChild(fillOpacity);
			b=new Box();
			b.width=15;
			addChild(b)
			initIsSquare();
			b=new Box();
			b.width=15;
			addChild(b)
			initRounds();
			popup=new RoundRect();
			popup.getOkButton().addEventListener(MouseEvent.CLICK, setRoundStyle);
			popup.getCancelButton().addEventListener(MouseEvent.CLICK, hidePopup);
			//addEventListener(FlexEvent.UPDATE_COMPLETE, dStyleChanged);
			addStyleChangeEvents();
		}

		private function initRounds():void {
			this.rounds=new Button();
			rounds.label="Round Rectangle";
			rounds.setStyle("verticalAlign", "middle");
			rounds.addEventListener(MouseEvent.CLICK, showRounds);
			addChild(rounds);
		}

		private function initDiameter():void {
			lineDiameter=new ComboText();
			lineDiameter.setStyle("verticalAlign", "middle");
			lineDiameter.setLabel("Line Diameter(px):");
			lineDiameter.setAllowTrackClick(true);
			lineDiameter.setTickInterval(10);
			lineDiameter.setSnapInterval(1);
			lineDiameter.setSliderLabels(["1", "250"]);
			lineDiameter.setSliderValues(1, 250);
			var lineDiameterValidator:NumberValidator=new NumberValidator();
			lineDiameterValidator.required=true;
			lineDiameterValidator.minValue=1;
			lineDiameterValidator.maxValue=250;
			lineDiameterValidator.domain="int";
			lineDiameter.setValidator(lineDiameterValidator);
		}

		private function initOpacity():void {
			lineOpacity=new ComboText();
			lineOpacity.setStyle("verticalAlign", "middle");
			lineOpacity.getText().text="100";
			lineOpacity.setLabel("Line Opacity(%):");
			lineOpacity.setAllowTrackClick(true);
			lineOpacity.setTickInterval(10);
			lineOpacity.setSnapInterval(1);
			lineOpacity.setSliderLabels(["0%", "100%"]);
			lineOpacity.setSliderValues(0, 100);
			var lineOpacityValidator:NumberValidator=new NumberValidator();
			lineOpacityValidator.required=true;
			lineOpacityValidator.minValue=0;
			lineOpacityValidator.maxValue=100;
			lineOpacityValidator.domain="int";
			lineOpacity.setValidator(lineOpacityValidator);

			fillOpacity=new ComboText();
			fillOpacity.setStyle("verticalAlign", "middle");
			fillOpacity.getText().text="100";
			fillOpacity.setLabel("Fill Opacity(%):");
			fillOpacity.setAllowTrackClick(true);
			fillOpacity.setTickInterval(10);
			fillOpacity.setSnapInterval(1);
			fillOpacity.setSliderLabels(["0%", "100%"]);
			fillOpacity.setSliderValues(0, 100);
			var fillOpacityValidator:NumberValidator=new NumberValidator();
			fillOpacityValidator.required=true;
			fillOpacityValidator.minValue=0;
			fillOpacityValidator.maxValue=100;
			fillOpacityValidator.domain="int";
			fillOpacity.setValidator(fillOpacityValidator);
		}

		private function initIsSquare():void {
			isSquare=new CheckBox();
			isSquare.setStyle("verticalAlign", "middle");
			isSquare.selected=false;
			isSquare.addEventListener(Event.CHANGE, dStyleChanged);
			var ph:Label=new Label();
			ph.text="Square:";
			ph.setStyle("verticalAlign", "middle");
			addChild(ph);
			addChild(isSquare);
		}

		private function addStyleChangeEvents():void {
			this.lineDiameter.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.lineOpacity.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.fillOpacity.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.isSquare.addEventListener(Event.CHANGE, dStyleChanged);
		}

		public function dStyleChanged(evt:Event):void {
			dstyle.color=Application.application.pallete.getColors().getTopColor();
			dstyle.color2=Application.application.pallete.getColors().getBottomColor();
			this.dstyle.lineOpacity=int(lineOpacity.getText().text);
			this.dstyle.lineDiameter=int(lineDiameter.getText().text);
			this.dstyle.fillOpacity=int(fillOpacity.getText().text);
			this.dstyle.isSquare=isSquare.selected;
			this.dstyle.topLeftRound=popup.getTopLeft();
			this.dstyle.topRightRound=popup.getTopRight();
			this.dstyle.bottomLeftRound=popup.getBottomLeft();
			this.dstyle.bottomRightRound=popup.getBottomRight();
			Application.application.desktop.setDStyle(this.dstyle);
		}
		public function getStyleFromPanel():RectangleStyle {
			var style:RectangleStyle=new RectangleStyle();
			style.color=Application.application.pallete.getColors().getTopColor();
			style.color2=Application.application.pallete.getColors().getBottomColor();
			style.lineOpacity=int(lineOpacity.getText().text);
			style.lineDiameter=int(lineDiameter.getText().text);
			style.fillOpacity=int(fillOpacity.getText().text);
			style.isSquare=isSquare.selected;
			style.topLeftRound=popup.getTopLeft();
			style.topRightRound=popup.getTopRight();
			style.bottomLeftRound=popup.getBottomLeft();
			style.bottomRightRound=popup.getBottomRight();
				return style;
		}
		public function getDStyle():void {
			Application.application.pallete.getColors().setTopColor(dstyle.color);
			Application.application.pallete.getColors().setBottomColor(dstyle.color2);
			lineOpacity.getText().text=this.dstyle.lineOpacity.toString();
			lineDiameter.getText().text=this.dstyle.lineDiameter.toString();
			fillOpacity.getText().text=this.dstyle.fillOpacity.toString();
			isSquare.selected=this.dstyle.isSquare;
			
				popup.setTopLeft(this.dstyle.topLeftRound);
				popup.setTopRight(this.dstyle.topRightRound);
				popup.setBottomLeft(this.dstyle.bottomLeftRound);
				popup.setBottomRight(this.dstyle.bottomRightRound);
			
		}

		public function getController():UIComponent {
			return this;
		}

		public function updateStyle(style:DStyle):void {
			this.dstyle = RectangleStyle(style);
			getDStyle();
		}

		private function showRounds(evt:MouseEvent):void {
			ok=false;
			popup.x=rounds.localToGlobal(new Point(0, 0)).x;
			popup.y=rounds.localToGlobal(new Point(0, 0)).y + this.height + 5;
			popup.setStyle('borderStyle', 'solid');
			popup.setStyle('borderThickness', 3);
			popup.setStyle('cornerRadius', 5);
			PopUpManager.addPopUp(popup, this.parent, true);
		}

		private function setRoundStyle(evt:MouseEvent):void {
			ok=true;
			PopUpManager.removePopUp(popup);
			dStyleChanged(null);
		}

		private function hidePopup(evt:MouseEvent):void {
			PopUpManager.removePopUp(popup);
		}
	}
}