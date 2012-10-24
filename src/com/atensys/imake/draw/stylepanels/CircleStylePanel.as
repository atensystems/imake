package com.atensys.imake.draw.stylepanels {
	import com.atensys.imake.draw.styles.CircleStyle;
	import com.atensys.imake.draw.styles.DStyle;
	
	import flash.events.Event;
	
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.controls.CheckBox;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.validators.NumberValidator;

	public class CircleStylePanel extends HBox implements DStylePanel {
		private var lineOpacity:ComboText;
		private var lineDiameter:ComboText;
		private var fillOpacity:ComboText;
		private var isCircle:CheckBox;
		private var dstyle:CircleStyle;

		public function CircleStylePanel() {
			super();
			dstyle = new CircleStyle();
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
			initIsCircle();
			//addEventListener(FlexEvent.UPDATE_COMPLETE, dStyleChanged);
			addStyleChangeEvents();
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

		private function initIsCircle():void {
			isCircle=new CheckBox();
			isCircle.setStyle("verticalAlign", "middle");
			isCircle.selected=false;
			isCircle.addEventListener(Event.CHANGE, dStyleChanged);
			var ph:Label=new Label();
			ph.text="Circle:";
			ph.setStyle("verticalAlign", "middle");
			addChild(ph);
			addChild(isCircle);
		}

		private function addStyleChangeEvents():void {
			this.lineDiameter.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.lineOpacity.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.fillOpacity.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.isCircle.addEventListener(Event.CHANGE, dStyleChanged);
		}

		public function dStyleChanged(evt:Event):void {
			dstyle.color=Application.application.pallete.getColors().getTopColor();
			dstyle.color2=Application.application.pallete.getColors().getBottomColor();
			this.dstyle.lineOpacity=int(lineOpacity.getText().text);
			this.dstyle.lineDiameter=int(lineDiameter.getText().text);
			this.dstyle.fillOpacity=int(fillOpacity.getText().text);
			this.dstyle.isCircle=isCircle.selected;
			Application.application.desktop.setDStyle(this.dstyle);
		}
		public function getStyleFromPanel():CircleStyle {
			var style:CircleStyle=new CircleStyle();
			style.color=Application.application.pallete.getColors().getTopColor();
			style.color2=Application.application.pallete.getColors().getBottomColor();
			style.lineOpacity=int(lineOpacity.getText().text);
			style.lineDiameter=int(lineDiameter.getText().text);
			style.fillOpacity=int(fillOpacity.getText().text);
			style.isCircle=isCircle.selected;
			return style;
		}
		public function getDStyle():void {
			Application.application.pallete.getColors().setTopColor(this.dstyle.color);
			Application.application.pallete.getColors().setBottomColor(this.dstyle.color2);
			lineOpacity.getText().text=this.dstyle.lineOpacity.toString();
			lineDiameter.getText().text=this.dstyle.lineDiameter.toString();
			fillOpacity.getText().text=this.dstyle.fillOpacity.toString();
			isCircle.selected=this.dstyle.isCircle;
		}

		public function getController():UIComponent {
			return this;
		}

		public function updateStyle(style:DStyle):void {
			this.dstyle = CircleStyle(style);
			getDStyle();
		}
	}
}