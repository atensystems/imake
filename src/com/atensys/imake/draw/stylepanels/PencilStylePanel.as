package com.atensys.imake.draw.stylepanels
{
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.PencilStyle;
	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
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

	public class PencilStylePanel extends HBox implements DStylePanel
	{
		private var opacity:ComboText;
		private var diameter:ComboText;
		public var dstyle:PencilStyle;
		private var pixelHinting:CheckBox;
		private var lineStyle:ComboBox;
		private var lineJoint:ComboBox;


		[Bindable]
		[Embed(source="assets/square.png")]
		private var square:Class;

		[Bindable]
		[Embed(source="assets/round.png")]
		private var round:Class;

		[Bindable]
		[Embed(source="assets/narrow.png")]
		private var narrow:Class;

		[Bindable]
		private var caps:ArrayCollection=new ArrayCollection([{label: "Square", icon: square, data: CapsStyle.SQUARE}, {label: "Round", icon: round, data: CapsStyle.ROUND}, {label: "Narrow", icon: narrow, data: CapsStyle.NONE}]);
		[Bindable]
		private var jointStates:ArrayCollection=new ArrayCollection([{label: "Miter", data: JointStyle.MITER}, {label: "Round", data: JointStyle.ROUND}, {label: "Bevel", data: JointStyle.BEVEL}]);

		public function PencilStylePanel()
		{
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
			dstyle=new PencilStyle();
			b=new Box();
			b.width=15;
			addChild(b);
			initLineJoint();
			b=new Box();
			b.width=15;
			addChild(b);
			initPixelHinting();
			//addEventListener(FlexEvent.UPDATE_COMPLETE, styleChange);
		}

		public function initLineStyle():void
		{
			lineStyle=new ComboBox();
			lineStyle.dataProvider=this.caps;
			lineStyle.setStyle("verticalAlign", "middle");
			var styleLabel:Label=new Label();
			styleLabel.text="Style:";
			styleLabel.setStyle("verticalAlign", "middle");
			addChild(styleLabel);
			addChild(lineStyle);
			lineStyle.selectedIndex=1;
		}

		public function initDiameter():void
		{
			diameter=new ComboText();
			diameter.setStyle("verticalAlign", "middle");
			diameter.getText().text="1";
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


		public function initOpacity():void
		{
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

		public function initPixelHinting():void
		{
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

		public function initLineJoint():void
		{
			lineJoint=new ComboBox()
			lineJoint.setStyle("verticalAlign", "middle");
			lineJoint.dataProvider=this.jointStates;
			var jointLabel:Label=new Label();
			jointLabel.text="Line Joint Style:";
			jointLabel.setStyle("verticalAlign", "middle");
			addChild(jointLabel);
			addChild(lineJoint);
			lineJoint.addEventListener(Event.CHANGE, dStyleChanged);
			lineJoint.selectedIndex=1;
		}

		public function addStyleChangeEvents():void
		{
			this.diameter.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.opacity.getText().addEventListener(Event.CHANGE, dStyleChanged);
			this.lineStyle.addEventListener(Event.CHANGE, dStyleChanged);
		}

		public function dStyleChanged(evt:Event):void
		{
			this.dstyle.color=Application.application.pallete.getColors().getTopColor();
			this.dstyle.opacity=int(opacity.getText().text);
			this.dstyle.diameter=int(this.diameter.getText().text);
			this.dstyle.style=lineStyle.selectedItem.data;
			this.dstyle.pixelHinting=pixelHinting.selected;
			this.dstyle.lineJoint=lineJoint.selectedItem.data;
			Application.application.desktop.setDStyle(this.dstyle);
		}

		public function styleChange(evt:Event):void
		{
			Application.application.desktop.setDStyle(PencilStylePanel(evt.target).dstyle);
		}

		/**
		 * set current StylePanel with this style
		 * */
		public function setPanelStyle():void
		{
			Application.application.pallete.getColors().setTopColor(this.dstyle.color);
			opacity.getText().text=this.dstyle.opacity.toString();
			this.diameter.getText().text=this.dstyle.diameter.toString();
			switch (this.dstyle.style)
			{
				case CapsStyle.SQUARE:
					lineStyle.selectedIndex=0;
					break
				case CapsStyle.ROUND:
					lineStyle.selectedIndex=1;
					break;
				case CapsStyle.NONE:
					lineStyle.selectedIndex=2;
					break;
			}
			pixelHinting.selected=this.dstyle.pixelHinting;
			switch (this.dstyle.lineJoint)
			{
				case JointStyle.MITER:
					lineJoint.selectedIndex=0;
					break;
				case JointStyle.ROUND:
					lineJoint.selectedIndex=1;
					break;
				case JointStyle.BEVEL:
					lineJoint.selectedIndex=2;
					break;
			}
		}

		/**
		 * get current style from StylePanel
		 * */
		public function getStyleFromPanel():PencilStyle
		{
			var st:PencilStyle=new PencilStyle();
			st.color=Application.application.pallete.getColors().getTopColor();
			st.opacity=int(opacity.getText().text);
			st.diameter=int(this.diameter.getText().text);
			st.style=lineStyle.selectedItem.data;
			st.pixelHinting=pixelHinting.selected;
			st.lineJoint=lineJoint.selectedItem.data;
			return st;
		}

		public function addColorEvent():void
		{
			Application.application.pallete.getColors().top.addEventListener(ColorPickerEvent.CHANGE, dStyleChanged);
		}

		public function getController():UIComponent
		{
			return this;
		}

		public function updateStyle(style:DStyle):void
		{
			this.dstyle=PencilStyle(style);
			setPanelStyle();

		}

	}
}