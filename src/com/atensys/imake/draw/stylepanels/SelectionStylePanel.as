package com.atensys.imake.draw.stylepanels
{
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.SelectionStyle;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.controls.CheckBox;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.controls.ToggleButtonBar;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	import mx.events.ListEvent;

	public class SelectionStylePanel extends HBox implements DStylePanel
	{
		private var dstyle:SelectionStyle;
		private var initialImage:Bitmap;

		private var modeButtons:ToggleButtonBar;
		private var diameter:ComboText;
		private var showBorder:CheckBox;
		private var colorBorder:ComboBox;
		private var selectionShape:ComboBox;

		[Bindable]
		[Embed(source="assets/btnNewSmall_dis.png")]
		private var nev:Class;
		[Bindable]
		[Embed(source="assets/btnAddSmall_dis.png")]
		private var add:Class;
		
		[Bindable]
		[Embed(source="assets/btnDelSmall_dis.png")]
		private var del:Class;
		
		[Bindable]
		[Embed(source="assets/icons/Rectangle.jpg")]
		private var rectangle:Class;

		[Bindable]
		[Embed(source="assets/icons/Ellipse.jpg")]
		private var ellipse:Class;

		[Bindable]
		[Embed(source="assets/icons/Lasso.jpg")]
		private var lasso:Class;

		[Bindable]
		private var mode:ArrayCollection=new ArrayCollection([{icon:nev,action: "new"}, {icon:add,action: "add"}, {icon:del,action: "rem"}]);

		[Bindable]
		private var caps:ArrayCollection=new ArrayCollection([{label: "Rectangle", icon: rectangle, data: SelectionStyle.RECTANGLE}, {label: "Circle", icon: ellipse, data: SelectionStyle.CIRCLE}, {label: "Ellipse", icon: ellipse, data: SelectionStyle.ELIPSE}, {label: "Lasso", icon: lasso, data: SelectionStyle.MOUSE}]);
		
		[Bindable]
		private var colors:ArrayCollection=new ArrayCollection(["Black", "White"]);


		public function SelectionStylePanel()
		{
			super();
			initStyleComponents();
			addEventListener(FlexEvent.UPDATE_COMPLETE, dStyleChanged);
		}

		private function initStyleComponents():void
		{
			modeButtons=new ToggleButtonBar();
			modeButtons.setStyle("buttonWidth", 20);
			modeButtons.dataProvider=mode;
			modeButtons.addEventListener(ItemClickEvent.ITEM_CLICK, modeSelected);

			var modeLabel:Label=new Label();
			modeLabel.text="Selection Mode :";
			addChild(modeLabel);
			addChild(modeButtons);

			//-------------diameter Box------------
			/* diameter=new ComboText();
			diameter.setStyle("verticalAlign", "middle");
			diameter.setLabel("Diameter:");
			diameter.setAllowTrackClick(true);
			diameter.setTickInterval(1);
			diameter.setSnapInterval(1);
			diameter.setSliderLabels(["0", "10"]);
			diameter.setSliderValues(0, 10);
			diameter.getText().text="1";
			diameter.getText().addEventListener(Event.CHANGE, dStyleChanged);
			addChild(diameter); */
			//---------Show Border
			showBorder=new CheckBox();
			showBorder.addEventListener(Event.CHANGE, dStyleChanged);
			showBorder.selected=true;
			var sb:Label=new Label();
			sb.text="Show Border:";
			addChild(sb);
			addChild(showBorder);
			//--------Color Border
			var borderColorLabel:Label=new Label();
			borderColorLabel.text="Border Color:";
			colorBorder=new ComboBox();
			colorBorder.dataProvider = colors;
			//colorBorder.width=22;
			//colorBorder.height=22;
			colorBorder.addEventListener(ListEvent.CHANGE, dStyleChanged);
			addChild(borderColorLabel);
			addChild(colorBorder);
			//-------Selection Shape
			var selectionLabel:Label=new Label();
			selectionLabel.text="Selection Shape:";
			selectionShape=new ComboBox();
			selectionShape.dataProvider=this.caps;
			selectionShape.setStyle("verticalAlign", "middle");
			selectionShape.addEventListener(Event.CHANGE, dStyleChanged);
			addChild(selectionLabel);
			addChild(selectionShape);


		}

		public function dStyleChanged(evt:Event):void
		{
			this.dstyle.color=(colorBorder.selectedLabel=="Black")?0x000000:0xFFFFFF;
//			this.dstyle.setBorderThickness(int(diameter.getText().text));
			this.dstyle.setType(selectionShape.selectedIndex);
			this.dstyle.setBorderVisible(showBorder.selected);
			Application.application.desktop.setDStyle(this.dstyle);
		}

		public function modeSelected(e:ItemClickEvent):void
		{
			this.dstyle.setMode(ToggleButtonBar(e.currentTarget).selectedIndex);
		}

		public function setDstyle(style:SelectionStyle):void
		{
			this.dstyle=style;
		}

		public function getController():UIComponent
		{
			return this;
		}

		public function updateStyle(style:DStyle):void
		{
		}

	}
}