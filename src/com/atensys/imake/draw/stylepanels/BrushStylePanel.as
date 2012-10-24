package com.atensys.imake.draw.stylepanels {
	import com.atensys.imake.draw.styles.BrushStyle;
	import com.atensys.imake.draw.styles.DStyle;
	
	import flash.events.Event;
	
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.controls.CheckBox;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.ColorPickerEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.validators.NumberValidator;

	public class BrushStylePanel extends HBox implements DStylePanel {
		private var opacity:ComboText;
		private var diameter:ComboText;
		private var symmetryPoints:ComboText;
		private var symmetryEnabled:CheckBox;
		private var brushRenderer:BrushFormRenderer;

		private var dstyle:BrushStyle;

		public function BrushStylePanel() {
			super();
			initOpacity();
			var b:Box=new Box();
			b.width=15;
			addChild(b);
			initDiameter();
			b=new Box();
			b.width=15;
			addChild(b);
			initBrushForm();
			b=new Box();
			b.width=15;
			addChild(b);
			initSymmetryPoints();
			b=new Box();
			b.width=15;
			addChild(b);
			initSymmetryEnabled();
			dstyle=new BrushStyle();
			addStyleChangeEvents();
			addEventListener(FlexEvent.UPDATE_COMPLETE, dStyleChanged);
		}


		public function initBrushForm():void {
			brushRenderer=new BrushFormRenderer();
			brushRenderer.addEventListener(ListEvent.CHANGE, dStyleChanged);
			addChild(brushRenderer);
		}
		private function initStyle(evt:Event):void {
			this.dstyle.color=Application.application.pallete.getColors().getTopColor();
			this.dstyle.opacity=int(opacity.getText().text);
			this.dstyle.diameter=int(this.diameter.getText().text);
			this.dstyle.isSymmetry=this.symmetryEnabled.selected;
			this.dstyle.symmetryPoints=int(this.symmetryPoints.getText());
			this.dstyle.bitmap=this.brushRenderer.getBitmapData();
			this.dstyle.selectedBrush = this.brushRenderer.popup.list.selectedIndex;
		}

		public function initSymmetryEnabled():void {
			symmetryEnabled=new CheckBox();
			var symmetryEnabledLabel:Label=new Label();
			symmetryEnabledLabel.text="Symmetry:";
			addChild(symmetryEnabledLabel);
			addChild(symmetryEnabled);
		}

		public function initDiameter():void {
			diameter=new ComboText();
			diameter.setLabel("Diameter(px):");
			diameter.getText().text = "15";
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

		public function initSymmetryPoints():void {
			symmetryPoints=new ComboText();
			symmetryPoints.getText().text="2";
			symmetryPoints.setLabel("Symmetry Points:");
			symmetryPoints.setAllowTrackClick(true);
			symmetryPoints.setTickInterval(10);
			symmetryPoints.setSnapInterval(1);
			symmetryPoints.setSliderLabels(["2", "100"]);
			symmetryPoints.setSliderValues(2, 100);
			var symmetryValidator:NumberValidator=new NumberValidator();
			symmetryValidator.required=true;
			symmetryValidator.minValue=2;
			symmetryValidator.maxValue=100;
			symmetryValidator.domain="int";
			symmetryPoints.setValidator(symmetryValidator);
			addChild(symmetryPoints);
		}


		public function initOpacity():void {
			opacity=new ComboText();
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

		public function addStyleChangeEvents():void {
			this.diameter.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.opacity.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.symmetryPoints.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.symmetryEnabled.addEventListener(Event.CHANGE, dStyleChanged);
		}

		public function dStyleChanged(evt:Event):void {
			this.dstyle.color=Application.application.pallete.getColors().getTopColor();
			this.dstyle.opacity=int(opacity.getText().text);
			this.dstyle.diameter=int(this.diameter.getText().text);
			this.dstyle.isSymmetry=this.symmetryEnabled.selected;
			this.dstyle.symmetryPoints=int(this.symmetryPoints.getText().text);
			this.dstyle.bitmap=this.brushRenderer.getBitmapData();
			this.dstyle.selectedBrush = this.brushRenderer.popup.list.selectedIndex;
			Application.application.desktop.setDStyle(this.dstyle);
		}
		
		public function getStyleFromPanel():BrushStyle {
			var style:BrushStyle=new BrushStyle();
			style.color=Application.application.pallete.getColors().getTopColor();
			style.opacity=int(opacity.getText().text);
			style.diameter=int(this.diameter.getText().text);
			style.isSymmetry=this.symmetryEnabled.selected;
			style.symmetryPoints=int(this.symmetryPoints.getText());
			style.bitmap=this.brushRenderer.getBitmapData();
			style.selectedBrush = this.brushRenderer.popup.list.selectedIndex;
			return style;
		}
		public function getDStyle():void {
			Application.application.pallete.getColors().setTopColor(this.dstyle.color);
			opacity.getText().text=this.dstyle.opacity.toString();
			this.diameter.getText().text=this.dstyle.diameter.toString();
			this.symmetryEnabled.selected=this.dstyle.isSymmetry;
			this.symmetryPoints.getText().text=this.dstyle.symmetryPoints.toString();
			this.brushRenderer.popup.list.selectedIndex = this.dstyle.selectedBrush;
			this.brushRenderer.popup.list.dispatchEvent(new ListEvent(ListEvent.CHANGE));
			this.brushRenderer.setBitmapData(this.dstyle.bitmap);
		}

		public function addColorEvent():void {
			Application.application.pallete.getColors().top.addEventListener(ColorPickerEvent.CHANGE, dStyleChanged);
		}

		public function getController():UIComponent {
			return this;
		}

		public function updateStyle(style:DStyle):void {
			this.dstyle = BrushStyle(style);
			getDStyle();
		}

	}
}