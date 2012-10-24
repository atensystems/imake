package com.atensys.imake.draw.effect
{
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.component.DComponent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.containers.TitleWindow;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.controls.ColorPicker;
	import mx.controls.HSlider;
	import mx.controls.Label;
	import mx.controls.List;
	import mx.controls.VRule;
	import mx.core.ClassFactory;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.ColorPickerEvent;
	import mx.events.ListEvent;
	import mx.events.SliderEvent;
	import mx.managers.PopUpManager;
	use namespace mx_internal;



	public class EffectPopup extends TitleWindow
	{
		private var bevelButton:Button;
		private var bevelCheck:CheckBox;
		private var extrudeButton:Button;
		private var extrudeCheck:CheckBox;
		private var distressButton:Button;
		private var distressCheck:CheckBox;
		private var shadowButton:Button;
		private var shadowCheck:CheckBox;
		private var preview:UIComponent;

		private var propBox:HBox;
		private var bitmapData:BitmapData;
		private var extrudeSprite:Sprite=new Sprite();
		private var finalextrudeSprite:Sprite=new Sprite();
		private var mouseDown:Boolean=false;
		private var mX:int, mY:int, pX:int, pY:int;
		private var distresN:int=15;
		private var isDistress:Boolean=false;
		private var extrudeLayer:int=20;
		private var isExtrude:Boolean=false;
		private var firstRow:VBox=new VBox();
		private var secondRow:VBox=new VBox();
		private var previewBox:VBox=new VBox();
		private var center:Button;
		private var efectBitmapData:BitmapData;
		private var cloneSourceBD:BitmapData;
		private var buttonCancel:Button;
		private var buttonApply:Button;
		private var source:Bitmap;
		private var initialSource:BitmapData;
		private var efectList:List;
		private var filterss:Array=new Array();
		private var _componentEffect:ComponentEffects;

		public function EffectPopup(comp:DComponent)
		{
			super();
			this.title = "Effects";
			this.showCloseButton=true;
			this.source=comp.getSource();
			this.cloneSourceBD=source.bitmapData.clone();
			this.componentEffect=comp.getDStyle().effect;
			initComponents();
			drawPreview();
		}

		private function initEfectList():void
		{
			var array:Array=[new ListItemValueObject("Bevel", false), new ListItemValueObject("Shadow", false), new ListItemValueObject("Glow", false), new ListItemValueObject("Blur", false), new ListItemValueObject("Distress", false)/* , new ListItemValueObject("Extrude", false) */];

			var effectArraycol:ArrayCollection=new ArrayCollection(array);
			efectList=new List();
			efectList.setStyle("paddingRight", 5);
			efectList.percentHeight=100;
			efectList.dataProvider=effectArraycol;
			efectList.itemRenderer=new ClassFactory(ListItemRenderer);
			efectList.addEventListener("ItemChecked", changeFilters);
			efectList.addEventListener("ItemUnchecked", changeFilters);
			efectList.addEventListener(ListEvent.ITEM_CLICK, setPropBox);
			ListItemValueObject(effectArraycol.getItemAt(0)).isSelected=componentEffect.isBevel;
			ListItemValueObject(effectArraycol.getItemAt(1)).isSelected=componentEffect.isShadow;
			ListItemValueObject(effectArraycol.getItemAt(2)).isSelected=componentEffect.isGlow;
			ListItemValueObject(effectArraycol.getItemAt(3)).isSelected=componentEffect.isBlur;
			ListItemValueObject(effectArraycol.getItemAt(4)).isSelected=componentEffect.isDistress;
			//ListItemValueObject(effectArraycol.getItemAt(5)).isSelected=componentEffect.isExtrude;
		}


		public function set componentEffect(value:ComponentEffects):void
		{
			_componentEffect=value;
		}

		public function get componentEffect():ComponentEffects
		{
			return _componentEffect;
		}

		private function onItemChecked(evt:Event):void
		{
			evt.stopPropagation();
		}

		private function onItemUnchecked(evt:Event):void
		{
			evt.stopPropagation();
		}

		private function cancelEvent(evt:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}

		private function applyEvent(evt:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}

		/**
		 * Change filters
		 * */
		private function changeFilters(evt:Event):void
		{
			drawPreview();
		}

		/**
		 * Get effect box
		 * */
		private function getEfectBox():VBox
		{
			var efectBox:VBox=new VBox();
			efectBox.addChild(efectList);
			return efectBox;
		}


		private function existIn(array:Array, clas:Class):Boolean
		{
			var exist:Boolean=false;
			for (var i:int=0; i < array.length; i++)
			{
				if (array[i] is clas)
				{
					exist=true;
				}
			}
			return exist;
		}



		public function drawPreview():void
		{
			var arrcol:ArrayCollection=ArrayCollection(efectList.dataProvider);
			filterss=[];
			source.bitmapData = cloneSourceBD.clone();
			//disposeDistress(source.bitmapData);
			if (ListItemValueObject(arrcol[4]).isSelected == true)
			{
				Util.makeDistress(source.bitmapData,componentEffect.distress.distressN);
				componentEffect.isDistress=true;
			}
			else
			{
				componentEffect.isDistress=false;
			}
			if (ListItemValueObject(arrcol[0]).isSelected == true)
			{
				componentEffect.isBevel=true;
				filterss.push(componentEffect.bevel);
			}
			else
			{
				componentEffect.isBevel=false;
			}
			if (ListItemValueObject(arrcol[1]).isSelected == true)
			{
				componentEffect.isShadow=true;
				filterss.push(componentEffect.shadow);
			}
			else
			{
				componentEffect.isShadow=false;
			}
			if (ListItemValueObject(arrcol[2]).isSelected == true)
			{
				componentEffect.isGlow=true;
				filterss.push(componentEffect.glow);
			}
			else
			{
				componentEffect.isGlow=false;
			}
			if (ListItemValueObject(arrcol[3]).isSelected == true)
			{
				componentEffect.isBlur=true;
				filterss.push(componentEffect.blur);
			}
			else
			{
				componentEffect.isBlur=false;
			}
			source.filters=filterss;
		
		}
		
		
		private function removeChildren(comp:UIComponent):void
		{
			for (var i:int=1; i < comp.numChildren; i++)
			{
				comp.removeChildAt(i);
			}
		}
		public function getDistress():int
		{
			if (isDistress)
			{
				return distresN;
			}
			return -1;
		}

		public function getExtrude():Boolean
		{
			return isExtrude;
		}

		public function getExtrudeLayer():int
		{
			return extrudeLayer;
		}

		public function getExtrudeFocalLenght():int
		{
			return previewBox.transform.perspectiveProjection.focalLength;
		}

		public function getExtrudeProjectionPoint():Point
		{
			return previewBox.transform.perspectiveProjection.projectionCenter;
		}

		private function setPropBox(evt:ListEvent):void
		{
			var itemName:String;
			itemName=ListItemValueObject(List(evt.target).selectedItem).name;
			switch (itemName)
			{
				case "Bevel":
					bevelEvent();
					break;

				case "Shadow":
					shadowEvent();
					break;

				case "Glow":
					glowEvent();
					break;

				case "Blur":
					blurEvent();
					break;

				case "Distress":
					distressEvent();
					break;

				case "Extrude":
					extrudeEvent();
					break;

				default:
					break;
			}

		}

		/**
		 * initialize Efect Window
		 * */
		private function initComponents():void
		{
			initEfectList();
			var allBox:VBox=new VBox();
			var oneEfect:HBox=new HBox();
			propBox=new HBox();
			var vrule:VRule=new VRule();
			vrule.height=200;
			propBox.setStyle("borderStyle", "solid");
			propBox.setStyle("paddingLeft", 10);
			propBox.setStyle("paddingRight", 10);
			propBox.setStyle("paddingTop", 10);
			propBox.setStyle("paddingBottom", 10);
			propBox.addChild(firstRow);
			propBox.addChild(vrule);
			propBox.addChild(secondRow);

			oneEfect.addChild(getEfectBox());
			oneEfect.addChild(propBox);

			buttonCancel=new Button();
			buttonCancel.label="Cancel";
			buttonCancel.addEventListener(MouseEvent.CLICK, cancelEvent);
			buttonApply=new Button();
			buttonApply.label="OK";
			buttonApply.addEventListener(MouseEvent.CLICK, applyEvent);

			var butonBox:HBox=new HBox();
			butonBox.setStyle("horizontalAlign", "right");
			buttonCancel.setStyle("horizontalAlign", "right");
			buttonApply.setStyle("horizontalAlign", "right");
			var separator:HBox=new HBox();
			separator.width=520;
			butonBox.addChild(separator);
			butonBox.addChild(buttonApply);
			butonBox.addChild(buttonCancel);

			this.width=690;
			this.height=320;

			firstRow.width=260;
			firstRow.height=220;
			secondRow.width=260;
			secondRow.height=220;
			firstRow.removeAllChildren();
			secondRow.removeAllChildren();

			initBeveledPropBox();
			efectList.height=220;
			allBox.addChild(oneEfect);

			allBox.addChild(butonBox);
			this.addChild(allBox);
		}

		/**
		 * Initialize Filters
		 * */
		private function initFilters():void
		{
//			bevelFilter=(indexOfFrom(BevelFilter, filterss) != -1) ? filterss[indexOfFrom(BevelFilter, filterss)] : new BevelFilter(5, 45, 0xFFFFFF, 0.4, 0x000000, 0.4, 2, 2);
//			shadowFilter=(indexOfFrom(DropShadowFilter, filterss) != -1) ? filterss[indexOfFrom(DropShadowFilter, filterss)] : new DropShadowFilter();
//			glovFilter=(indexOfFrom(GlowFilter, filterss) != -1) ? filterss[indexOfFrom(GlowFilter, filterss)] : new GlowFilter(0xFFFFFF, 0.5, 6, 6, 2, 1, true);
//			blurFilter=(indexOfFrom(BlurFilter, filterss) != -1) ? filterss[indexOfFrom(BlurFilter, filterss)] : new BlurFilter(0, 0);
//
//			if (this.dstylePanel.getController() is TextStylePanel) {
//				if (TextStyle(this.dstyle).isDistress) {
//					distresN=TextStyle(this.dstyle).distressN;
//					isDistress=true;
//				}
//				if (TextStyle(this.dstyle).isExtrude) {
//					extrudeLayer=TextStyle(this.dstyle).extrudeLayers;
//					previewBox.transform.perspectiveProjection.projectionCenter=TextStyle(this.dstyle).extrudeProjectionPoint;
//					previewBox.transform.perspectiveProjection.focalLength=TextStyle(this.dstyle).extrudeFocalLenght;
//					isExtrude=true;
//				}
//			}
		/* 			if (this.dstylePanel.getController() is ImageStylePanel)
		   {
		   if (ImageStyle(this.dstyle).isDistress)
		   {
		   distresN=ImageStyle(this.dstyle).distressN;
		   isDistress=true;
		   }
		   if (ImageStyle(this.dstyle).isExtrude)
		   {
		   extrudeLayer=ImageStyle(this.dstyle).extrudeLayers;
		   previewBox.transform.perspectiveProjection.projectionCenter=ImageStyle(this.dstyle).extrudeProjectionPoint;
		   previewBox.transform.perspectiveProjection.focalLength=ImageStyle(this.dstyle).extrudeFocalLenght;
		   isExtrude=true;
		   }
		 } */
		}

		private function indexOfFrom(clas:Class, array:Array):int
		{
			for (var i:int=0; i < array.length; i++)
			{
				if (array[i] is clas)
				{
					return i;
				}
			}
			return -1;
		}

//++++++++++++++++++++++++++++++++Bevel Effect++++++++++++++++++++++++++++++++++++++++		
		/**
		 * Bevel button Event
		 * */
		private function bevelEvent():void
		{
			firstRow.removeAllChildren();
			secondRow.removeAllChildren();
			initBeveledPropBox();
		}

		/**
		 * Initialize Bevel Property Box
		 * */

		private function initBeveledPropBox():void
		{

			var distanceSlider:HSlider=new HSlider();
			distanceSlider.minimum=1;
			distanceSlider.maximum=10;
			distanceSlider.value=componentEffect.bevel.distance;
			distanceSlider.snapInterval=.2;
			distanceSlider.setStyle("labelOffset", 3);
			distanceSlider.labels=["0", "10"];
			distanceSlider.addEventListener(SliderEvent.CHANGE, changeDistance);
			var distanceLabel:Label=new Label();
			distanceLabel.text="Distance:";
			distanceLabel.width=90;
			var distanceBox:HBox=new HBox();
			distanceBox.addChild(distanceLabel);
			distanceBox.addChild(distanceSlider);
			firstRow.addChild(distanceBox);

			var angleSlider:HSlider=new HSlider();
			angleSlider.minimum=0;
			angleSlider.maximum=360;
			angleSlider.value=componentEffect.bevel.angle;
			angleSlider.snapInterval=5;
			angleSlider.setStyle("labelOffset", 3);
			angleSlider.labels=["0", "360"];
			angleSlider.addEventListener(SliderEvent.CHANGE, changeAngle);
			var angleLabel:Label=new Label();
			angleLabel.text="Angle:";
			angleLabel.width=90;
			var angleBox:HBox=new HBox();
			angleBox.addChild(angleLabel);
			angleBox.addChild(angleSlider);
			firstRow.addChild(angleBox);

			var highlightColorPicker:ColorPicker=new ColorPicker();
			highlightColorPicker.selectedColor=componentEffect.bevel.highlightColor;
			highlightColorPicker.addEventListener(ColorPickerEvent.CHANGE, changeHighlightColor);
			var highlightLabel:Label=new Label();
			highlightLabel.text="Highlight Color:";
			highlightLabel.width=90;
			var highlightBox:HBox=new HBox();
			highlightBox.addChild(highlightLabel);
			highlightBox.addChild(highlightColorPicker);
			firstRow.addChild(highlightBox);

			var highlightAlphaSlider:HSlider=new HSlider();
			highlightAlphaSlider.minimum=0;
			highlightAlphaSlider.maximum=1;
			highlightAlphaSlider.value=componentEffect.bevel.highlightAlpha;
			highlightAlphaSlider.snapInterval=.01;
			highlightAlphaSlider.setStyle("labelOffset", 3);
			highlightAlphaSlider.labels=["0", "1"];
			highlightAlphaSlider.addEventListener(SliderEvent.CHANGE, changeHighlightAlpha);
			var highlightAlphaLabel:Label=new Label();
			highlightAlphaLabel.text="Highlight Alpha:";
			highlightAlphaLabel.width=90;
			var highlightAlphaBox:HBox=new HBox();
			highlightAlphaBox.addChild(highlightAlphaLabel);
			highlightAlphaBox.addChild(highlightAlphaSlider);
			firstRow.addChild(highlightAlphaBox);

			var shadowColorPicker:ColorPicker=new ColorPicker();
			shadowColorPicker.selectedColor=componentEffect.bevel.shadowColor;
			shadowColorPicker.addEventListener(ColorPickerEvent.CHANGE, changeShadowColor);
			var shadowLabel:Label=new Label();
			shadowLabel.text="Shadow Color:";
			shadowLabel.width=90;
			var shadowColorBox:HBox=new HBox();
			shadowColorBox.addChild(shadowLabel);
			shadowColorBox.addChild(shadowColorPicker);
			firstRow.addChild(shadowColorBox);

			var shadowAlphaSlider:HSlider=new HSlider();
			shadowAlphaSlider.minimum=0;
			shadowAlphaSlider.maximum=1;
			shadowAlphaSlider.value=componentEffect.bevel.shadowAlpha;
			shadowAlphaSlider.snapInterval=.01;
			shadowAlphaSlider.setStyle("labelOffset", 3);
			shadowAlphaSlider.labels=["0", "1"];
			shadowAlphaSlider.addEventListener(SliderEvent.CHANGE, changeShadowAlpha);
			var shadowAlphaLabel:Label=new Label();
			shadowAlphaLabel.text="Shadow Alpha:";
			shadowAlphaLabel.width=90;
			var shadowAlphaBox:HBox=new HBox();
			shadowAlphaBox.addChild(shadowAlphaLabel);
			shadowAlphaBox.addChild(shadowAlphaSlider);
			firstRow.addChild(shadowAlphaBox);

			var blurXSlider:HSlider=new HSlider();
			blurXSlider.minimum=1;
			blurXSlider.maximum=20;
			blurXSlider.value=componentEffect.bevel.blurX;
			blurXSlider.snapInterval=.5;
			blurXSlider.setStyle("labelOffset", 3);
			blurXSlider.labels=["0", "20"];
			blurXSlider.addEventListener(SliderEvent.CHANGE, changeblurX);
			var blurXLabel:Label=new Label();
			blurXLabel.text="Blur X:";
			blurXLabel.width=60;
			var blurXBox:HBox=new HBox();
			blurXBox.addChild(blurXLabel);
			blurXBox.addChild(blurXSlider);
			secondRow.addChild(blurXBox);

			var blurYSlider:HSlider=new HSlider();
			blurYSlider.minimum=1;
			blurYSlider.maximum=20;
			blurYSlider.value=componentEffect.bevel.blurY;
			blurYSlider.snapInterval=.5;
			blurYSlider.setStyle("labelOffset", 3);
			blurYSlider.labels=["0", "20"];
			blurYSlider.addEventListener(SliderEvent.CHANGE, changeblurY);
			var blurYLabel:Label=new Label();
			blurYLabel.text="Blur Y:";
			blurYLabel.width=60;
			var blurYBox:HBox=new HBox();
			blurYBox.addChild(blurYLabel);
			blurYBox.addChild(blurYSlider);
			secondRow.addChild(blurYBox);

			var strengthSlider:HSlider=new HSlider();
			strengthSlider.minimum=0;
			strengthSlider.maximum=10;
			strengthSlider.value=componentEffect.bevel.strength;
			strengthSlider.snapInterval=.01;
			strengthSlider.setStyle("labelOffset", 3);
			strengthSlider.labels=["0", "10"];
			strengthSlider.addEventListener(SliderEvent.CHANGE, changeStrength);
			var strengthLabel:Label=new Label();
			strengthLabel.text="Strength:";
			strengthLabel.width=60;
			var strengthBox:HBox=new HBox();
			strengthBox.addChild(strengthLabel);
			strengthBox.addChild(strengthSlider);
			secondRow.addChild(strengthBox);

			var qualitySlider:HSlider=new HSlider();
			qualitySlider.minimum=0;
			qualitySlider.maximum=10;
			qualitySlider.value=componentEffect.bevel.quality;
			qualitySlider.snapInterval=.01;
			qualitySlider.setStyle("labelOffset", 3);
			qualitySlider.labels=["0", "10"];
			qualitySlider.addEventListener(SliderEvent.CHANGE, changeQuality);
			var qualityLabel:Label=new Label();
			qualityLabel.text="Quality:";
			qualityLabel.width=60;
			var qualityBox:HBox=new HBox();
			qualityBox.addChild(qualityLabel);
			qualityBox.addChild(qualitySlider);
			secondRow.addChild(qualityBox);

			var knockoutCheckBox:CheckBox=new CheckBox();
			knockoutCheckBox.selected=componentEffect.bevel.knockout;
			knockoutCheckBox.addEventListener(MouseEvent.CLICK, changeKnockout);
			var knockoutLabel:Label=new Label();
			knockoutLabel.text="Knockout:";
			knockoutLabel.width=60;
			var knockoutBox:HBox=new HBox();
			knockoutBox.addChild(knockoutLabel);
			knockoutBox.addChild(knockoutCheckBox);
			secondRow.addChild(knockoutBox);

		}

		private function changeKnockout(evt:MouseEvent):void
		{
			componentEffect.bevel.knockout=CheckBox(evt.target).selected;
			drawPreview();
		}

		private function changeQuality(evt:SliderEvent):void
		{
			componentEffect.bevel.quality=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeStrength(evt:SliderEvent):void
		{
			componentEffect.bevel.strength=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeblurY(evt:SliderEvent):void
		{
			componentEffect.bevel.blurY=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeblurX(evt:SliderEvent):void
		{
			componentEffect.bevel.blurX=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeShadowAlpha(evt:SliderEvent):void
		{
			componentEffect.bevel.shadowAlpha=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeShadowColor(evt:ColorPickerEvent):void
		{
			componentEffect.bevel.shadowColor=ColorPicker(evt.target).selectedColor;
			drawPreview();
		}

		private function changeHighlightAlpha(evt:SliderEvent):void
		{
			componentEffect.bevel.highlightAlpha=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeHighlightColor(evt:ColorPickerEvent):void
		{
			componentEffect.bevel.highlightColor=ColorPicker(evt.target).selectedColor;
			drawPreview();
		}

		private function changeAngle(evt:SliderEvent):void
		{
			componentEffect.bevel.angle=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeDistance(evt:SliderEvent):void
		{
			componentEffect.bevel.distance=HSlider(evt.target).value;
			drawPreview();
		}


//++++++++++++++++++++++++++++++++DropShadow Effect++++++++++++++++++++++++++++++++++++++++		
		/**
		 * Shadow button Event
		 * */
		private function shadowEvent():void
		{
			firstRow.removeAllChildren();
			secondRow.removeAllChildren();
			drawPreview();
			initShadowPropBox();
		}


		/**
		 * Initialize shadow Property Box
		 * */


		private function initShadowPropBox():void
		{

			var distanceSlider:HSlider=new HSlider();
			distanceSlider.minimum=1;
			distanceSlider.maximum=10;
			distanceSlider.value=componentEffect.shadow.distance;
			distanceSlider.snapInterval=.2;
			distanceSlider.setStyle("labelOffset", 3);
			distanceSlider.labels=["0", "10"];
			distanceSlider.addEventListener(SliderEvent.CHANGE, changeShadowDistance);
			var distanceLabel:Label=new Label();
			distanceLabel.text="Shadow Distance:";
			distanceLabel.width=90;
			var distanceBox:HBox=new HBox();
			distanceBox.addChild(distanceLabel);
			distanceBox.addChild(distanceSlider);
			firstRow.addChild(distanceBox);

			var angleSlider:HSlider=new HSlider();
			angleSlider.minimum=0;
			angleSlider.maximum=360;
			angleSlider.value=componentEffect.shadow.angle;
			angleSlider.snapInterval=5;
			angleSlider.setStyle("labelOffset", 3);
			angleSlider.labels=["0", "360"];
			angleSlider.addEventListener(SliderEvent.CHANGE, changeShadowAngle);
			var angleLabel:Label=new Label();
			angleLabel.text="Shadow Angle:";
			angleLabel.width=90;
			var angleBox:HBox=new HBox();
			angleBox.addChild(angleLabel);
			angleBox.addChild(angleSlider);
			firstRow.addChild(angleBox);

			var highlightColorPicker:ColorPicker=new ColorPicker();
			highlightColorPicker.selectedColor=componentEffect.shadow.color;
			highlightColorPicker.addEventListener(ColorPickerEvent.CHANGE, changeShadowHighlightColor);
			var highlightLabel:Label=new Label();
			highlightLabel.text="Shadow Color:";
			highlightLabel.width=90;
			var highlightBox:HBox=new HBox();
			highlightBox.addChild(highlightLabel);
			highlightBox.addChild(highlightColorPicker);
			firstRow.addChild(highlightBox);

			var blurXSlider:HSlider=new HSlider();
			blurXSlider.minimum=1;
			blurXSlider.maximum=20;
			blurXSlider.value=componentEffect.shadow.blurX;
			blurXSlider.snapInterval=.5;
			blurXSlider.setStyle("labelOffset", 3);
			blurXSlider.labels=["0", "20"];
			blurXSlider.addEventListener(SliderEvent.CHANGE, changeShadowblurX);
			var blurXLabel:Label=new Label();
			blurXLabel.text="Blur X:";
			blurXLabel.width=90;
			var blurXBox:HBox=new HBox();
			blurXBox.addChild(blurXLabel);
			blurXBox.addChild(blurXSlider);
			firstRow.addChild(blurXBox);

			var blurYSlider:HSlider=new HSlider();
			blurYSlider.minimum=1;
			blurYSlider.maximum=20;
			blurYSlider.value=componentEffect.shadow.blurY;
			blurYSlider.snapInterval=.5;
			blurYSlider.setStyle("labelOffset", 3);
			blurYSlider.labels=["0", "20"];
			blurYSlider.addEventListener(SliderEvent.CHANGE, changeShadowblurY);
			var blurYLabel:Label=new Label();
			blurYLabel.text="Blur Y:";
			blurYLabel.width=90;
			var blurYBox:HBox=new HBox();
			blurYBox.addChild(blurYLabel);
			blurYBox.addChild(blurYSlider);
			firstRow.addChild(blurYBox);

			var highlightAlphaSlider:HSlider=new HSlider();
			highlightAlphaSlider.minimum=0;
			highlightAlphaSlider.maximum=1;
			highlightAlphaSlider.value=componentEffect.shadow.alpha;
			highlightAlphaSlider.snapInterval=.01;
			highlightAlphaSlider.setStyle("labelOffset", 3);
			highlightAlphaSlider.labels=["0", "1"];
			highlightAlphaSlider.addEventListener(SliderEvent.CHANGE, changeShadowHighlightAlpha);
			var highlightAlphaLabel:Label=new Label();
			highlightAlphaLabel.text="Alpha:";
			highlightAlphaLabel.width=60;
			var highlightAlphaBox:HBox=new HBox();
			highlightAlphaBox.addChild(highlightAlphaLabel);
			highlightAlphaBox.addChild(highlightAlphaSlider);
			secondRow.addChild(highlightAlphaBox);

			var strengthSlider:HSlider=new HSlider();
			strengthSlider.minimum=0;
			strengthSlider.maximum=10;
			strengthSlider.value=componentEffect.shadow.strength;
			strengthSlider.snapInterval=.01;
			strengthSlider.setStyle("labelOffset", 3);
			strengthSlider.labels=["0", "10"];
			strengthSlider.addEventListener(SliderEvent.CHANGE, changeShadowStrength);
			var strengthLabel:Label=new Label();
			strengthLabel.text="Strength:";
			strengthLabel.width=60;
			var strengthBox:HBox=new HBox();
			strengthBox.addChild(strengthLabel);
			strengthBox.addChild(strengthSlider);
			secondRow.addChild(strengthBox);

			var qualitySlider:HSlider=new HSlider();
			qualitySlider.minimum=0;
			qualitySlider.maximum=10;
			qualitySlider.value=componentEffect.shadow.quality;
			qualitySlider.snapInterval=.01;
			qualitySlider.setStyle("labelOffset", 3);
			qualitySlider.labels=["0", "10"];
			qualitySlider.addEventListener(SliderEvent.CHANGE, changeShadowQuality);
			var qualityLabel:Label=new Label();
			qualityLabel.text="Quality:";
			qualityLabel.width=60;
			var qualityBox:HBox=new HBox();
			qualityBox.addChild(qualityLabel);
			qualityBox.addChild(qualitySlider);
			secondRow.addChild(qualityBox);

			var innerCheckBox:CheckBox=new CheckBox();
			innerCheckBox.selected=componentEffect.shadow.inner;
			innerCheckBox.addEventListener(MouseEvent.CLICK, changeShadowInner);
			var innerLabel:Label=new Label();
			innerLabel.text="Inner:";
			innerLabel.width=60;
			var innerBox:HBox=new HBox();
			innerBox.addChild(innerLabel);
			innerBox.addChild(innerCheckBox);
			secondRow.addChild(innerBox);

			var knockoutCheckBox:CheckBox=new CheckBox();
			knockoutCheckBox.selected=componentEffect.shadow.knockout;
			knockoutCheckBox.addEventListener(MouseEvent.CLICK, changeShadowKnockout);
			var knockoutLabel:Label=new Label();
			knockoutLabel.text="Knockout:";
			knockoutLabel.width=60;
			var knockoutBox:HBox=new HBox();
			knockoutBox.addChild(knockoutLabel);
			knockoutBox.addChild(knockoutCheckBox);
			secondRow.addChild(knockoutBox);

		}

		private function changeShadowKnockout(evt:MouseEvent):void
		{
			componentEffect.shadow.knockout=CheckBox(evt.target).selected;
			drawPreview();
		}

		private function changeShadowInner(evt:MouseEvent):void
		{
			componentEffect.shadow.inner=CheckBox(evt.target).selected;
			drawPreview();
		}

		private function changeShadowQuality(evt:SliderEvent):void
		{
			componentEffect.shadow.quality=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeShadowStrength(evt:SliderEvent):void
		{
			componentEffect.shadow.strength=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeShadowblurY(evt:SliderEvent):void
		{
			componentEffect.shadow.blurY=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeShadowblurX(evt:SliderEvent):void
		{
			componentEffect.shadow.blurX=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeShadowShadowAlpha(evt:SliderEvent):void
		{
			componentEffect.shadow.alpha=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeShadowShadowColor(evt:ColorPickerEvent):void
		{
			componentEffect.shadow.color=ColorPicker(evt.target).selectedColor;
			drawPreview();
		}

		private function changeShadowHighlightAlpha(evt:SliderEvent):void
		{
			componentEffect.shadow.alpha=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeShadowHighlightColor(evt:ColorPickerEvent):void
		{
			componentEffect.shadow.color=ColorPicker(evt.target).selectedColor;
			drawPreview();
		}

		private function changeShadowAngle(evt:SliderEvent):void
		{
			componentEffect.shadow.angle=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeShadowDistance(evt:SliderEvent):void
		{
			componentEffect.shadow.distance=HSlider(evt.target).value;
			drawPreview();
		}

//++++++++++++++++++++++++++++++++Glow Effect++++++++++++++++++++++++++++++++++++++++		
		/**
		 * Glow button Event
		 * */
		private function glowEvent():void
		{
			firstRow.removeAllChildren();
			secondRow.removeAllChildren();
			drawPreview();
			initGlowPropBox();
		}


		/**
		 * Initialize shadow Property Box
		 * */


		private function initGlowPropBox():void
		{
			var glovColorPicker:ColorPicker=new ColorPicker();
			glovColorPicker.selectedColor=componentEffect.glow.color;
			glovColorPicker.addEventListener(ColorPickerEvent.CHANGE, changeGlovColor);
			var glovLabel:Label=new Label();
			glovLabel.text="Color:";
			glovLabel.width=90;
			var glovBox:HBox=new HBox();
			glovBox.addChild(glovLabel);
			glovBox.addChild(glovColorPicker);
			firstRow.addChild(glovBox);

			var glovAlphaSlider:HSlider=new HSlider();
			glovAlphaSlider.minimum=0;
			glovAlphaSlider.maximum=1;
			glovAlphaSlider.value=componentEffect.glow.alpha;
			glovAlphaSlider.snapInterval=.01;
			glovAlphaSlider.setStyle("labelOffset", 3);
			glovAlphaSlider.labels=["0", "1"];
			glovAlphaSlider.addEventListener(SliderEvent.CHANGE, changeGlovAlpha);
			var glovAlphaLabel:Label=new Label();
			glovAlphaLabel.text="Alpha:";
			glovAlphaLabel.width=90;
			var glovAlphaBox:HBox=new HBox();
			glovAlphaBox.addChild(glovAlphaLabel);
			glovAlphaBox.addChild(glovAlphaSlider);
			firstRow.addChild(glovAlphaBox);

			var glovblurXSlider:HSlider=new HSlider();
			glovblurXSlider.minimum=1;
			glovblurXSlider.maximum=20;
			glovblurXSlider.value=componentEffect.glow.blurX;
			glovblurXSlider.snapInterval=.5;
			glovblurXSlider.setStyle("labelOffset", 3);
			glovblurXSlider.labels=["0", "20"];
			glovblurXSlider.addEventListener(SliderEvent.CHANGE, changeGlovblurX);
			var glovblurXLabel:Label=new Label();
			glovblurXLabel.text="Blur X:";
			glovblurXLabel.width=90;
			var glovblurXBox:HBox=new HBox();
			glovblurXBox.addChild(glovblurXLabel);
			glovblurXBox.addChild(glovblurXSlider);
			firstRow.addChild(glovblurXBox);

			var glovblurYSlider:HSlider=new HSlider();
			glovblurYSlider.minimum=1;
			glovblurYSlider.maximum=20;
			glovblurYSlider.value=componentEffect.glow.blurY;
			glovblurYSlider.snapInterval=.5;
			glovblurYSlider.setStyle("labelOffset", 3);
			glovblurYSlider.labels=["0", "20"];
			glovblurYSlider.addEventListener(SliderEvent.CHANGE, changeGlovblurY);
			var glovblurYLabel:Label=new Label();
			glovblurYLabel.text="Blur Y:";
			glovblurYLabel.width=90;
			var glovblurYBox:HBox=new HBox();
			glovblurYBox.addChild(glovblurYLabel);
			glovblurYBox.addChild(glovblurYSlider);
			firstRow.addChild(glovblurYBox);

			var glovstrengthSlider:HSlider=new HSlider();
			glovstrengthSlider.minimum=0;
			glovstrengthSlider.maximum=10;
			glovstrengthSlider.value=componentEffect.glow.strength;
			glovstrengthSlider.snapInterval=.01;
			glovstrengthSlider.setStyle("labelOffset", 3);
			glovstrengthSlider.labels=["0", "10"];
			glovstrengthSlider.addEventListener(SliderEvent.CHANGE, changeGlovStrength);
			var glovstrengthLabel:Label=new Label();
			glovstrengthLabel.text="Strength:";
			glovstrengthLabel.width=90;
			var glovstrengthBox:HBox=new HBox();
			glovstrengthBox.addChild(glovstrengthLabel);
			glovstrengthBox.addChild(glovstrengthSlider);
			firstRow.addChild(glovstrengthBox);

			var glovinnerCheckBox:CheckBox=new CheckBox();
			glovinnerCheckBox.selected=componentEffect.glow.inner;
			glovinnerCheckBox.addEventListener(MouseEvent.CLICK, changeGlovInner);
			var glovinnerLabel:Label=new Label();
			glovinnerLabel.text="Inner:";
			glovinnerLabel.width=90;
			var glovinnerBox:HBox=new HBox();
			glovinnerBox.addChild(glovinnerLabel);
			glovinnerBox.addChild(glovinnerCheckBox);
			secondRow.addChild(glovinnerBox);

			var glovknockoutCheckBox:CheckBox=new CheckBox();
			glovknockoutCheckBox.selected=componentEffect.glow.knockout;
			glovknockoutCheckBox.addEventListener(MouseEvent.CLICK, changeGlovKnockout);
			var glovknockoutLabel:Label=new Label();
			glovknockoutLabel.text="Knockout:";
			glovknockoutLabel.width=90;
			var glovknockoutBox:HBox=new HBox();
			glovknockoutBox.addChild(glovknockoutLabel);
			glovknockoutBox.addChild(glovknockoutCheckBox);
			secondRow.addChild(glovknockoutBox);

		}

		private function changeGlovKnockout(evt:MouseEvent):void
		{
			componentEffect.glow.knockout=CheckBox(evt.target).selected;
			drawPreview();
		}

		private function changeGlovInner(evt:MouseEvent):void
		{
			componentEffect.glow.inner=CheckBox(evt.target).selected;
			drawPreview();
		}

		private function changeGlovQuality(evt:SliderEvent):void
		{
			componentEffect.glow.quality=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeGlovStrength(evt:SliderEvent):void
		{
			componentEffect.glow.strength=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeGlovblurX(evt:SliderEvent):void
		{
			componentEffect.glow.blurX=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeGlovblurY(evt:SliderEvent):void
		{
			componentEffect.glow.blurY=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeGlovAlpha(evt:SliderEvent):void
		{
			componentEffect.glow.alpha=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeGlovColor(evt:ColorPickerEvent):void
		{
			componentEffect.glow.color=ColorPicker(evt.target).selectedColor;
			drawPreview();
		}


//++++++++++++++++++++++++++++++++Blur Effect++++++++++++++++++++++++++++++++++++++++		
		/**
		 * Glow button Event
		 * */
		private function blurEvent():void
		{
			firstRow.removeAllChildren();
			secondRow.removeAllChildren();
			drawPreview();
			initBlurPropBox();
		}


		/**
		 * Initialize shadow Property Box
		 * */


		private function initBlurPropBox():void
		{
			var blurXSlider:HSlider=new HSlider();
			blurXSlider.minimum=1;
			blurXSlider.maximum=20;
			blurXSlider.value=componentEffect.blur.blurX;
			blurXSlider.snapInterval=.5;
			blurXSlider.setStyle("labelOffset", 3);
			blurXSlider.labels=["0", "20"];
			blurXSlider.addEventListener(SliderEvent.CHANGE, changeBlurblurX);
			var blurXLabel:Label=new Label();
			blurXLabel.text="Blur X:";
			blurXLabel.width=90;
			var blurXBox:HBox=new HBox();
			blurXBox.addChild(blurXLabel);
			blurXBox.addChild(blurXSlider);
			firstRow.addChild(blurXBox);

			var blurYSlider:HSlider=new HSlider();
			blurYSlider.minimum=1;
			blurYSlider.maximum=20;
			blurYSlider.value=componentEffect.blur.blurY;
			blurYSlider.snapInterval=.5;
			blurYSlider.setStyle("labelOffset", 3);
			blurYSlider.labels=["0", "20"];
			blurYSlider.addEventListener(SliderEvent.CHANGE, changeBlurblurY);
			var blurYLabel:Label=new Label();
			blurYLabel.text="Blur Y:";
			blurYLabel.width=90;
			var blurYBox:HBox=new HBox();
			blurYBox.addChild(blurYLabel);
			blurYBox.addChild(blurYSlider);
			firstRow.addChild(blurYBox);

			var blurqualitySlider:HSlider=new HSlider();
			blurqualitySlider.minimum=0;
			blurqualitySlider.maximum=10;
			blurqualitySlider.value=componentEffect.blur.quality;
			blurqualitySlider.snapInterval=.01;
			blurqualitySlider.setStyle("labelOffset", 3);
			blurqualitySlider.labels=["0", "10"];
			blurqualitySlider.addEventListener(SliderEvent.CHANGE, changeblurBlurQuality);
			var blurqualityLabel:Label=new Label();
			blurqualityLabel.text="Quality:";
			blurqualityLabel.width=90;
			var blurqualityBox:HBox=new HBox();
			blurqualityBox.addChild(blurqualityLabel);
			blurqualityBox.addChild(blurqualitySlider);
			firstRow.addChild(blurqualityBox);


		}

		private function changeBlurblurX(evt:SliderEvent):void
		{
			componentEffect.blur.blurX=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeBlurblurY(evt:SliderEvent):void
		{
			componentEffect.blur.blurY=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeblurBlurQuality(evt:SliderEvent):void
		{
			componentEffect.blur.quality=HSlider(evt.target).value;
			drawPreview();
		}




//++++++++++++++++++++++++++++++++Extrude Effect++++++++++++++++++++++++++++++++++++++++		
		/**
		 * Extrude Button Event
		 * */
		private function extrudeEvent():void
		{
			firstRow.removeAllChildren();
			secondRow.removeAllChildren();
			initExtrudePropBox();
			drawPreview();
		}


/* 		private function createCenter():void
		{
			center=new Button();
			center.width=15;
			center.height=15;
			center.setStyle("cornerRadius", 10);
			center.addEventListener(MouseEvent.MOUSE_DOWN, startDragProjectionCenter);
			center.addEventListener(MouseEvent.MOUSE_UP, stopDragProjectionCenter);
			center.addEventListener(MouseEvent.MOUSE_MOVE, doDragProjectionCenter);
		}

		private function startDragProjectionCenter(e:Event):void
		{
			center.startDrag();
			mouseDown=true;
		}

		private function doDragProjectionCenter(e:MouseEvent):void
		{

			if (Button(e.target).x < 0)
			{
				center.x=0;
				stopDrag();
			}
			if (Button(e.target).y < 0)
			{
				center.y=0;
				stopDrag();
			}
			if (Button(e.target).x > previewBox.width - center.width)
			{
				center.x=previewBox.width - center.width;
				stopDrag();
			}
			if (Button(e.target).y > previewBox.height - center.height)
			{
				center.y=previewBox.height - center.height;
				stopDrag();
			}
			if (mouseDown)
			{
				previewBox.transform.perspectiveProjection.projectionCenter=new Point(center.x, center.y);
			}
		}

		private function stopDragProjectionCenter(e:Event):void
		{
			center.stopDrag();
			previewBox.transform.perspectiveProjection.projectionCenter=new Point(center.x, center.y);
			mouseDown=false;

		}
 */
		/**
		 * Initialize Properties Box of Extrude efect
		 * */
		private function initExtrudePropBox():void
		{
			UIComponent(source.parent).transform.perspectiveProjection = new PerspectiveProjection();
			var extrudeLayerSlider:HSlider=new HSlider();
			extrudeLayerSlider.minimum=1;
			extrudeLayerSlider.maximum=50;
			extrudeLayerSlider.value=componentEffect.extrude.layers;
			extrudeLayerSlider.snapInterval=1;
			extrudeLayerSlider.setStyle("labelOffset", 3);
			extrudeLayerSlider.labels=["1", "50"];
			extrudeLayerSlider.addEventListener(SliderEvent.CHANGE, changeextrudeLayer);
			var extrudeLayerLabel:Label=new Label();
			extrudeLayerLabel.text="Extrude Layer:";
			extrudeLayerLabel.width=90;
			var extrudeLayerBox:HBox=new HBox();
			extrudeLayerBox.addChild(extrudeLayerLabel);
			extrudeLayerBox.addChild(extrudeLayerSlider);
			firstRow.addChild(extrudeLayerBox);

			var extrudeFocalLenghtSlider:HSlider=new HSlider();
			extrudeFocalLenghtSlider.minimum=1;
			extrudeFocalLenghtSlider.maximum=500;
			extrudeFocalLenghtSlider.value=componentEffect.extrude.focal;
			extrudeFocalLenghtSlider.snapInterval=1;
			extrudeFocalLenghtSlider.setStyle("labelOffset", 3);
			extrudeFocalLenghtSlider.labels=["1", "50"];
			extrudeFocalLenghtSlider.addEventListener(SliderEvent.CHANGE, changeExtrudeFocalLenght);
			var extrudeFocalLenghtLabel:Label=new Label();
			extrudeFocalLenghtLabel.text="Extrude Focal Lenght:";
			extrudeFocalLenghtLabel.width=90;
			var extrudeFocalLenghtBox:HBox=new HBox();
			extrudeFocalLenghtBox.addChild(extrudeFocalLenghtLabel);
			extrudeFocalLenghtBox.addChild(extrudeFocalLenghtSlider);
			firstRow.addChild(extrudeFocalLenghtBox);
			//---------
			var extrudeYSlider:HSlider=new HSlider();
			extrudeYSlider.minimum=1;
			extrudeYSlider.maximum=50;
			extrudeYSlider.value=componentEffect.extrude.layers;
			extrudeYSlider.snapInterval=1;
			extrudeYSlider.setStyle("labelOffset", 3);
			extrudeYSlider.labels=["1", "50"];
			extrudeYSlider.addEventListener(SliderEvent.CHANGE, changeYextrude);
			var extrudeYLabel:Label=new Label();
			extrudeYLabel.text="Extrude Y:";
			extrudeYLabel.width=90;
			var extrudeYBox:HBox=new HBox();
			extrudeYBox.addChild(extrudeYLabel);
			extrudeYBox.addChild(extrudeYSlider);
			firstRow.addChild(extrudeYBox);

			var extrudeXSlider:HSlider=new HSlider();
			extrudeXSlider.minimum=1;
			extrudeXSlider.maximum=500;
			extrudeXSlider.value=componentEffect.extrude.focal;
			extrudeXSlider.snapInterval=1;
			extrudeXSlider.setStyle("labelOffset", 3);
			extrudeXSlider.labels=["1", "50"];
			extrudeXSlider.addEventListener(SliderEvent.CHANGE, changeXextrude);
			var extrudeXLabel:Label=new Label();
			extrudeXLabel.text="Extrude X:";
			extrudeXLabel.width=90;
			var extrudeXBox:HBox=new HBox();
			extrudeXBox.addChild(extrudeXLabel);
			extrudeXBox.addChild(extrudeXSlider);
			firstRow.addChild(extrudeXBox);


		}

		private function changeExtrudeFocalLenght(evt:SliderEvent):void
		{
			UIComponent(source.parent).transform.perspectiveProjection.focalLength=HSlider(evt.target).value;
			componentEffect.extrude.focal=HSlider(evt.target).value;
			drawPreview();
		}

		private function changeextrudeLayer(evt:SliderEvent):void
		{
			extrudeLayer=HSlider(evt.target).value;
			componentEffect.extrude.layers=HSlider(evt.target).value;
			drawPreview();
		}
		private function changeXextrude(evt:SliderEvent):void
		{
			UIComponent(source.parent).transform.perspectiveProjection.projectionCenter=new Point(HSlider(evt.target).value, componentEffect.extrude.projectionPoint.y);
			componentEffect.extrude.projectionPoint.x=HSlider(evt.target).value;
			drawPreview();
		}
		private function changeYextrude(evt:SliderEvent):void
		{
			UIComponent(source.parent).transform.perspectiveProjection.projectionCenter=new Point(componentEffect.extrude.projectionPoint.x,HSlider(evt.target).value);
			componentEffect.extrude.projectionPoint.y=HSlider(evt.target).value;
			drawPreview();
		}




		private function makeExtrude(h:Number, w:Number):void
		{
			var bitmmp:Bitmap;
			for (var i:uint=0; i < componentEffect.extrude.layers; i++)
			{
				bitmmp=new Bitmap(source.bitmapData);
				bitmmp.height=h;
				bitmmp.width=w;
				getField(i, bitmmp);
				UIComponent(source.parent).addChildAt(bitmmp, 0);
			}
		}

	
		private function getField(index:uint, bitmp:Bitmap):void
		{
			// depth is based on index position
			bitmp.z=index * 5;
			// for top field, add slight glow
			bitmp.filters=filterss;
		}

//++++++++++++++++++++++++++++++++++++Distress Efect+++++++++++++++++++++++++++++++

		private function distressEvent():void
		{
			firstRow.removeAllChildren();
			secondRow.removeAllChildren();
			drawPreview();
			initDistressPropBox();
		}



		/**
		 * Initialize Properties Box of Distress efect
		 * */
		private function initDistressPropBox():void
		{


			var distressNSlider:HSlider=new HSlider();
			distressNSlider.minimum=0;
			distressNSlider.maximum=50;
			distressNSlider.value=componentEffect.distress.distressN;
			distressNSlider.snapInterval=1;
			distressNSlider.setStyle("labelOffset", 3);
			distressNSlider.labels=["0", "50"];
			distressNSlider.addEventListener(SliderEvent.CHANGE, changedistressN);
			var distressNLabel:Label=new Label();
			distressNLabel.text="Distress:";
			distressNLabel.width=90;
			var distressNBox:HBox=new HBox();
			distressNBox.addChild(distressNLabel);
			distressNBox.addChild(distressNSlider);
			firstRow.addChild(distressNBox);

		}

		private function changedistressN(evt:SliderEvent):void
		{
			componentEffect.distress.distressN=HSlider(evt.target).value;
			drawPreview();
		}
		
		private function disposeDistress(bitmapData:BitmapData):void
		{
			var initBitmap:BitmapData=new BitmapData(bitmapData.width, bitmapData.height, true, 0x00000000);
			initBitmap.draw(cloneSourceBD);
			// copy data into original bitmap data
			bitmapData.copyPixels(initBitmap, bitmapData.rect, new Point());
		}

		public function getApplyButton():Button
		{
			return buttonApply;
		}

		public function getCancelButton():Button
		{
			return buttonCancel;
		}

		/* public function setDStyle(style:DStyle):void
		   {
		   this.dstyle=style;
		 } */

		public function getPreview():Sprite
		{
			return Sprite(preview.getChildAt(0));
		}
	}
}