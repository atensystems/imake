package com.atensys.imake.draw.stylepanels
{
	import com.atensys.imake.draw.componentprovider.ImageComponentProvider;
	import com.atensys.imake.draw.effect.EffectPopup;
	import com.atensys.imake.draw.effect.ImageColorTransformPopup;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.ImageStyle;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;

	public class ImageStylePanel extends HBox implements DStylePanel
	{
		private var flipO:Button;
		private var flipV:Button;
		private var dstyle:ImageStyle;
		private var initialImage:Bitmap;
		private var imageColorButton:Button;
		private var imageEffectButton:Button;
		private var blackWhite:CheckBox;
		private var colorpopup:ImageColorTransformPopup;
		private var effectpopup:EffectPopup;
		private var lastt:ColorTransform;
		private var isColorPopUp:Boolean=false;

		[Bindable]
		[Embed(source="assets/resizeCursorH.gif")]
		private var flipHor:Class;

		[Bindable]
		[Embed(source="assets/resizeCursorV.gif")]
		private var flipVer:Class;


		public function ImageStylePanel()
		{
			super();
			initComponents();
		}

		private function initComponents():void
		{
			blackWhite=new CheckBox();
			blackWhite.addEventListener(Event.CHANGE, blackWhiteTransform);
			var blwh:Label=new Label();
			blwh.text="Black & White:";

			addChild(blwh);
			addChild(blackWhite);

			imageColorButton=new Button();
			imageColorButton.label="Color Transform";
			imageColorButton.addEventListener(MouseEvent.CLICK, openColorTransform);
			addChild(imageColorButton);
			initColorTransformPopup();

			}

		private function cancEvent(evt:MouseEvent):void
		{
			PopUpManager.removePopUp(effectpopup);
		}

		private function applyEvent(evt:MouseEvent):void
		{
			ImageComponentProvider(Application.application.desktop.currentComponentProvider()).setBitmapImage();
			PopUpManager.removePopUp(effectpopup);
		}

		private function openColorTransform(evt:MouseEvent):void
		{
			if (isColorPopUp)
			{
				PopUpManager.removePopUp(colorpopup);
				isColorPopUp=false;
			}
			else
			{
				isColorPopUp=true;
				setColorTransformPopup();
				PopUpManager.addPopUp(colorpopup, this.parent, false);
			}
		}
		
		private function setColorTransformPopup():void{
			
			var t:Transform=this.dstyle.imageBitmap.transform;
			this.dstyle.imgTransform=t;
			lastt=new ColorTransform();
			lastt=t.colorTransform;
			colorpopup.getAlfaMultiplier().value=t.colorTransform.alphaMultiplier;
			colorpopup.getBlueMultiplier().value=t.colorTransform.blueMultiplier;
			colorpopup.getRedMultiplier().value=t.colorTransform.redMultiplier;
			colorpopup.getGreenMultiplier().value=t.colorTransform.greenMultiplier;
			colorpopup.getAlfaOffset().value=t.colorTransform.alphaOffset;
			colorpopup.getBlueOffset().value=t.colorTransform.blueOffset;
			colorpopup.getRedOffset().value=t.colorTransform.redOffset;
			colorpopup.getGreenOffset().value=t.colorTransform.greenOffset;
			
		}

		private function initColorTransformPopup():void
		{
			colorpopup=new ImageColorTransformPopup();
			colorpopup.x=imageColorButton.localToGlobal(new Point(0, 0)).x - colorpopup.width;
			colorpopup.y=imageColorButton.localToGlobal(new Point(0, 0)).y + this.height + 5;
			colorpopup.setStyle('borderStyle', 'solid');
			colorpopup.setStyle('borderThickness', 3);
			colorpopup.setStyle('cornerRadius', 5);
			colorpopup.setStyle("paddingLeft", 10);
			colorpopup.setStyle("paddingRight", 10);
			colorpopup.setStyle("paddingTop", 10);
			colorpopup.setStyle("paddingBottom", 10);
			
			colorpopup.getOkButton().addEventListener(MouseEvent.CLICK, okEvent);
			colorpopup.getCancelButton().addEventListener(MouseEvent.CLICK, cancelEvent);
			colorpopup.getDefaultButton().addEventListener(MouseEvent.CLICK, defaultEvent);

			colorpopup.getAlfaMultiplier().addEventListener(Event.CHANGE, onColorChange);
			colorpopup.getBlueMultiplier().addEventListener(Event.CHANGE, onColorChange);
			colorpopup.getRedMultiplier().addEventListener(Event.CHANGE, onColorChange);
			colorpopup.getGreenMultiplier().addEventListener(Event.CHANGE, onColorChange);
			colorpopup.getAlfaOffset().addEventListener(Event.CHANGE, onColorChange);
			colorpopup.getBlueOffset().addEventListener(Event.CHANGE, onColorChange);
			colorpopup.getRedOffset().addEventListener(Event.CHANGE, onColorChange);
			colorpopup.getGreenOffset().addEventListener(Event.CHANGE, onColorChange);

		}

		private function defaultEvent(evt:MouseEvent):void
		{
			colorpopup.getBlueMultiplier().value=colorpopup.getRedMultiplier().value=colorpopup.getGreenMultiplier().value=colorpopup.getAlfaMultiplier().value=1;
			colorpopup.getBlueOffset().value=colorpopup.getRedOffset().value=colorpopup.getGreenOffset().value=colorpopup.getAlfaOffset().value=0;
			onColorChange(evt);
		}

		private function onColorChange(event:Event=null):void
		{
			this.dstyle.imageBitmap.transform.colorTransform=new ColorTransform(colorpopup.getRedMultiplier().value, colorpopup.getGreenMultiplier().value, colorpopup.getBlueMultiplier().value, colorpopup.getAlfaMultiplier().value, colorpopup.getRedOffset().value, colorpopup.getGreenOffset().value, colorpopup.getBlueOffset().value, colorpopup.getAlfaOffset().value);
		}

		private function cancelEvent(evt:MouseEvent):void
		{
			var dirtyImage:Bitmap=this.dstyle.imageBitmap;
			dirtyImage.transform.colorTransform=lastt;
			PopUpManager.removePopUp(colorpopup);
			isColorPopUp=false;
		}

		private function okEvent(evt:MouseEvent):void
		{
			PopUpManager.removePopUp(colorpopup);
			isColorPopUp=false;
		}

		private function blackWhiteTransform(evt:Event):void
		{
			/**
			 *
			 * 1 0 0 0 0   //First Row is for Red
			 * 0 1 0 0 0   //Second Row is For Green
			 * 0 0 1 0 0   //Third Row is for Blue
			 * 0 0 0 N 0   //Fourth Row is For Alpha
			 *
			 *   R G B A (Brightness Offset)
			 * R 1 0 0 0 0
			 * G 0 1 0 0 0
			 * B 0 0 1 0 0
			 * A 0 0 0 N 0
			 *
			 * So Inorder to get a Gray Scale, you need Equal parts of All 3 colors
			 * in the Matrix. so Divide 1/3(RGB) and you get .33. So you need .33 intensity
			 * of each color channel in the matrix.
			 *
			 *
			 */
			this.dstyle.blackWhite=CheckBox(evt.target).selected;
			var matrixArray:Array=[.33, .33, .33, 0, 0, .33, .33, .33, 0, 0, .33, .33, .33, 0, 0, 0, 0, 0, 1, 0];
			var normalmatrixArray:Array=[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
			var blackWhiteFilter:ColorMatrixFilter=new ColorMatrixFilter(CheckBox(evt.target).selected ? matrixArray : normalmatrixArray);

			var bitmap:Bitmap=this.dstyle.imageBitmap;
			var have:Boolean=false;
			var initial:Array=bitmap.filters;

			for (var i:int=0; i < initial.length; i++)
			{
				if (initial[i] is ColorMatrixFilter)
				{
					initial[i]=blackWhiteFilter;
					have=true;
				}
			}
			if (!have)
			{
				initial.push(blackWhiteFilter);
			}
			bitmap.filters=initial;
			this.dstyle.imageBitmap=bitmap;
		}


		public function setDstyle(style:ImageStyle):void
		{
			this.dstyle=style;

		}

		public function getController():UIComponent
		{
			return this;
		}
		public function getDStyle():void {
			
			blackWhite.selected=this.dstyle.blackWhite;
			setColorTransformPopup();
		}

		public function updateStyle(style:DStyle):void
		{
			this.dstyle = ImageStyle(style);
			getDStyle();
		}
		
		public function dStyleChanged(event:Event):void{
			
		}

	}
}