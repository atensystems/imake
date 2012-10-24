package com.atensys.imake.draw.stylepanels {
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.EraserStyle;
	
	import flash.display.CapsStyle;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.validators.NumberValidator;

	public class EraserStylePanel extends HBox implements DStylePanel {
		private var smoth:ComboText;
		private var diameter:ComboText;
		private var dstyle:EraserStyle;
		private var lineStyle:ComboBox
		[Bindable]
		[Embed(source="assets/square.png")]
		private var square:Class;

		[Bindable]
		[Embed(source="assets/round.png")]
		private var round:Class;

		[Bindable]
		private var caps:ArrayCollection=new ArrayCollection([{label: "Square", icon: square, data: CapsStyle.SQUARE}, {label: "Round", icon: round, data: CapsStyle.ROUND}]);

		public function EraserStylePanel() {
			super();
			initOpacity();
			var b:Box=new Box();
			b.width=15;
			addChild(b);
			initDiameter();
			b=new Box();
			b.width=15;
			addChild(b);
			initLineStyle();
			addStyleChangeEvents();
			dstyle=new EraserStyle();
			addEventListener(FlexEvent.UPDATE_COMPLETE, dStyleChanged);
		}

		public function initLineStyle():void {
			lineStyle=new ComboBox();
			lineStyle.dataProvider=this.caps;
			lineStyle.setStyle("verticalAlign", "middle");
			var styleLabel:Label=new Label();
			styleLabel.text="Style:";
			styleLabel.setStyle("verticalAlign", "middle");
			addChild(styleLabel);
			addChild(lineStyle);
		}

		public function initDiameter():void {
			diameter=new ComboText();
			diameter.setStyle("verticalAlign", "middle");
			diameter.setLabel("Diameter(px):");
			diameter.setAllowTrackClick(true);
			diameter.getText().text="5";
			diameter.setTickInterval(10);
			diameter.setSnapInterval(1);
			diameter.setSliderLabels(["1", "250"]);
			diameter.setSliderValues(1, 250);
			var diameterValidator:NumberValidator=new NumberValidator();
			diameterValidator.required=true;
			diameterValidator.minValue=1;
			diameterValidator.maxValue=250;
			diameterValidator.domain="int";
			diameter.setValidator(diameterValidator);
			addChild(diameter);
		}


		public function initOpacity():void {
			smoth=new ComboText();
			smoth.setStyle("verticalAlign", "middle");
			smoth.getText().text="5";
			smoth.setLabel("Smoothing:");
			smoth.setAllowTrackClick(true);
			smoth.setTickInterval(10);
			smoth.setSnapInterval(1);
			smoth.setSliderLabels(["0", "100"]);
			smoth.setSliderValues(0, 100);
			var opacityValidator:NumberValidator=new NumberValidator();
			opacityValidator.required=true;
			opacityValidator.minValue=0;
			opacityValidator.maxValue=100;
			opacityValidator.domain="int";
			smoth.setValidator(opacityValidator);
			addChild(smoth);
		}

		public function addStyleChangeEvents():void {
			this.diameter.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.smoth.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.lineStyle.addEventListener(Event.CHANGE, dStyleChanged);
		}

		public function dStyleChanged(evt:Event):void {
			this.dstyle=new EraserStyle();
			this.dstyle.color2=Application.application.pallete.getColors().getBottomColor();
			this.dstyle.smoth=int(smoth.getText().text);
			this.dstyle.diameter=int(this.diameter.getText().text);
			this.dstyle.style=lineStyle.selectedItem.data;
			Application.application.desktop.setDStyle(this.dstyle);
		}

		public function getController():UIComponent {
			return this;
		}

		public function updateStyle(style:DStyle):void {
		}
	}
}