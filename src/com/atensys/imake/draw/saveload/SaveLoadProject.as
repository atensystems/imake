package com.atensys.imake.draw.saveload
{
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.BrushStroke;
	import com.atensys.imake.draw.component.CircleComponent;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.EraserLayer;
	import com.atensys.imake.draw.component.ImageUIComponent;
	import com.atensys.imake.draw.component.LineStroke;
	import com.atensys.imake.draw.component.PaintBucketComponent;
	import com.atensys.imake.draw.component.PencilStroke;
	import com.atensys.imake.draw.component.RectangleComponent;
	import com.atensys.imake.draw.component.TextUIComponent;
	import com.atensys.imake.draw.effect.ComponentEffects;
	import com.atensys.imake.draw.effect.DistressFilter;
	import com.atensys.imake.draw.styles.BrushStyle;
	import com.atensys.imake.draw.styles.CircleStyle;
	import com.atensys.imake.draw.styles.EraserStyle;
	import com.atensys.imake.draw.styles.ImageStyle;
	import com.atensys.imake.draw.styles.LineStyle;
	import com.atensys.imake.draw.styles.PaintBucketStyle;
	import com.atensys.imake.draw.styles.PencilStyle;
	import com.atensys.imake.draw.styles.RectangleStyle;
	import com.atensys.imake.draw.styles.TextStyle;
	
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Transform;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.BitmapAsset;

	public class SaveLoadProject
	{
		private var desktop:DrawDesktop;
		private var bitmData:BitmapData;
		private var done:Boolean=false;
		private var zip:FZip;


		public function SaveLoadProject(desk:DrawDesktop)
		{
			this.desktop=desk;
		}

//-------------------------------------------------------------------------------
//--------------------------Save-------------------------------------------------
//-------------------------------------------------------------------------------
		public function save(fname:String):void
		{
			var outputString:String='<?xml version="1.0" encoding="utf-8"?>\n';
			outputString+='<project>\n';
			var component:String="<component></component>";
			var comp:XML;
			for (var i:int=0; i < desktop.dComponentList.length; i++)
			{
				comp=new XML(component);
				comp.@['index']=i;
				comp.appendChild(DComponent(desktop.dComponentList[i]).toXML());
				outputString+=comp.toXMLString() + "\n";
			}
			outputString+='</project>\n';

			var zip:FZip=new FZip();
			var b:ByteArray=new ByteArray();
			b.writeUTFBytes(outputString);
			zip.addFile("project.xml", b, false);
			for (var i1:int=0; i1 < desktop.dComponentList.length; i1++)
			{
				var dcomp:DComponent=desktop.dComponentList[i1];
				if (dcomp.getController() is ImageUIComponent)
				{
					zip.addFile(ImageUIComponent(dcomp).imageName + ".png", Util.byteArrayfromBitmapdata(ImageUIComponent(dcomp).style.initialImageBitmap.bitmapData), false);
				}
				if (dcomp.getController() is PaintBucketComponent)
				{
					zip.addFile(PaintBucketComponent(dcomp).bucketName + ".png", Util.byteArrayfromBitmapdata(PaintBucketComponent(dcomp).toBitmapData()), false);
				}
			}
			zip.close();
			var ba:ByteArray=new ByteArray();
			zip.serialize(ba)
			ba.position=0;
			var file:FileReference=new FileReference();
			file.save(ba, "project.zip");

		}

		/* private function uploadPhoto(imageData:ByteArray):void {
		   var request:URLRequest = new URLRequest("http://tinkerlog.com/uploads/upload.php");
		   var vars:URLVariables = new URLVariables();
		   vars.name = nameField.text;
		   vars.comment = commentField.text;
		   vars.bindata = Base64.encodeByteArray(imageData);
		   request.method = "POST";
		   var loader:URLLoader = new URLLoader();
		   loader.addEventListener(Event.COMPLETE, uploadPhotoHandler);
		   request.data = vars;
		   loader.load(request);
		   }
		   private function uploadPhotoHandler(event:Event):void {
		   trace("server: " + event.target.data);
		   state.text = "Response from server: " + event.target.data;
		   }
		   http://tinkerlog.com/2007/11/03/webcam-snapshots-with-flex3/
		 */

//----------------------------------------------------------------------------------
//------------------------------------------------------Load------------------------
//----------------------------------------------------------------------------------

		public function load(fname:String):void
		{
			zip=new FZip();
			zip.addEventListener(Event.COMPLETE, onEnterFrame);
			zip.load(new URLRequest("project.zip"));

		}

		private function onEnterFrame(evt:Event):void
		{
			var file:FZipFile=zip.getFileByName("project.xml");
			var dComps:XML;
			dComps=new XML(file.getContentAsString());
			loadProj(dComps);
		}


		private function loadProj(dC:XML):void
		{
			for each (var dComp:XML in dC.component)
			{
				pushComponent(dComp);
			}
		}

		private function pushComponent(comp:XML):void
		{
			var xmlComp:XML=comp.children()[0];
			switch (xmlComp.name().toString())
			{
				case "circle":
				{
					addCircle(xmlComp);
					break;
				}
				case "rectange":
				{
					addRectangle(xmlComp);
					break;
				}
				case "brush":
				{
					addBrush(xmlComp);
					break;
				}
				case "line":
				{
					addLine(xmlComp);
					break;
				}
				case "pencil":
				{
					addPencil(xmlComp);
					break;
				}
				case "text":
				{
					addText(xmlComp);
					break;
				}
				case "image":
				{
					addImage(xmlComp);
					break;
				}
				case "bucket":
				{
					addBucket(xmlComp);
					break;
				}
			}
		}

//--------------Circle---------------------------------
		private function addCircle(xmlComp:XML):void
		{
			var dComp:CircleComponent;
			var dStyle:CircleStyle;
			dStyle=new CircleStyle();
			dStyle.lineOpacity=int(xmlComp.circleStyle.@['lineOpacity'].toString());
			dStyle.lineDiameter=int(xmlComp.circleStyle.@['lineDiameter'].toString());
			dStyle.color2=int(xmlComp.circleStyle.@['lineColor'].toString());
			dStyle.color=int(xmlComp.circleStyle.@['fillColor'].toString());
			dStyle.fillOpacity=int(xmlComp.circleStyle.@['fillOpacity'].toString());
			dStyle.effect=getStyleComponentEffect(xmlComp.circleStyle.componentEffect[0]);

			dComp=new CircleComponent(int(xmlComp.@['id'].toString()), dStyle, new Point(50, 50), new Point(50, 50));
			var sPoint:Point=new Point();
			sPoint.x=int(xmlComp.@['x'].toString());
			sPoint.y=int(xmlComp.@['y'].toString());
			var ePoint:Point=new Point();
			ePoint.x=int(xmlComp.@['width'].toString());
			ePoint.y=int(xmlComp.@['height'].toString());
			var dComXY:Point=new Point();
			dComXY.x=Number(xmlComp.@['dcX'].toString());
			dComXY.y=Number(xmlComp.@['dcY'].toString());
			var dComWH:Point=new Point();
			dComWH.x=int(xmlComp.@['dcWidth'].toString());
			dComWH.y=int(xmlComp.@['dcHeight'].toString());
			var oldWH:Point=new Point();
			oldWH.x=int(xmlComp.@['oldWidth'].toString());
			oldWH.y=int(xmlComp.@['oldHeight'].toString());

			dComp.setProperties(sPoint, ePoint, dComXY, dComWH, oldWH);
			dComp.setSource();
			dComp.eraserLayers=getEraserLayers(xmlComp.eraser);
			dComp.reDraw(null);
			desktop.registerComponent(dComp);
			dComp.dispatchEvent(new Event("repaint"));
		}

//--------------Rectangle---------------------------------
		private function addRectangle(xmlComp:XML):void
		{
			var dComp:RectangleComponent;
			var dStyle:RectangleStyle;
			dStyle=new RectangleStyle();

			dStyle.lineOpacity=int(xmlComp.rectangleStyle.@['lineOpacity'].toString());
			dStyle.lineDiameter=int(xmlComp.rectangleStyle.@['lineDiameter'].toString());
			dStyle.color2=int(xmlComp.rectangleStyle.@['lineColor'].toString());
			dStyle.color=int(xmlComp.rectangleStyle.@['fillColor'].toString());
			dStyle.fillOpacity=int(xmlComp.rectangleStyle.@['fillOpacity'].toString());
			dStyle.topLeftRound=int(xmlComp.rectangleStyle.@['topLeftRound'].toString());
			dStyle.topRightRound=int(xmlComp.rectangleStyle.@['topRightRound'].toString());
			dStyle.bottomLeftRound=int(xmlComp.rectangleStyle.@['bottomLeftRound'].toString());
			dStyle.bottomRightRound=int(xmlComp.rectangleStyle.@['bottomRightRound'].toString());
			dStyle.effect=getStyleComponentEffect(xmlComp.rectangleStyle.componentEffect[0]);

			dComp=new RectangleComponent(int(xmlComp.@['id'].toString()), dStyle, new Point(50, 50), new Point(50, 50));
			var sPoint:Point=new Point();
			sPoint.x=int(xmlComp.@['x'].toString());
			sPoint.y=int(xmlComp.@['y'].toString());
			var ePoint:Point=new Point();
			ePoint.x=int(xmlComp.@['width'].toString());
			ePoint.y=int(xmlComp.@['height'].toString());
			var dComXY:Point=new Point();
			dComXY.x=Number(xmlComp.@['dcX'].toString());
			dComXY.y=Number(xmlComp.@['dcY'].toString());
			var dComWH:Point=new Point();
			dComWH.x=int(xmlComp.@['dcWidth'].toString());
			dComWH.y=int(xmlComp.@['dcHeight'].toString());
			var oldWH:Point=new Point();
			oldWH.x=int(xmlComp.@['oldWidth'].toString());
			oldWH.y=int(xmlComp.@['oldHeight'].toString());

			dComp.setProperties(sPoint, ePoint, dComXY, dComWH, oldWH);
			dComp.setSource();
			dComp.eraserLayers=getEraserLayers(xmlComp.eraser);
			dComp.reDraw(null);
			desktop.registerComponent(dComp);
			dComp.dispatchEvent(new Event("repaint"));
		}

//-----------------Brush-----------------------------		
		private function addBrush(xmlComp:XML):void
		{
			var dComp:BrushStroke;
			var dStyle:BrushStyle;
			dStyle=new BrushStyle();

			dStyle.selectedBrush=int(xmlComp.brushStyle.@['selectedBrush'].toString());
			dStyle.opacity=int(xmlComp.brushStyle.@['opacity'].toString());
			dStyle.diameter=int(xmlComp.brushStyle.@['diameter'].toString());
			dStyle.color=int(xmlComp.brushStyle.@['color'].toString());
			dStyle.effect=getStyleComponentEffect(xmlComp.brushStyle.componentEffect[0]);

			var bt:BitmapAsset=new Application.application.brushes[dStyle.selectedBrush].icon() as BitmapAsset;
			dStyle.bitmap=bt.bitmapData;


			dComp=new BrushStroke(int(xmlComp.@['id'].toString()), dStyle, new Point(50, 50), new Point(50, 50));
			var dComXY:Point=new Point();
			dComXY.x=Number(xmlComp.@['dcX'].toString());
			dComXY.y=Number(xmlComp.@['dcY'].toString());
			var dComWH:Point=new Point();
			dComWH.x=int(xmlComp.@['dcWidth'].toString());
			dComWH.y=int(xmlComp.@['dcHeight'].toString());
			var oldWH:Point=new Point();
			oldWH.x=int(xmlComp.@['oldWidth'].toString());
			oldWH.y=int(xmlComp.@['oldHeight'].toString());

			dComp.setProperties(dComXY, dComWH, oldWH, getPoints(xmlComp.point));
			dComp.setSource();
			dComp.eraserLayers=getEraserLayers(xmlComp.eraser);
			dComp.reDraw(null);
			desktop.registerComponent(dComp);
			dComp.dispatchEvent(new Event("repaint"));
		}

//---------------Line---------------------		
		private function addLine(xmlComp:XML):void
		{
			var dComp:LineStroke;
			var dStyle:LineStyle;
			dStyle=new LineStyle();

			dStyle.opacity=int(xmlComp.lineStyle.@['opacity'].toString());
			dStyle.diameter=int(xmlComp.lineStyle.@['diameter'].toString());
			dStyle.color=int(xmlComp.lineStyle.@['color'].toString());
			dStyle.style=xmlComp.lineStyle.@['style'].toString();
			dStyle.pixelHinting=Util.toBoolean(xmlComp.lineStyle.@['pixelHinting'].toString());
			dStyle.effect=getStyleComponentEffect(xmlComp.lineStyle.componentEffect[0]);

			dComp=new LineStroke(int(xmlComp.@['id'].toString()), dStyle, new Point(50, 50), new Point(50, 50));
			var sPoint:Point=new Point();
			sPoint.x=int(xmlComp.@['startX'].toString());
			sPoint.y=int(xmlComp.@['startY'].toString());
			var ePoint:Point=new Point();
			ePoint.x=int(xmlComp.@['endX'].toString());
			ePoint.y=int(xmlComp.@['endY'].toString());
			var dComXY:Point=new Point();
			dComXY.x=Number(xmlComp.@['dcX'].toString());
			dComXY.y=Number(xmlComp.@['dcY'].toString());
			var dComWH:Point=new Point();
			dComWH.x=int(xmlComp.@['dcWidth'].toString());
			dComWH.y=int(xmlComp.@['dcHeight'].toString());
			var oldWH:Point=new Point();
			oldWH.x=int(xmlComp.@['oldWidth'].toString());
			oldWH.y=int(xmlComp.@['oldHeight'].toString());

			dComp.setProperties(sPoint, ePoint, dComXY, dComWH, oldWH);
			dComp.setSource();
			dComp.eraserLayers=getEraserLayers(xmlComp.eraser);
			dComp.reDraw(null);
			desktop.registerComponent(dComp);
			dComp.dispatchEvent(new Event("repaint"));
		}

//-----------------Pencil-----------------------------		
		private function addPencil(xmlComp:XML):void
		{
			var dComp:PencilStroke;
			var dStyle:PencilStyle;
			dStyle=new PencilStyle();

			dStyle.opacity=int(xmlComp.pencilStyle.@['opacity'].toString());
			dStyle.diameter=int(xmlComp.pencilStyle.@['diameter'].toString());
			dStyle.color=int(xmlComp.pencilStyle.@['color'].toString());
			dStyle.style=xmlComp.pencilStyle.@['style'].toString();
			dStyle.pixelHinting=Util.toBoolean(xmlComp.pencilStyle.@['pixelHinting'].toString());
			dStyle.lineJoint=xmlComp.pencilStyle.@['lineJoint'].toString();
			dStyle.effect=getStyleComponentEffect(xmlComp.pencilStyle.componentEffect[0]);

			dComp=new PencilStroke(int(xmlComp.@['id'].toString()), dStyle, new Point(50, 50), new Point(50, 50));
			var dComXY:Point=new Point();
			dComXY.x=Number(xmlComp.@['dcX'].toString());
			dComXY.y=Number(xmlComp.@['dcY'].toString());
			var dComWH:Point=new Point();
			dComWH.x=int(xmlComp.@['dcWidth'].toString());
			dComWH.y=int(xmlComp.@['dcHeight'].toString());
			var oldWH:Point=new Point();
			oldWH.x=int(xmlComp.@['oldWidth'].toString());
			oldWH.y=int(xmlComp.@['oldHeight'].toString());

			dComp.setProperties(dComXY, dComWH, oldWH, getPoints(xmlComp.point));
			dComp.setSource();
			dComp.eraserLayers=getEraserLayers(xmlComp.eraser);
			dComp.reDraw(null);
			desktop.registerComponent(dComp);
			dComp.dispatchEvent(new Event("repaint"));
		}

//-----------------Text-----------------------------		
		private function addText(xmlComp:XML):void
		{
			var dComp:TextUIComponent;
			var dStyle:TextStyle;
			dStyle=new TextStyle();
			dStyle.effect=getStyleComponentEffect(xmlComp.textStyle.componentEffect[0]);

			dComp=new TextUIComponent(int(xmlComp.@['id'].toString()), dStyle, this.desktop, new Point(50, 50));
			var dComXY:Point=new Point();
			dComXY.x=Number(xmlComp.@['dcX'].toString());
			dComXY.y=Number(xmlComp.@['dcY'].toString());
			var dComWH:Point=new Point();
			dComWH.x=int(xmlComp.@['dcWidth'].toString());
			dComWH.y=int(xmlComp.@['dcHeight'].toString());
			var oldWH:Point=new Point();
			oldWH.x=int(xmlComp.@['oldWidth'].toString());
			oldWH.y=int(xmlComp.@['oldHeight'].toString());

			dComp.eraserLayers=getEraserLayers(xmlComp.eraser);
			dComp.setProperties(dComXY, oldWH);
			dComp.removeAllChildren();
			dComp.initComponents();
			dComp.setTextAreaHtmlText(xmlComp.htmlText);
			dComp.setTextArea(null);
			dComp.setProperties(dComXY, dComWH);

			desktop.registerComponent(dComp);
			dComp.dispatchEvent(new Event("repaint"));
		}

//-----------------Image-----------------------------		
		private function addImage(xmlComp:XML):void
		{
			var dComp:ImageUIComponent;
			var dStyle:ImageStyle;
			dStyle=new ImageStyle();
			dStyle.effect=getStyleComponentEffect(xmlComp.imageStyle.componentEffect[0]);
			dStyle.imgTransform = getColorTransform(xmlComp.imageStyle.transform[0]);
			dStyle.blackWhite = Util.toBoolean(xmlComp.imageStyle.@['blackWhite'].toString());
			dComp=new ImageUIComponent(int(xmlComp.@['id'].toString()), xmlComp.@['name'].toString(), dStyle, this.desktop);
			var dComXY:Point=new Point();
			dComXY.x=Number(xmlComp.@['dcX'].toString());
			dComXY.y=Number(xmlComp.@['dcY'].toString());
			var dComWH:Point=new Point();
			dComWH.x=int(xmlComp.@['dcWidth'].toString());
			dComWH.y=int(xmlComp.@['dcHeight'].toString());
			dComp.setProperties(dComXY, dComWH);
			getImageBitmap(xmlComp.@['name'].toString(), dComp);
			dComp.eraserLayers=getEraserLayers(xmlComp.eraser);
		}

		private function getImageBitmap(name:String, img:ImageUIComponent):void
		{
			var file:FZipFile=zip.getFileByName(name + ".png");
			var loader:Loader=new Loader();
			loader.loadBytes(file.content);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
				{
					complete(e, img);
				});
		}

		private function complete(e:Event, img:ImageUIComponent):void
		{
			var bitmap:Bitmap=Bitmap(e.target.content);
			img.style.imageBitmap=bitmap;
			img.style.imageBitmap.transform.colorTransform = img.style.imgTransform.colorTransform;
			img.style.initialImageBitmap=bitmap;
			img.setSource(img.style.imageBitmap);
			img.resizeing(null);
			desktop.registerComponent(img);
			img.dispatchEvent(new Event("repaint"));
		}

//-----------------Paint Bucket-----------------------------		
		private function addBucket(xmlComp:XML):void
		{
			var dComp:PaintBucketComponent;

			var dStyle:PaintBucketStyle;
			dStyle=new PaintBucketStyle();
			dStyle.color=int(xmlComp.bucketStyle.@['color'].toString());
			dStyle.tolerance=int(xmlComp.bucketStyle.@['tolerance'].toString());
			dStyle.effect=getStyleComponentEffect(xmlComp.bucketStyle.componentEffect[0]);

			dComp=new PaintBucketComponent(int(xmlComp.@['id'].toString()), xmlComp.@['name'].toString(), null, new Point(int(xmlComp.@['pointX'].toString()), int(xmlComp.@['pointY'].toString())), dStyle, new Point(int(xmlComp.@['sizeW'].toString()), int(xmlComp.@['sizeH'].toString())));
			var dComXY:Point=new Point();
			dComXY.x=Number(xmlComp.@['dcX'].toString());
			dComXY.y=Number(xmlComp.@['dcY'].toString());
			var dComWH:Point=new Point();
			dComWH.x=int(xmlComp.@['dcWidth'].toString());
			dComWH.y=int(xmlComp.@['dcHeight'].toString());
			dComp.setProperties(dComXY, dComWH);
			getBucketBitmap(xmlComp.@['name'].toString(), dComp);
			dComp.eraserLayers=getEraserLayers(xmlComp.eraser);
		}

		private function getBucketBitmap(name:String, img:PaintBucketComponent):void
		{
			var file:FZipFile=zip.getFileByName(name + ".png");
			var loader:Loader=new Loader();
			loader.loadBytes(file.content);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
				{
					completeB(e, img);
				});
		}

		private function completeB(e:Event, img:PaintBucketComponent):void
		{
			var btSource:BitmapData=Bitmap(e.target.content).bitmapData;
			img.setbtSource(btSource);
			img.setStartColor();
			img.redraw(null);
			desktop.registerComponent(img);
			img.dispatchEvent(new Event("repaint"));
		}

//------------------------EraserLayers-------------------------
		private function getEraserLayers(xmlEraser:XMLList):Array
		{
			var eraseLayers:Array=new Array();
			var style:EraserStyle;
			for each (var layer:XML in xmlEraser)
			{
				style=new EraserStyle();
				style.diameter=int(layer.eraserStyle.@['diameter'].toString());
				style.smoth=int(layer.eraserStyle.@['smoth'].toString());
				style.style=layer.eraserStyle.@['style'].toString();
				var shapeErase:Sprite=new Sprite();
				for each (var p:XML in layer.point)
				{
					var point:Point=new Point(int(p.@['x']), int(p.@['y']));

					var shape:Shape=new Shape();
					shape.graphics.beginFill(0x00FFFFFF);
					if (style.style == CapsStyle.ROUND)
						shape.graphics.drawCircle(point.x, point.y, style.diameter / 2);
					else
					{
						shape.graphics.drawRect(point.x - style.diameter / 2, point.y - style.diameter / 2, style.diameter, style.diameter);
					}
					shape.graphics.endFill();

					var blur:BlurFilter=new BlurFilter(style.smoth, style.smoth, 1);
					shape.filters=[blur];
					shapeErase.addChild(shape);
				}
				eraseLayers.push(new EraserLayer(shapeErase, int(layer.size.@['width']), int(layer.size.@['height']), layer));
			}
			return eraseLayers;
		}

		private function getPoints(points:XMLList):ArrayCollection
		{
			var arr:ArrayCollection=new ArrayCollection();
			for each (var p:XML in points)
			{
				var point:Point=new Point(int(p.@['x']), int(p.@['y']));
				arr.addItem(point);
			}
			return arr;
		}

//-------------------------------ComponentEffects-------------------------------		
		private function getStyleComponentEffect(exml:XML):ComponentEffects
		{
			var effects:ComponentEffects=new ComponentEffects();
			effects.flipH=Util.toBoolean(exml.@['flipH'].toString());
			effects.flipV=Util.toBoolean(exml.@['flipV'].toString());

			if (XMLList(exml.bevel).length() != 0)
			{
				effects.isBevel=true;
				effects.bevel=getBevel(exml.bevel[0]);
			}
			if (XMLList(exml.shadow).length() != 0)
			{
				effects.isShadow=true;
				effects.shadow=getShadow(exml.shadow[0]);
			}
			if (XMLList(exml.glow).length() != 0)
			{
				effects.isGlow=true;
				effects.glow=getGlow(exml.glow[0]);
			}
			if (XMLList(exml.blur).length() != 0)
			{
				effects.isBlur=true;
				effects.blur=getBlur(exml.blur[0]);
			}
			if (XMLList(exml.distress).length() != 0)
			{
				effects.isDistress=true;
				effects.distress=getDistress(exml.distress[0]);
			}
			return effects;
		}

		private function getBevel(bevelF:XML):BevelFilter
		{
			var bevel:BevelFilter=new BevelFilter(4.0, 45, 0xFFFFFF, 1.0, 0x000000, 1.0, 4.0, 4.0, 1, 1, BitmapFilterType.INNER, false);
			bevel.distance=Number(bevelF.@['distance']);
			bevel.angle=Number(bevelF.@['angle']);
			bevel.highlightColor=Number(bevelF.@['highlightColor']);
			bevel.highlightAlpha=Number(bevelF.@['highlightAlpha']);
			bevel.shadowColor=Number(bevelF.@['shadowColor']);
			bevel.shadowAlpha=Number(bevelF.@['shadowAlpha']);
			bevel.blurX=Number(bevelF.@['blurX']);
			bevel.blurY=Number(bevelF.@['blurY']);
			bevel.strength=Number(bevelF.@['strength']);
			bevel.quality=Number(bevelF.@['quality']);
			bevel.type=bevelF.@['type'];
			bevel.knockout=Util.toBoolean(bevelF.@['knockout'].toString());
			return bevel;
		}

		private function getShadow(shadowF:XML):DropShadowFilter
		{
			var shadow:DropShadowFilter=new DropShadowFilter(4.0, 45, 0, 1.0, 4.0, 4.0, 1.0, 1, false, false, false);
			shadow.distance=Number(shadowF.@['distance']);
			shadow.angle=Number(shadowF.@['angle']);
			shadow.color=Number(shadowF.@['color']);
			shadow.alpha=Number(shadowF.@['alpha']);
			shadow.blurX=Number(shadowF.@['blurX']);
			shadow.blurY=Number(shadowF.@['blurY']);
			shadow.strength=Number(shadowF.@['strength']);
			shadow.quality=Number(shadowF.@['quality']);
			shadow.inner=Util.toBoolean(shadowF.@['inner'].toString());
			shadow.knockout=Util.toBoolean(shadowF.@['knockout'].toString());
			shadow.hideObject=Util.toBoolean(shadowF.@['hideObject'].toString());
			return shadow;
		}

		private function getGlow(glowF:XML):GlowFilter
		{
			var glow:GlowFilter=new GlowFilter(0xFF0000, 1.0, 6.0, 6.0, 2, 1, false, false);
			glow.color=Number(glowF.@['color']);
			glow.alpha=Number(glowF.@['alpha']);
			glow.blurX=Number(glowF.@['blurX']);
			glow.blurY=Number(glowF.@['blurY']);
			glow.strength=Number(glowF.@['strength']);
			glow.quality=Number(glowF.@['quality']);
			glow.inner=Util.toBoolean(glowF.@['inner'].toString());
			glow.knockout=Util.toBoolean(glowF.@['knockout'].toString());
			return glow;
		}

		private function getBlur(blurF:XML):BlurFilter
		{
			var blur:BlurFilter=new BlurFilter(5, 5, 1);
			blur.blurX=Number(blurF.@['blurX']);
			blur.blurY=Number(blurF.@['blurY']);
			blur.quality=Number(blurF.@['quality']);
			return blur;
		}

		private function getDistress(distressF:XML):DistressFilter
		{
			var distress:DistressFilter=new DistressFilter(15);
			distress.distressN=Number(distressF.@['distressN']);
			return distress;
		}
		
//-----------------------Color Transform-------------------------------
		private function getColorTransform(root:XML):Transform{
			var imgTransform:Transform = new Transform(new Bitmap());
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.alphaMultiplier = parseFloat(root.@['alphaMultiplier'].toString());
			colorTransform.alphaOffset = parseFloat(root.@['alphaOffset'].toString());
			colorTransform.blueMultiplier = parseFloat(root.@['blueMultiplier'].toString());
			colorTransform.blueOffset = parseFloat(root.@['blueOffset'].toString());
			colorTransform.greenMultiplier = parseFloat(root.@['greenMultiplier'].toString());
			colorTransform.greenOffset = parseFloat(root.@['greenOffset'].toString());
			colorTransform.redMultiplier = parseFloat(root.@['redMultiplier'].toString());
			colorTransform.redOffset = parseFloat(root.@['redOffset'].toString());
			imgTransform.colorTransform = colorTransform;
			return imgTransform;
		}





	}
}