package com.atensys.imake.draw.colors
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.ColorPicker;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	/**
	 *Colors swatches. 
	 *
	 *  @author Andrei Sirghi.
	 * 
	 */
	public class Swatches extends Box
	{
		private var dataProvider:IList;
		private var bts:ArrayCollection;
		public var colors:ColorsPallete;

		public function Swatches()
		{
			initComponents();
		}
		
		private function initComponents():void
		{
			var cb:VBox=new VBox();
			setStyle("layout", "vertical");			
			var cp:ColorPicker=new ColorPicker();
			addChild(cb);
			cb.setStyle("horizontalGap", 1);
			cb.setStyle("verticalGap", 1);
			this.dataProvider=IList(cp.dataProvider);
			bts=new ArrayCollection();
			var j:int=0;
			var b:HBox=new HBox();
			b.setStyle("horizontalGap", 1);
			b.setStyle("verticalGap", 1);
			for(var i:int=0;i<dataProvider.length;i++){
				if(j==20){
				cb.addChild(b);
					b=new HBox();
					b.setStyle("horizontalGap", 1);
					b.setStyle("verticalGap", 1);	
					j=0;
				}
				var s:Sprite=new Sprite();
				s.graphics.clear();
				s.graphics.lineStyle(1, 0x0093a9b4);
				s.graphics.beginFill(0x00000000+dataProvider[i]);
				s.graphics.drawRect(0, 0 , 8, 8);
				s.graphics.endFill();
				s.addEventListener(MouseEvent.CLICK, changeColor);
				bts.addItem(s);
				var uiComponent:UIComponent = new UIComponent();
				uiComponent.width = 8;
				uiComponent.height = 8;
				b.addChild(uiComponent);
				uiComponent.addChild(s);
				j++;
			}
			var bt:Button=new Button();
			bt.label="Advanced";
			bt.width=180;
			bt.addEventListener(MouseEvent.CLICK, advanced);
			this.addChild(bt);
		}
		
		private function toHex(item:Object):String {
            var hex:String = Number(item).toString(16);
            return ("00000" + hex.toUpperCase()).substr(-6);
        }
        
        private function changeColor(evt:MouseEvent):void{
        	if(this.colors!=null){
        		var bt:Sprite=Sprite(evt.target);
        		for(var i:int=0;i<bts.length;i++){
        			if(bts[i]==bt){
        				this.colors.changeColor(dataProvider[i]);
        			}
        		}
        	}
        }
        
        private function advanced(evt:MouseEvent):void{
			stage.frameRate = 120;
			var pop1:* = PopUpManager.createPopUp(this.parent, advancedColorPicker, false);
			pop1.setColorRGB(colors.getColor());
			pop1.lastColor = colors.getColor();
			pop1.addEventListener(MouseEvent.CLICK, setColor);
		
			function setColor(evt:MouseEvent):void {
				var adc:advancedColorPicker=advancedColorPicker(pop1);
				colors.changeColor(adc.lastColor);
			}
        }
		
	}
}