package com.atensys.imake.draw.component
{
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.stylepanels.ImageStylePanel;
	import com.atensys.imake.draw.stylepanels.StyleProvider;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	import mx.containers.HBox;
	import mx.containers.TabNavigator;
	import mx.containers.TitleWindow;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.TextInput;
	import mx.core.Application;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;

	public class RequestTitleWindow extends TitleWindow
	{
		private var localBox:HBox;
		private var remoteBox:HBox;
		private var loadFileRef:FileReference;
		private static const FILE_TYPES:Array=[new FileFilter("Image Files", "*.jpg;*.jpeg;*.gif;*.png;*.JPG;*.JPEG;*.GIF;*.PNG")];
		private static const THUMB_WIDTH:uint=240;
		private static const THUMB_HEIGHT:uint=180;
		private var urlAdress:TextInput;
		private var urlBrowse:Button;
		private var localAdress:TextInput;
		private var localBrowse:Button;
		private var loader:Loader;
		private var validator:ImageExtensionValidator;
		private var imageBitmapSource:Bitmap;
		private var image:ImageUIComponent;
		private var parente:DrawDesktop;


		public function RequestTitleWindow(curentImage:ImageUIComponent, parent:DrawDesktop)
		{
			super();
			this.image=curentImage;
			this.parente=parent;
			initRequestWindow();
		}

		public function initRequestWindow():void
		{
			var tabnavigator:TabNavigator=new TabNavigator();
			tabnavigator.setStyle("paddingLeft", 10);
			tabnavigator.setStyle("paddingBottom", 10);
			tabnavigator.setStyle("paddingRight", 10);
			localBox=new HBox();
			localBox.label="Local";

			remoteBox=new HBox();
			remoteBox.label="Remote";
			localBox.addChild(getLocalBox());
			remoteBox.addChild(getURLBox());

			tabnavigator.addChild(localBox);
			tabnavigator.addChild(remoteBox);
			this.title="Request";
			this.setStyle("paddingTop", 20);
			this.setStyle("paddingBottom", 20);
			this.setStyle("paddingLeft", 20);
			this.setStyle("paddingRight", 20);
			this.addChild(tabnavigator);
			this.showCloseButton=true;
			this.width=450;
			this.height=150;

			this.addEventListener(CloseEvent.CLOSE, requestWindow_close);
			PopUpManager.addPopUp(this, Application.application.desktop, true);
			PopUpManager.centerPopUp(this);
		}

		/**
		 * Window Close Efect
		 * */
		private function requestWindow_close(evt:CloseEvent):void
		{
			PopUpManager.removePopUp(this);
		}

		/**
		 * get URL Box
		 * */
		private function getURLBox():HBox
		{
			validator=new ImageExtensionValidator();
			validator.validExtensions=['.jpg', '.jpeg', '.gif', '.png'];
			var urlBox:HBox=new HBox();
			urlAdress=new TextInput();
			urlBrowse=new Button();
			urlAdress.width=250;
			urlAdress.text="http://";
			urlBrowse.enabled=false;
			urlBrowse.label="OK";
			urlBox.addChild(urlAdress);
			urlBox.addChild(urlBrowse);
			urlBrowse.addEventListener(MouseEvent.CLICK, getRemoteImage);
			urlAdress.addEventListener(Event.CHANGE, changeEvent);
			validator.source=urlAdress;
			validator.required=true;
			validator.property="text";
			return urlBox;
		}

		private function changeEvent(evt:Event):void
		{
			validator.errorMessage="You can only upload JPG, JPEG, GIF, and PNG files."
			validator.validate();
			urlBrowse.enabled=true;
		}

		private function getRemoteImage(evt:MouseEvent):void
		{
			var request:URLRequest;
			loader=new Loader();
			request=new URLRequest(urlAdress.text);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onDataLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.load(request);
		}

		private function errorHandler(evt:IOErrorEvent):void
		{
			Alert.show(evt.text);
		}

		/**
		 * get Local Box
		 * */
		private function getLocalBox():HBox
		{
			var localBox:HBox=new HBox();
			localAdress=new TextInput();
			localBrowse=new Button();
			localAdress.width=250;
			localBrowse.label="Browse";
			localBrowse.addEventListener(MouseEvent.CLICK, getLocalImage);
			localBox.addChild(localAdress);
			localBox.addChild(localBrowse);
			return localBox;
		}

		private function getLocalImage(evt:MouseEvent):void
		{
			loadFileRef=new FileReference();
			loadFileRef.addEventListener(Event.SELECT, onFileSelect);
			loadFileRef.browse(FILE_TYPES);
		}

		private function onFileSelect(e:Event):void
		{
			loadFileRef.addEventListener(Event.COMPLETE, onFileLoadComplete);
			loadFileRef.load();
		}

		private function onFileLoadComplete(e:Event):void
		{
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onDataLoadComplete);
			loader.loadBytes(loadFileRef.data);
			loadFileRef=null;
		}

		private function onDataLoadComplete(e:Event):void
		{
			imageBitmapSource=new Bitmap();
			imageBitmapSource=Bitmap(e.target.content);
			var btmpdt:BitmapData=new BitmapData(imageBitmapSource.width, imageBitmapSource.height, true, 0x00FFFFFF);
			btmpdt.draw(imageBitmapSource);
			imageBitmapSource=new Bitmap(btmpdt);
			var coef:Number=1;
			if (imageBitmapSource.height > parente.getDrawable().height )
			{
				coef=(parente.getDrawable().height) / imageBitmapSource.height;
				imageBitmapSource.bitmapData = Util.getResizedBitmapData(imageBitmapSource.bitmapData,imageBitmapSource.width*coef ,imageBitmapSource.height*coef);
			
			}
			if (imageBitmapSource.width > parente.getDrawable().width)
			{
				coef=(parente.getDrawable().width) / imageBitmapSource.width;
				imageBitmapSource.bitmapData = Util.getResizedBitmapData(imageBitmapSource.bitmapData,imageBitmapSource.width * coef,imageBitmapSource.height*coef);
			}

			image.setBitmapImage(imageBitmapSource);

			image.style.imageBitmap=imageBitmapSource;
			image.style.initialImageBitmap=new Bitmap(Bitmap(e.target.content).bitmapData);
			(ImageStylePanel)(StyleProvider.getInstance().currentStylePanel.getController()).setDstyle(image.style);
			PopUpManager.removePopUp(this);
			image.x=parente.getDrawable().width / 2 - image.width / 2;
			image.y=50;
			parente.registerComponent(image);
			image.dispatchEvent(new Event("repaint"));
		}

	}
}