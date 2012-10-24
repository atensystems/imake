package com.atensys.imake.draw.ttip
{
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.component.ComponentResizeContainer;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.EraserLayer;
	import com.atensys.imake.draw.component.PencilStroke;
	import com.atensys.imake.draw.effect.EffectPopup;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.ButtonBar;
	import mx.core.Application;
	import mx.events.ItemClickEvent;
	import mx.managers.PopUpManager;

	public class ComponentToolTip extends HBox
	{

		private var btEffects:Button;
		private var btRotate:Button;
		private var btsMoveForwardBackward:ButtonBar;
		private var btsCopyCut:ButtonBar;
		private var btsFlipVertialHorizontal:ButtonBar;
		

		[Bindable]
		public var sourceComponent:ComponentResizeContainer;

		[Bindable]
		[Embed(source="assets/move_forward.png")]
		private var imgMoveForward:Class;

		[Bindable]
		[Embed(source="assets/move_backward.png")]
		private var imgMoveBackward:Class;

		[Bindable]
		[Embed(source="assets/copy_edit.png")]
		private var imgCopy:Class;

		[Bindable]
		[Embed(source="assets/delete_edit.png")]
		private var imgCut:Class;

		[Bindable]
		[Embed(source="assets/resizeCursorV.gif")]
		private var imgFlipVertical:Class;

		[Bindable]
		[Embed(source="assets/resizeCursorH.gif")]
		private var imgFlipHorizontal:Class;

		[Bindable]
		private var dpMoveForwardBackward:ArrayCollection=new ArrayCollection([{icon: imgMoveForward, action: "top"}, {icon: imgMoveBackward, action: "bottom"}]);

		[Bindable]
		private var dpCopyCut:ArrayCollection=new ArrayCollection([{icon: imgCopy, action: "copy"}, {icon: imgCut, action: "cut"}]);

		[Bindable]
		private var dpFlipVerticalHorizontal:ArrayCollection=new ArrayCollection([{icon: imgFlipVertical, action: "vertical"}, {icon: imgFlipHorizontal, action: "horizontal"}]);

		public function ComponentToolTip()
		{
			super();
			initButtons();
		}

		private function initButtons():void
		{
			btEffects=new Button();
			btRotate=new Button();
			btsMoveForwardBackward=new ButtonBar();
			btsCopyCut=new ButtonBar();
			btsFlipVertialHorizontal=new ButtonBar();

			btEffects.label="Effects";
			btEffects.addEventListener(MouseEvent.CLICK, showEffects);
			
			btRotate.label="R";
			btRotate.setStyle("buttonWidth", 10);
			btRotate.addEventListener(MouseEvent.CLICK, rotateComponent);
			btRotate.autoRepeat=true;
			btRotate.toggle=true;

			btsMoveForwardBackward.setStyle("buttonWidth", 20);
			btsMoveForwardBackward.dataProvider=dpMoveForwardBackward;
			btsMoveForwardBackward.addEventListener(ItemClickEvent.ITEM_CLICK, moveComponentTopBottom);

			btsCopyCut.setStyle("buttonWidth", 20);
			btsCopyCut.dataProvider=dpCopyCut;
			btsCopyCut.addEventListener(ItemClickEvent.ITEM_CLICK, copyCutComponent);

			btsFlipVertialHorizontal.setStyle("buttonWidth", 20);
			btsFlipVertialHorizontal.dataProvider=dpFlipVerticalHorizontal;
			btsFlipVertialHorizontal.addEventListener(ItemClickEvent.ITEM_CLICK, flipComponentVerticalHorizontal);

			addChild(btEffects);

			addChild(btsFlipVertialHorizontal);

			addChild(btsMoveForwardBackward);

			addChild(btsCopyCut);
			
			addChild(btRotate);

		}

		private function showEffects(event:MouseEvent):void
		{
			Application.application.desktop.getDrawable().dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			var popup:EffectPopup=new EffectPopup(sourceComponent.dComponent);
			PopUpManager.addPopUp(popup, this, false);
			PopUpManager.centerPopUp(popup);


		}
		private function rotateComponent(event:MouseEvent):void
		{
 			Util.rotate(this.sourceComponent.dComponent);
		}

		private function moveComponentTopBottom(event:ItemClickEvent):void
		{
			var action:String=event.item.action;
			if (action == "top")
			{
				Application.application.desktop.moveUpComponent(this.sourceComponent.dComponent);
			}
			if (action == "bottom")
			{
				Application.application.desktop.moveDownComponent(this.sourceComponent.dComponent);
			}

		}

		private function copyCutComponent(event:ItemClickEvent):void
		{
			var action:String=event.item.action;
			if (action == "cut")
			{
				Application.application.desktop.removeComponent(this.sourceComponent.dComponent);
				sourceComponent.setVisible(false);
			}
			if (action == "copy")
			{
				var clone:DComponent=this.sourceComponent.dComponent.clone();
				if (clone != null)
				{
					Application.application.desktop.registerComponent(clone);
					clone.getController().dispatchEvent(new Event("repaint"));
					Application.application.desktop.setFocusC(clone);
				}
			}
		}

		private function flipComponentVerticalHorizontal(event:ItemClickEvent):void
		{
			var action:String=event.item.action;

			var mx:Matrix=new Matrix(); //same as above
			var bmd:BitmapData=sourceComponent.dComponent.getSource().bitmapData.clone();
			mx.scale((action == "horizontal") ? -1 : 1, (action == "vertical") ? -1 : 1);
			mx.translate((action == "horizontal") ? bmd.width : 0, (action == "vertical") ? bmd.height : 0); //after the mirror all x-coordinates will be negative, reposition the image by adding the width to every x-coordinate
			sourceComponent.dComponent.getSource().bitmapData=new BitmapData(bmd.width, bmd.height, true, 0x00000000);
			sourceComponent.dComponent.getSource().bitmapData.draw(bmd, mx);
			for (var i:Number=0; i < sourceComponent.dComponent.eraserLayers.length; i++)
			{
				var shape:Sprite=new Sprite();
				shape=EraserLayer(sourceComponent.dComponent.eraserLayers[i]).shape;
				if (action == "horizontal")
				{
					shape.scaleX=-EraserLayer(sourceComponent.dComponent.eraserLayers[i]).width;
				}
				else
				{
					shape.scaleY=-EraserLayer(sourceComponent.dComponent.eraserLayers[i]).height;
				}
			}
			sourceComponent.dComponent.getDStyle().effect.flipH=(action == "horizontal") ? !sourceComponent.dComponent.getDStyle().effect.flipH : sourceComponent.dComponent.getDStyle().effect.flipH;
			sourceComponent.dComponent.getDStyle().effect.flipV=(action == "vertical") ? !sourceComponent.dComponent.getDStyle().effect.flipV : sourceComponent.dComponent.getDStyle().effect.flipV;

		}
	}
}

