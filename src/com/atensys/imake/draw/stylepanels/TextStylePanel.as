package com.atensys.imake.draw.stylepanels
{
	import com.atensys.imake.draw.component.TextUIComponent;
	import com.atensys.imake.draw.effect.EffectPopup;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.TextStyle;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextFormat;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.containers.TitleWindow;
	import mx.controls.Button;
	import mx.controls.ColorPicker;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.controls.List;
	import mx.controls.TextArea;
	import mx.controls.ToggleButtonBar;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.ColorPickerEvent;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	import mx.events.ListEvent;
	use namespace mx_internal;


	public class TextStylePanel extends HBox implements DStylePanel
	{
		private var dstyle:TextStyle;

		private var textArea:TextArea;

		public var previousTextFormat:TextFormat = null;

		private var textComponent:TextUIComponent;

		private var fontFamilyCombo:ComboBox;

		private var fontSizeCombo:ComboBox;

		private var boldButton:Button;

		private var italicButton:Button;

		private var underlineButton:Button;

		private var colorPicker:ColorPicker;

		private var alignButtons:ToggleButtonBar;

		private var bulletButton:Button;
		private var fontsFamilyCombo:FontComboBox;

		public var textFormatChanged:Boolean = false;

		//------------Title Window
		public var efectWindow:TitleWindow;

		public var popup:EffectPopup;

		private var lastCaretIndex:int = -1;

		private var invalidateToolBarFlag:Boolean = false;

		private var firstTime:Boolean = true;

		private var fontFamilyArray:ArrayCollection = new ArrayCollection();

		private var tempObj:Object = {};

		private var fontSizeArray:Array = new Array("8", "9", "10", "12", "14", "16", "20", "22", "24", "32", "48", "72");
		;

		[Bindable]
		[Embed(source="assets/icon_style_bold.png")]
		private var bold:Class;

		[Bindable]
		[Embed(source="assets/icon_style_italic.png")]
		private var italic:Class;

		[Bindable]
		[Embed(source="assets/icon_style_underline.png")]
		private var underline:Class;

		[Bindable]
		[Embed(source="assets/icon_bullet.png")]
		private var bulet:Class;

		[Bindable]
		[Embed(source="assets/icon_align_left.png")]
		private var align_left:Class;

		[Bindable]
		[Embed(source="assets/icon_align_center.png")]
		private var align_center:Class;

		[Bindable]
		[Embed(source="assets/icon_align_right.png")]
		private var align_right:Class;

		[Bindable]
		[Embed(source="assets/icon_align_justify.png")]
		private var align_justify:Class;



		[Bindable]
		private var togle:ArrayCollection = new ArrayCollection([{ icon: align_left, action: "left" }, { icon: align_center, action: "center" }, { icon: align_right, action: "right" }, { icon: align_justify, action: "justify" }]);

		public function TextStylePanel()
		{
			super();
			initStylePanel();
			setEnablePanel(false);
		}

		public function setDstyle(style:TextStyle):void
		{
			this.dstyle = style;
		}

		public function setTextarea(textArea:TextArea):void
		{
			this.textArea = textArea;
		}

		private function loadFonts():void
		{
			fontFamilyArray.source = Font.enumerateFonts(false);
			fontFamilyArray.filterFunction = deDupe;
			fontFamilyArray.refresh();
		}

		private function deDupe(item:Object):Boolean
		{
			var retVal:Boolean = false;
			if (!tempObj.hasOwnProperty(item.fontName))
			{
				tempObj[item.fontName] = item;
				retVal = true;
			}
			return retVal;
		}

		private function removeDuplicates(arr:Array):Array
		{
			var currentValue:String = "";
			var tempArray:Array = new Array();
			arr.sort(Array.CASEINSENSITIVE);
			arr.forEach(function(item:*, index:uint, array:Array):void
				{
					if (currentValue != item)
					{
						tempArray.push(item);
						currentValue = item;
					}
				});
			return tempArray.sort(Array.CASEINSENSITIVE);
		}

		public function initStylePanel():void
		{
			fontsFamilyCombo = new FontComboBox();
			fontSizeCombo = new ComboBox();
			boldButton = new Button();
			italicButton = new Button();
			underlineButton = new Button();
			colorPicker = new ColorPicker();
			alignButtons = new ToggleButtonBar();
			bulletButton = new Button();
			fontsFamilyCombo.fontPopup.fontlist.addEventListener(ListEvent.CHANGE, fontSelected);
			
			var fontLabel:Label = new Label();
			fontLabel.text = "Font Family:";
			fontSizeCombo.dataProvider = fontSizeArray;
			fontSizeCombo.editable = true;
			fontSizeCombo.addEventListener(Event.CLOSE, sizeSelected);
			fontSizeCombo.addEventListener(FlexEvent.ENTER, sizeSelectedEn);
			var fontsizeLabel:Label = new Label();
			fontsizeLabel.text = "Font Size:";
			var textFormatLabel:Label = new Label();
			textFormatLabel.text = "Text Formatting:";
			boldButton.setStyle("icon", bold);
			boldButton.width = 20;
			boldButton.toggle = true;
			boldButton.addEventListener(MouseEvent.CLICK, boldSelected);

			italicButton.setStyle("icon", italic);
			italicButton.width = 20;
			italicButton.toggle = true;
			italicButton.addEventListener(MouseEvent.CLICK, italicSelected);

			underlineButton.setStyle("icon", underline);
			underlineButton.width = 20;
			underlineButton.toggle = true;
			underlineButton.addEventListener(MouseEvent.CLICK, underlineSelected);

			var textColorLabel:Label = new Label();
			textColorLabel.text = "Color:";
			colorPicker.width = 22;
			colorPicker.height = 22;
			colorPicker.addEventListener(ColorPickerEvent.CHANGE, colorSelected);
			alignButtons.setStyle("buttonWidth", 20);
			alignButtons.dataProvider = togle;
			alignButtons.addEventListener(ItemClickEvent.ITEM_CLICK, alignSelected);

			var textAlignLabel:Label = new Label();
			textAlignLabel.text = "Align :";

			var textBuletLabel:Label = new Label();
			textBuletLabel.text = "Bulet :";

			bulletButton.setStyle("icon", bulet);
			bulletButton.width = 20;
			bulletButton.toggle = true;
			bulletButton.addEventListener(MouseEvent.CLICK, bulletSelected);

			addChild(fontLabel);
			addChild(fontsFamilyCombo);
			addChild(fontsizeLabel);
			addChild(fontSizeCombo);
			addChild(textFormatLabel);
			addChild(boldButton);
			addChild(italicButton);
			addChild(underlineButton);
			addChild(textColorLabel);
			addChild(colorPicker);
			addChild(textAlignLabel);
			addChild(alignButtons);
			addChild(textBuletLabel);
			addChild(bulletButton);
		}

		public function setEnablePanel(enable:Boolean):void
		{
			fontsFamilyCombo.enabled = enable;
			fontSizeCombo.enabled = enable;
			boldButton.enabled = enable;
			italicButton.enabled = enable;
			underlineButton.enabled = enable;
			colorPicker.enabled = enable;
			alignButtons.enabled = enable;
			bulletButton.enabled = enable;
		}

		public function setfontFamilyArray(ff:ArrayCollection):void
		{
			fontFamilyArray = ff;
		}

		public function setfontSizeArray(ff:Array):void
		{
			fontSizeArray = ff;
		}

		public function fontSelected(e:ListEvent):void
		{
			fontsFamilyCombo.flabel.text = List(e.target).selectedItem.fontName;
			fontsFamilyCombo.flabel.dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
			setTextStyles(this.textArea, "font");
		}

		public function fontSelectedEn(e:FlexEvent):void
		{
			setTextStyles(this.textArea, "font");
		}

		public function sizeSelected(e:Event):void
		{
			setTextStyles(this.textArea, "size");
		}

		public function sizeSelectedEn(e:FlexEvent):void
		{
			setTextStyles(this.textArea, "size");
		}

		public function boldSelected(e:MouseEvent):void
		{
			setTextStyles(this.textArea, "bold", e.currentTarget.selected);
		}

		public function italicSelected(e:MouseEvent):void
		{
			setTextStyles(this.textArea, "italic", e.currentTarget.selected);
		}

		public function underlineSelected(e:MouseEvent):void
		{
			setTextStyles(this.textArea, "underline", e.currentTarget.selected);
		}

		public function colorSelected(e:ColorPickerEvent):void
		{
			setTextStyles(this.textArea, "color");
		}

		public function alignSelected(e:ItemClickEvent):void
		{
			setTextStyles(this.textArea, "align", ToggleButtonBar(e.currentTarget).dataProvider.getItemAt(ToggleButtonBar(e.currentTarget).selectedIndex).action);
		}

		public function bulletSelected(e:MouseEvent):void
		{
			setTextStyles(this.textArea, "bullet", e.currentTarget.selected);
		}

		//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		public function setTextStyles(textArea:TextArea, type:String, value:Object = null):void
		{
			var tf:TextFormat = new TextFormat();

			var beginIndex:int = textArea.getTextField().selectionBeginIndex;
			var endIndex:int = textArea.getTextField().selectionEndIndex;

			if (beginIndex == endIndex)
			{
				tf = previousTextFormat;
			}
			else
				tf = new TextFormat();

			if (type == "bold" || type == "italic" || type == "underline")
			{
				tf[type] = value;
			}
			else if (type == "align" || type == "bullet")
			{
				if (beginIndex == endIndex)
				{
					tf = new TextFormat();
				}
				beginIndex = textArea.getTextField().getFirstCharInParagraph(beginIndex) - 1;
				beginIndex = Math.max(0, beginIndex);
				endIndex = textArea.getTextField().getFirstCharInParagraph(endIndex) + textArea.getTextField().getParagraphLength(endIndex) - 1;
				tf[type] = value;
				previousTextFormat[type] = value;
				if (!endIndex)
					textArea.getTextField().defaultTextFormat = tf;
			}
			else if (type == "font")
			{
				tf[type] = fontsFamilyCombo.flabel.text;
			}
			else if (type == "size")
			{
				var fontSize:uint = uint(fontSizeCombo.text);
				if (fontSize > 0)
					tf[type] = fontSize;
			}
			else if (type == "color")
			{
				tf[type] = uint(colorPicker.selectedColor);
			}

			textFormatChanged = true;

			if (beginIndex == endIndex)
			{
				previousTextFormat = tf;
			}
			else
			{
				textArea.getTextField().setTextFormat(tf, beginIndex, endIndex);
			}

			dispatchEvent(new Event("change"));

			textArea.invalidateDisplayList();
			textArea.validateDisplayList();

			callLater(textArea.setFocus);
		}

		/**
		 * Get text Style from textArea
		 * */
		public function getTextStyles(textArea:TextArea):void
		{
			if (!textArea)
				return;
			var tf:TextFormat;

			var beginIndex:int = textArea.getTextField().selectionBeginIndex;
			var endIndex:int = textArea.getTextField().selectionEndIndex;


			if (textFormatChanged)
				previousTextFormat = null;

			if (beginIndex == endIndex)
			{
				tf = textArea.getTextField().defaultTextFormat;
			}
			else
				tf = textArea.getTextField().getTextFormat(beginIndex, endIndex);

			if (!previousTextFormat || previousTextFormat.font != tf.font)
			{
				if(ArrayCollection(fontsFamilyCombo.fontPopup.fontlist.dataProvider).length!=0)
				setFontsComboSelection(fontsFamilyCombo, tf.font ? tf.font : "");
			}
			if (!previousTextFormat || previousTextFormat.size != tf.size)
				setComboSelection(fontSizeCombo, tf.size ? String(tf.size) : "");
			if (!previousTextFormat || previousTextFormat.color != tf.color)
				colorPicker.selectedColor = Number(tf.color);

			if (!previousTextFormat || previousTextFormat.bold != tf.bold)
				boldButton.selected = tf.bold;
			if (!previousTextFormat || previousTextFormat.italic != tf.italic)
				italicButton.selected = tf.italic;
			if (!previousTextFormat || previousTextFormat.underline != tf.underline)
				underlineButton.selected = tf.underline;

			if (!previousTextFormat || previousTextFormat.align != tf.align)
			{
				if (tf.align == "left")
					alignButtons.selectedIndex = 0;
				else if (tf.align == "center")
					alignButtons.selectedIndex = 1;
				else if (tf.align == "right")
					alignButtons.selectedIndex = 2;
				else if (tf.align == "justify")
					alignButtons.selectedIndex = 3;
			}
			if (!previousTextFormat || previousTextFormat.bullet != tf.bullet)
				bulletButton.selected = tf.bullet;

			if (textArea.getTextField().defaultTextFormat != tf)
				textArea.getTextField().defaultTextFormat = tf;
			previousTextFormat = tf;
			textFormatChanged = true;

			lastCaretIndex = textArea.getTextField().caretIndex;
			invalidateToolBarFlag = false;
		}

		public function setComboSelection(combo:ComboBox, val:String):void
		{
			var length:uint = combo.dataProvider.length;
			for (var i:uint = 0; i < length; i++)
			{
				if (combo.dataProvider.getItemAt(i).toLowerCase() == val.toLowerCase())
				{
					combo.selectedIndex = i;
					return;
				}
			}
			combo.selectedIndex = -1;
			combo.validateNow();
			combo.text = val;
		}

		public function setFontComboSelection(combo:ComboBox, val:String):void
		{
			var length:uint = combo.dataProvider.length;
			for (var i:uint = 0; i < length; i++)
			{
				if (combo.dataProvider.getItemAt(i).fontName.toLowerCase() == val.toLowerCase())
				{
					combo.selectedIndex = i;
					return;
				}
			}
			combo.selectedIndex = -1;
			combo.validateNow();
			combo.text = val;
		}
		public function setFontsComboSelection(combo:FontComboBox, val:String):void
		{
			combo.fontPopup.resetCategory();
			var length:uint = combo.fontPopup.fontlist.dataProvider.source.length;
			for (var i:uint = 0; i < length; i++)
			{
				if (combo.fontPopup.fontlist.dataProvider.getItemAt(i).fontName.toLowerCase() == val.toLowerCase())
				{
					combo.fontPopup.fontlist.selectedIndex = i;
					combo.flabel.text=val;
					combo.flabel.dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
					return;
				}
			}
			combo.fontPopup.fontlist.selectedIndex = -1;
			combo.flabel.text="";
			combo.validateNow();
		}

		/**
		 *  @private
		 *  This method is called when the user clicks on the textArea, drags
		 *  out of it and releases the mouse button outside the TextArea.
		 */ /* 		private function systemManager_mouseUpHandler(event:MouseEvent):void {
		   if (lastCaretIndex != this.textComponent.textArea.getTextField().caretIndex)
		   getTextStyles(this.textComponent.textArea);
		   systemManager.removeEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
		   }
		 */
		public function addColorEvent():void
		{
		}

		public function getController():UIComponent
		{
			return this;
		}

		public function updateStyle(style:DStyle):void
		{

		}
		
		public function dStyleChanged(event:Event):void{
			//setTextStyles(this.textArea, "color");
		}

	}
}