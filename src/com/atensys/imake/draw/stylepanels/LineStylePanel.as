package com.atensys.imake.draw.stylepanels {
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.LineStyle;
	
	import flash.display.CapsStyle;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.controls.CheckBox;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ColorPickerEvent;
	import mx.validators.NumberValidator;

	public class LineStylePanel extends HBox implements DStylePanel {
		private var opacity:ComboText;
		private var diameter:ComboText;
		private var lineStyle:ComboBox;
		private var dstyle:LineStyle;
		private var pixelHinting:CheckBox;
		private var shapeTrails:CheckBox;

		[Bindable]
		[Embed(source="assets/square.png")]
		private var square:Class;

		[Bindable]
		[Embed(source="assets/round.png")]
		private var round:Class;

		[Bindable]
		private var caps:ArrayCollection=new ArrayCollection([{label: "Square", icon: square, data: CapsStyle.SQUARE}, {label: "Round", icon: round, data: CapsStyle.ROUND}]);

		public function LineStylePanel() {
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
			dstyle=new LineStyle();
			b=new Box();
			b.width=15;
			addChild(b);
			initPixelHinting();
			b=new Box();
			b.width=15;
			addChild(b);
			initShapeTrails();
			//addEventListener(FlexEvent.UPDATE_COMPLETE, dStyleChanged);
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
			opacity=new ComboText();
			opacity.setStyle("verticalAlign", "middle");
			opacity.getText().text="100";
			opacity.setLabel("Opacity(%):");
			opacity.setAllowTrackClick(true);
			opacity.setTickInterval(10);
			opacity.setSnapInterval(1);
			opacity.setSliderLabels(["0%", "100%"]);
			opacity.setSliderValues(0, 100);
			var opacityValidator:NumberValidator=new NumberValidator();
			opacityValidator.required=true;
			opacityValidator.minValue=0;
			opacityValidator.maxValue=100;
			opacityValidator.domain="int";
			opacity.setValidator(opacityValidator);
			addChild(opacity);
		}

		public function initPixelHinting():void {
			pixelHinting=new CheckBox();
			pixelHinting.setStyle("verticalAlign", "middle");
			pixelHinting.selected=false;
			pixelHinting.addEventListener(Event.CHANGE, dStyleChanged);
			var ph:Label=new Label();
			ph.text="Snap to Pixel:";
			ph.setStyle("verticalAlign", "middle");
			addChild(ph);
			addChild(pixelHinting);
		}

		public function initShapeTrails():void {
			shapeTrails=new CheckBox();
			shapeTrails.setStyle("verticalAlign", "middle");
			shapeTrails.selected=false;
			shapeTrails.addEventListener(Event.CHANGE, dStyleChanged);
			var ph:Label=new Label();
			ph.text="Shape Trails:";
			ph.setStyle("verticalAlign", "middle");
			addChild(ph);
			addChild(shapeTrails);
		}

		public function addStyleChangeEvents():void {
			this.diameter.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.opacity.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.lineStyle.addEventListener(Event.CHANGE, dStyleChanged);
		}

		public function dStyleChanged(evt:Event):void {
			this.dstyle.color=Application.application.pallete.getColors().getTopColor();
			this.dstyle.opacity=int(opacity.getText().text);
			this.dstyle.diameter=int(this.diameter.getText().text);
			this.dstyle.style=lineStyle.selectedItem.data;
			this.dstyle.pixelHinting=pixelHinting.selected;
			this.dstyle.shapeTrails=shapeTrails.selected;
			Application.application.desktop.setDStyle(this.dstyle);
		}
		public function getStyleFromPanel():LineStyle {
			var style:LineStyle = new LineStyle();
			style=new LineStyle();
			style.color=Application.application.pallete.getColors().getTopColor();
			style.opacity=int(opacity.getText().text);
			style.diameter=int(this.diameter.getText().text);
			style.style=lineStyle.selectedItem.data;
			style.pixelHinting=pixelHinting.selected;
			style.shapeTrails=shapeTrails.selected;
			return style;
		}
		public function getDStyle():void {
			Application.application.pallete.getColors().setTopColor(this.dstyle.color);
			opacity.getText().text=this.dstyle.opacity.toString();
			this.diameter.getText().text=this.dstyle.diameter.toString();
			lineStyle.selectedIndex=(this.dstyle.style==CapsStyle.SQUARE)?0:1;
			pixelHinting.selected=this.dstyle.pixelHinting;
			shapeTrails.selected=this.dstyle.shapeTrails;
			//Application.application.desktop.setDStyle(this.dstyle);
		}

		public function addColorEvent():void {
			Application.application.pallete.getColors().top.addEventListener(ColorPickerEvent.CHANGE, dStyleChanged);
		}

		public function getController():UIComponent {
			return this;
		}

		public function updateStyle(style:DStyle):void {
			this.dstyle = LineStyle(style);
			getDStyle();
		}
	}
}