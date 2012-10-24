package com.atensys.imake.draw.colors
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.ListCollectionView;
	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.ColorPicker;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	/**
	 *Colors swatches.
	 *
	 *  @author Andrei Sirghi.
	 *
	 */
	public class ProductColorSwatches extends Box
	{
		private var dataProvider:ArrayCollection;
		private var colorNames:ArrayCollection;
		private var bts:ArrayCollection;
		
		public function ProductColorSwatches()
		{
		}
		
		private function initComponents():void
		{
			var cb:VBox=new VBox();
			setStyle("layout", "vertical");
			setStyle("horizontalAlign", "center");
			var cp:ColorPicker=new ColorPicker();
			addChild(cb);
			cb.setStyle("horizontalGap", 1);
			cb.setStyle("verticalGap", 1);
			bts=new ArrayCollection();
			var j:int=0;
			var b:HBox=new HBox();
			b.setStyle("horizontalGap", 1);
			b.setStyle("verticalGap", 1);
			for (var i:int=0; i < dataProvider.length; i++)
			{
				if (j == 6)
				{
					cb.addChild(b);
					b=new HBox();
					b.setStyle("horizontalGap", 1);
					b.setStyle("verticalGap", 1);
					j=0;
				}
				var s:Button=new Button();
				s.height=27;
				s.width=27;
				s.setStyle("cornerRadius", "0");
				s.setStyle("toggle", true);
				s.setStyle("fillAphas", "[0, 0]");
				s.setStyle("color", toHex(dataProvider[i]));
				s.setStyle("borderColor", toHex(dataProvider[i]));
				s.setStyle("backgroundColor", "0x" + toHex(dataProvider[i]));
				s.graphics.clear();
				s.graphics.beginFill(dataProvider[i]);
				s.graphics.drawRect(0, 0, s.width, s.height);
				s.setStyle("emphasized", true);
				s.addEventListener(MouseEvent.CLICK, changeColor);
				s.toolTip = String(colorNames.getItemAt(i));
				bts.addItem(s);
				b.addChild(s);
				j++;
			}
			if (!cb.contains(b))
			{
				cb.addChild(b);
			}
		}
		
		
		public function setColors(dp:ArrayCollection, colNames:ArrayCollection):void
		{
			this.removeAllChildren();
			this.dataProvider=dp;
			this.colorNames = colNames;
			initComponents();
		}
		
		private function toHex(item:Object):String
		{
			var hex:String=Number(item).toString(16);
			return ("00000" + hex.toUpperCase()).substr(-6);
		}
		
		public function selectColor(c:Number):void{
			for( var i:Number = 0; i<dataProvider.length; i++)
			{
				if(dataProvider.getItemAt(i) == c){
					Button(bts.getItemAt(i)).setStyle("borderColor", "0xFF0000");
				}
				else{
					Button(bts.getItemAt(i)).setStyle("borderColor", "0xAAB3B3");
				}
			}
		}
		
		private function changeColor(evt:MouseEvent):void
		{
			for each (var btt:Button in bts)
			{
				btt.setStyle("borderColor", "0xAAB3B3");
			}
			Button(evt.target).setStyle("borderColor", "0xFF0000");
			var bt:Button=Button(evt.target);
			for (var i:int=0; i < bts.length; i++)
			{
				if (bts[i] == bt)
				{
					Application.application.desktop.setProductColor(dataProvider[i]);
				}
			}
		}
		
	}
}