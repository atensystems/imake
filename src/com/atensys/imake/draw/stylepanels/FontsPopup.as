package com.atensys.imake.draw.stylepanels
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.controls.List;
	import mx.core.ClassFactory;
	import mx.events.ListEvent;
	import mx.managers.PopUpManager;

	public class FontsPopup extends VBox
	{
		private var _fontlist:List;

		private var categoriesCombo:ComboBox;

		private var fontFamilyArray:ArrayCollection=new ArrayCollection();
		private var fontFamilyArray1:ArrayCollection=new ArrayCollection();

		private var tempObj:Object={};

		private var _isactive:Boolean=false;

		private var loader:URLLoader=new URLLoader();

		private var request:URLRequest=new URLRequest("conf/FontCategory.xml");
		private var categories:XML;


		public function FontsPopup()
		{
			super();

			_fontlist=new List();
			fontFamilyArray.filterFunction=deDupeFontCategory;
			fontFamilyArray.refresh();
			var hbox:HBox=new HBox();
			hbox.setStyle("paddingBottom", 5);
			hbox.setStyle("paddingTop", 5);
			hbox.setStyle("paddingLeft", 5);
			hbox.setStyle("paddingRight", 5);
			var label:Label=new Label();
			label.text="Categories";
			hbox.addChild(label);
			categoriesCombo=new ComboBox();
			categoriesCombo.dataProvider=fontFamilyArray;
			categoriesCombo.itemRenderer=new ClassFactory(FontCategoryRenderer);
			categoriesCombo.labelField="fontCategory";
			categoriesCombo.addEventListener(ListEvent.CHANGE, setCategory);
			hbox.addChild(categoriesCombo);
			addChild(hbox);

			fontFamilyArray1.filterFunction=deDupeFontName;
			fontFamilyArray1.refresh();
			_fontlist.dataProvider=fontFamilyArray1;
			_fontlist.itemRenderer=new ClassFactory(FontListRenderer);
			_fontlist.setStyle("paddingBottom", 2);
			_fontlist.setStyle("paddingTop", 2);
			_fontlist.setStyle("paddingLeft", 2);
			_fontlist.setStyle("paddingRight", 2);
			addChild(_fontlist);
			_fontlist.percentHeight=100;
			_fontlist.percentWidth=100;
			loadFonts();
		}

		private function selectionChange(evt:ListEvent):void
		{
			PopUpManager.removePopUp(this);
		}


		public function get fontlist():List
		{
			return this._fontlist;
		}

		private function loadFonts():void
		{
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.load(request);
		}

		private function onComplete(event:Event):void
		{
			var loader:URLLoader=event.target as URLLoader;
			if (loader != null)
			{
				categories=new XML(loader.data);
				loadCategories();
			}
			else
			{
				trace("loader is not a URLLoader!");
			}
		}

		private function loadCategories():void
		{
			for each (var cat:XML in categories.category)
			{
				for each (var fon:XML in cat.font)
				{
					fontFamilyArray.addItem(new FontEx(fon.@name, "", "", cat.@name));
					fontFamilyArray1.addItem(new FontEx(fon.@name, "", "", cat.@name));

				}
			}
			categoriesCombo.dataProvider=fontFamilyArray;
			_fontlist.dataProvider=fontFamilyArray1;

		}

		private function setCategory(evt:ListEvent):void
		{
			fontFamilyArray1=new ArrayCollection();
			var fonts:XMLList=categories.category.(@name == ComboBox(evt.target).selectedLabel);
			for each (var fon:XML in fonts.font)
			{
				fontFamilyArray1.addItem(new FontEx(fon.@name, "", "", ""));
			}

			_fontlist.dataProvider=fontFamilyArray1;
		}

		public function resetCategory():void

		{
			fontFamilyArray1=new ArrayCollection();
			for each (var cat:XML in categories.category)
			{
				for each (var fon:XML in cat.font)
				{
					fontFamilyArray1.addItem(new FontEx(fon.@name, "", "", cat.@name));

				}
			}
			_fontlist.dataProvider=fontFamilyArray1;
		}

		private function deDupeFontName(item:Object):Boolean
		{
			var retVal:Boolean=false;
			if (!tempObj.hasOwnProperty(item.fontName))
			{
				tempObj[item.fontName]=item;
				retVal=true;
			}
			return retVal;
		}

		private function deDupeFontCategory(item:Object):Boolean
		{

			var retVal:Boolean=false;
			if (!tempObj.hasOwnProperty(item.fontCategory))
			{
				tempObj[item.fontCategory]=item;
				retVal=true;
			}
			return retVal;
		}

		private function removeDuplicates(arr:Array):Array
		{
			var currentValue:String="";
			var tempArray:Array=new Array();
			arr.sort(Array.CASEINSENSITIVE);
			arr.forEach(function(item:*, index:uint, array:Array):void
				{
					if (currentValue != item)
					{
						tempArray.push(item);
						currentValue=item;
					}
				});
			return tempArray.sort(Array.CASEINSENSITIVE);
		}

		public function set isactive(iss:Boolean):void
		{
			this._isactive=iss;
		}

		public function get isactive():Boolean
		{
			return this._isactive;
		}



	}
}