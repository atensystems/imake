package com.atensys.imake.draw.stylepanels
{
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.managers.PopUpManager;


	public class FontComboBox extends HBox
	{
		private var _fontPopup:FontsPopup;

		[Bindable]
		[Embed(source="assets/combo.png")]
		private var selectBrushIcon:Class;

		private var _flabel:Label;

		private var chooseBrush:Button;
		private var pwith:uint=0;

		public function FontComboBox()
		{
			super();
			setStyle("horizontalGap", 0);
			var hbox:HBox=new HBox();
			hbox.setStyle("backgroundColor", "white");
			hbox.height=23;
			hbox.addEventListener(MouseEvent.CLICK, showFontsPopup);

			_fontPopup=new FontsPopup();

			_flabel=new Label();
			_flabel.width=100;
			_flabel.addEventListener(FlexEvent.DATA_CHANGE, changeFont);
			_flabel.setStyle("fontSize", 15);

			hbox.addChild(_flabel);

			addChild(hbox);
			chooseBrush=new Button();
			chooseBrush.setStyle("icon", selectBrushIcon);
			chooseBrush.setStyle("cornerRadius", 5);
			chooseBrush.width=23;
			chooseBrush.height=23;
			addChild(chooseBrush);
			chooseBrush.addEventListener(MouseEvent.CLICK, showFontsPopup);
		}

		private function changeFont(evt:FlexEvent):void
		{

			flabel.setStyle("fontFamily", Label(evt.target).text);
		}

		private function showFontsPopup(evt:MouseEvent):void
		{
			if (!_fontPopup.isactive)
			{
				_fontPopup.x=this.localToGlobal(new Point(0, 0)).x;
				_fontPopup.y=this.localToGlobal(new Point(0, 0)).y + this.height + 5;
				_fontPopup.width=250;
				_fontPopup.setStyle('borderStyle', 'solid');
				_fontPopup.setStyle('borderThickness', 3);
				_fontPopup.setStyle('cornerRadius', 5);
				_fontPopup.fontlist.addEventListener(ListEvent.CHANGE, hidePopup);
				PopUpManager.addPopUp(_fontPopup, this.parent, false);
				_fontPopup.isactive=true;
			}
			else
			{
				PopUpManager.removePopUp(_fontPopup);
				_fontPopup.isactive=false;
			}

		}

		public function hidePopup(evt:ListEvent):void
		{
			PopUpManager.removePopUp(_fontPopup);
			_fontPopup.isactive=false;
		}

		public function get fontPopup():FontsPopup
		{
			return this._fontPopup;
		}

		public function get flabel():Label
		{
			return this._flabel;
		}

	}
}