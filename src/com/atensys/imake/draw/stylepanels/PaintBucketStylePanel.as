package com.atensys.imake.draw.stylepanels {
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.PaintBucketStyle;
	
	import flash.events.Event;
	
	import mx.containers.HBox;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.validators.NumberValidator;

	/**
	 * Paint Bucket Style Panel.
	 */
	public class PaintBucketStylePanel extends HBox implements DStylePanel {
		private var tolerance:ComboText;
		private var dstyle:PaintBucketStyle=new PaintBucketStyle();

		public function PaintBucketStylePanel() {
			super();
			this.dstyle=new PaintBucketStyle();
			initTolerance();
		}

		private function initTolerance():void {
			tolerance=new ComboText();
			tolerance.setStyle("verticalAlign", "middle");
			tolerance.getText().text="10";
			tolerance.setLabel("Tolerance(%):");
			tolerance.setAllowTrackClick(true);
			tolerance.setTickInterval(10);
			tolerance.setSnapInterval(1);
			tolerance.setSliderLabels(["0%", "100%"]);
			tolerance.setSliderValues(0, 100);
			var toleranceValidator:NumberValidator=new NumberValidator();
			toleranceValidator.required=true;
			toleranceValidator.minValue=0;
			toleranceValidator.maxValue=100;
			toleranceValidator.domain="int";
			tolerance.setValidator(toleranceValidator);
			tolerance.getText().addEventListener(Event.CHANGE, dStyleChanged);
			addChild(tolerance);
		}

		public function dStyleChanged(evt:Event):void {
			dstyle.color=Application.application.pallete.getColors().getTopColor();
			this.dstyle.tolerance=int(tolerance.getText().text);
			Application.application.desktop.setDStyle(this.dstyle);
		}
		/**
		 * get current style from StylePanel
		 * */
		public function getStyleFromPanel():PaintBucketStyle
		{
			var st:PaintBucketStyle=new PaintBucketStyle();
			st.color=Application.application.pallete.getColors().getTopColor();
			st.tolerance = int(tolerance.getText().text);
			return st;
		}
/**
		 * set current StylePanel with this style
		 * */
		public function setPanelStyle():void
		{
			Application.application.pallete.getColors().setTopColor(this.dstyle.color);
			tolerance.getText().text=this.dstyle.tolerance.toString();
		}
		public function getController():UIComponent {
			return this;
		}

		public function updateStyle(style:DStyle):void {
			this.dstyle=PaintBucketStyle(style);
			setPanelStyle();
		}
	}
}