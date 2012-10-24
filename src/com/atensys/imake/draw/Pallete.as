package com.atensys.imake.draw
{
	import com.atensys.imake.draw.colors.ColorsPallete;
	import com.atensys.imake.draw.component.DComponentType;
	
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.core.Application;
	import com.atensys.imake.draw.stylepanels.StyleProvider;

	public class Pallete extends Panel
	{
		private var instrs:VBox;
		private var colors:ColorsPallete;

		private var line:Button;
		private var pencil:Button;
		private var cursor:Button;
		private var brush:Button;
		private var eraser:Button;
		private var text:Button;
		private var selection:Button;
		private var rectangle:Button;
		private var circle:Button;
		private var image:Button;
		private var eyedropper:Button;
		private var paintBucket:Button;
		private var componentType:int;

		[Bindable]
		[Embed(source="assets/pallete/pointer.png")]
		private var pointerImage:Class;

		[Bindable]
		[Embed(source="assets/pallete/pencil.png")]
		private var pencilImage:Class;

		[Bindable]
		[Embed(source="assets/pallete/paintbucket.png")]
		private var paintBucketImage:Class;


		[Bindable]
		[Embed(source="assets/pallete/line.png")]
		private var lineImage:Class;

		[Bindable]
		[Embed(source="assets/pallete/brush.png")]
		private var brushImage:Class;

		[Bindable]
		[Embed(source="assets/pallete/eraser.png")]
		private var eracerImage:Class;

		[Bindable]
		[Embed(source="assets/pallete/rectangle.png")]
		private var rectangleImage:Class;

		[Bindable]
		[Embed(source="assets/pallete/circle.png")]
		private var circleImage:Class;

		[Bindable]
		[Embed(source="assets/pallete/text.png")]
		private var textImage:Class;

		[Bindable]
		[Embed(source="assets/pallete/eyedropper.png")]
		private var eyedropperImage:Class;
		
		[Bindable]
		[Embed(source="assets/pallete/select.png")]
		private var selectImage:Class;
		
		[Bindable]
		[Embed(source="assets/pallete/image.png")]
		private var imageImage:Class;


		public function Pallete()
		{
			super();
			title="Pallete"
			initInstruments()
			initColors();
			this.setStyle("backgroundAlpha", "0");

		}


		public function initInstruments():void
		{
			this.instrs=new VBox;
			instrs.setStyle("horizontalGap", 1);
			instrs.setStyle("verticalGap", 1);
			addChild(this.instrs);

			//togle button for Pencil
			var r1:HBox=new HBox();
			r1.setStyle("horizontalGap", 1);
			pencil=new Button();
			pencil.toggle=true;
			pencil.setStyle("icon", pencilImage);
			pencil.height=30;
			pencil.width=30;
			pencil.addEventListener(MouseEvent.CLICK, selectInstrument);
			pencil.selected=true;
			r1.addChild(pencil);
			//togle button for Brush
			brush=new Button();
			brush.toggle=true;
			brush.setStyle("icon", brushImage);
			brush.height=30;
			brush.width=30;
			brush.addEventListener(MouseEvent.CLICK, selectInstrument);
			r1.addChild(brush);
			this.instrs.addChild(r1);
			//togle button for eracer
			eraser=new Button();
			eraser.toggle=true;
			eraser.setStyle("icon", eracerImage);
			eraser.height=30;
			eraser.width=30;
			eraser.addEventListener(MouseEvent.CLICK, selectInstrument);
			var r2:HBox=new HBox();
			r2.setStyle("horizontalGap", 1);
			r2.addChild(eraser);
			//togle button for rectangle
			line=new Button();
			line.toggle=true;
			line.setStyle("icon", lineImage);
			line.height=30;
			line.width=30;
			line.addEventListener(MouseEvent.CLICK, selectInstrument);
			r2.addChild(line);
			instrs.addChild(r2);
			//togle button for Text
			text=new Button();
			text.toggle=true;
			text.setStyle("icon", textImage);
			text.height=30;
			text.width=30;
			text.addEventListener(MouseEvent.CLICK, selectInstrument);
			//togle button for Selection
			selection=new Button();
			selection.toggle=true;
			selection.setStyle("icon", selectImage);
			selection.height=30;
			selection.width=30;
			selection.addEventListener(MouseEvent.CLICK, selectInstrument);
			var r3:HBox=new HBox();
			r3.setStyle("horizontalGap", 1);
			r3.addChild(text);
			r3.addChild(selection);
			instrs.addChild(r3);

			rectangle=new Button();
			rectangle.toggle=true;
			rectangle.setStyle("icon", rectangleImage);
			rectangle.height=30;
			rectangle.width=30;
			rectangle.addEventListener(MouseEvent.CLICK, selectInstrument);

			circle=new Button();
			circle.toggle=true;
			circle.setStyle("icon", circleImage);
			circle.height=30;
			circle.width=30;
			circle.addEventListener(MouseEvent.CLICK, selectInstrument);
			var r4:HBox=new HBox();
			r4.setStyle("horizontalGap", 1);
			r4.addChild(rectangle);
			r4.addChild(circle);
			instrs.addChild(r4);

			image=new Button();
			image.toggle=true;
			image.setStyle("icon", imageImage);
			image.height=30;
			image.width=30;
			image.addEventListener(MouseEvent.CLICK, selectInstrument);

			eyedropper=new Button();
			eyedropper.toggle=true;
			eyedropper.setStyle("icon", eyedropperImage);
			eyedropper.height=30;
			eyedropper.width=30;
			eyedropper.addEventListener(MouseEvent.CLICK, selectInstrument);

			var r5:HBox=new HBox();
			r5.setStyle("horizontalGap", 1);
			r5.addChild(image);
			r5.addChild(eyedropper);
			instrs.addChild(r5);

			paintBucket=new Button();
			paintBucket.toggle=true;
			paintBucket.setStyle("icon", paintBucketImage);
			paintBucket.height=30;
			paintBucket.width=30;
			paintBucket.addEventListener(MouseEvent.CLICK, selectInstrument);

			cursor=new Button();
			cursor.toggle=true;
			cursor.setStyle("icon", pointerImage);
			cursor.height=30;
			cursor.width=30;
			cursor.addEventListener(MouseEvent.CLICK, selectInstrument);
			cursor.addEventListener(MouseEvent.CLICK, poinerListener);
			cursor.selected=false;

			var r6:HBox=new HBox();
			r6.setStyle("horizontalGap", 1);
			r6.addChild(paintBucket);
			r6.addChild(cursor);
			instrs.addChild(r6);

			//--------------------
			addChild(instrs);
		}

		public function initColors():void
		{
			colors=new ColorsPallete();
			addChild(colors);
		}

		public function getColors():ColorsPallete
		{
			return this.colors;
		}

		public function selectInstrument(evt:MouseEvent):void
		{
			
			cursor.selected=false;
			pencil.selected=false;
			brush.selected=false;
			eraser.selected=false;
			line.selected=false;
			text.selected=false;
			selection.selected=false;
			image.selected=false;
			rectangle.selected=false;
			circle.selected=false;
			eyedropper.selected=false;
			paintBucket.selected = false;
			Button(evt.target).selected=true;

			if (evt.target == cursor)
			{
			this.componentType=DComponentType.POINTER;
			Application.application.desktop.addListenerVisibilitiButton();
			Application.application.desktop.updateState();
			return;
			}
			else if (evt.target == pencil)
			{
				this.componentType=DComponentType.PENCIL;
			}
			else if (evt.target == brush)
			{
				this.componentType=DComponentType.BRUSH;
			}
			else if (evt.target == eraser)
			{
				this.componentType=DComponentType.ERASER;
			}
			else if (evt.target == line)
			{
				this.componentType=DComponentType.LINE;
			}
			else if (evt.target == text)
			{
				this.componentType=DComponentType.TEXT;
			}
			else if (evt.target == selection)
			{
				this.componentType=DComponentType.SELECTION;
			}
			else if (evt.target == rectangle)
			{
				this.componentType=DComponentType.RECTANGLE;
			}
			else if (evt.target == image)
			{
				this.componentType=DComponentType.IMAGE;
			}
			else if (evt.target == circle)
			{
				this.componentType=DComponentType.CIRCLE;
			}
			else if (evt.target == eyedropper)
			{
				this.componentType=DComponentType.EYEDROPPER;
			}
			else if (evt.target == paintBucket)
			{
				this.componentType=DComponentType.PAINT_BUCKET;
			}
			else
			{
				this.componentType=DComponentType.PENCIL
			}
			Application.application.desktop.removeListenerVisibilitiButton();
			Application.application.desktop.updateState();
		}

		public function getComponentType():int
		{
			return this.componentType;
		}

		public function setComponentType(type:int):void
		{
			this.componentType=type;
			setInstrument(type);
		}

		public function addColorsEvents():void
		{
			colors.addColorsChangeEvents();
		}

		public function getImageButton():Button
		{
			return this.image;
		}

		public function setInstrument(instrument:int):void
		{
			(instrument == DComponentType.PENCIL) ? pencil.selected=true : pencil.selected=false;
			(instrument == DComponentType.BRUSH) ? brush.selected=true : brush.selected=false;
			(instrument == DComponentType.ERASER) ? eraser.selected=true : eraser.selected=false;
			(instrument == DComponentType.LINE) ? line.selected=true : line.selected=false;
			(instrument == DComponentType.TEXT) ? text.selected=true : text.selected=false;
			(instrument == DComponentType.SELECTION) ? selection.selected=true : selection.selected=false;
			(instrument == DComponentType.IMAGE) ? image.selected=true : image.selected=false;
			(instrument == DComponentType.RECTANGLE) ? rectangle.selected=true : rectangle.selected=false;
			(instrument == DComponentType.CIRCLE) ? circle.selected=true : circle.selected=false;
			(instrument == DComponentType.EYEDROPPER) ? eyedropper.selected=true : eyedropper.selected=false;
			(instrument == DComponentType.PAINT_BUCKET) ? paintBucket.selected=true : paintBucket.selected=false;
			if(instrument == DComponentType.POINTER){
				cursor.selected=true;
			Application.application.desktop.addListenerVisibilitiButton();
			} else cursor.selected=false;
		}

		public function poinerListener(evt:MouseEvent):void
		{
			StyleProvider.getInstance().removeAllChildren();
			Application.application.desktop.currentComponentProvider.setActive(false);
		}

	}
}