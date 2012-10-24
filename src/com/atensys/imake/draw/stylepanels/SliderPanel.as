package com.atensys.imake.draw.stylepanels
{
	import mx.containers.HBox;
	import mx.controls.HSlider;
	import mx.controls.sliderClasses.Slider;
	
	public class SliderPanel extends HBox
	{
		private var slider:Slider=new HSlider();
		
		public function SliderPanel()
		{
			super();
			addChild(slider);
			setStyle("backgroundColor", "0xDDDDDD");
		}
		
		public function setSnapInterval(value:Number):void{
				this.slider.snapInterval=value;
			}
			
			public function setTickInterval(value:Number):void{
				this.slider.tickInterval=value;
			}
			
			public function setLiveDragging(value:Boolean):void{
				this.slider.liveDragging=value;
			}
			
			public function setAllowTrackClick(value:Boolean):void{
				this.slider.allowTrackClick=value;
			}
			
			public function setSliderLabels(value:Array):void{
				this.slider.labels=value;
			}
			
			public function setSliderValues(minValue:Number, maxValue:Number):void{
				this.slider.minimum=minValue;
				this.slider.maximum=maxValue;
			}
			
			public function getSlider():Slider{
				return this.slider;
			}
	}
}