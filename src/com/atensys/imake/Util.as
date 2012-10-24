package com.atensys.imake
{
	import aether.utils.Adjustments;
	import aether.utils.ImageUtil;
	
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.EraserLayer;
	import com.dynamicflash.util.Base64;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import mx.core.Application;
	import mx.graphics.codec.PNGEncoder;


	public class Util
	{
		public function Util()
		{
		}

		public static function degreesToRadians(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}

		public static function radiansToDegrees(radians:Number):Number
		{
			return radians * 180 / Math.PI;
		}
		public static function toBoolean(str:String):Boolean{
			return (str=="true")?true:false;
		}

		public static function getMousePointer(evt:MouseEvent):Point
		{
			var c:DisplayObject=DisplayObject(evt.target);
			var p:Point=new Point(evt.localX, evt.localY);
			p=c.localToGlobal(p);
			var tp:Point=new Point(0, 0);
			tp=Application.application.desktop.getDrawable().localToGlobal(tp);
			p.x=p.x - tp.x;
			p.y=p.y - tp.y;
			return p;
		}

		public static function writeExternal(data:BitmapData):ByteArray
		{
			var output:ByteArray=new ByteArray();
			output.writeInt(data.width);
			output.writeInt(data.height);
			var bytes:ByteArray=new ByteArray();
			for (var i:uint=0; i < data.width; i++)
			{
				for (var j:uint=0; j < data.height; j++)
				{
					bytes.writeUnsignedInt(data.getPixel32(i, j));
				}
			}
			bytes.compress();
			output.writeUTF(Base64.encodeByteArray(bytes));
			return output;
		}

		public static function readExternal(input:ByteArray):BitmapData
		{
			var bitmapData:BitmapData=new BitmapData(input.readInt(), input.readInt(), true);
			var bytes:ByteArray=Base64.decodeToByteArray(input.readUTF());
			bytes.uncompress();
			bytes.position=0;
			for (var i:uint=0; i < bitmapData.width; i++)
			{
				for (var j:uint=0; j < bitmapData.height; j++)
				{
					bitmapData.setPixel32(i, j, bytes.readUnsignedInt());
				}
			}
			return bitmapData;
		}

		public static function getBitmap(bd:BitmapData):Bitmap
		{
			var r:Bitmap=new Bitmap(bd);
			if (r.width / 60 > r.height / 40)
			{
				r.height=r.height * 60 / r.width;
				r.width=60;
			}
			else
			{
				r.width=r.width * 40 / r.height;
				r.height=40;
			}

			return r;
		}

		public static function getResizedBitmapData(sourceT:BitmapData, newW:int, newH:int):BitmapData
		{
			var scaleFactorx:Number=newW / sourceT.width;
			var scaleFactory:Number=newH / sourceT.height;
			var scaledBitmapData:BitmapData=new BitmapData(newW, newH, true, 0x00FFFFFF);
			var scaleMatrix:Matrix=new Matrix();
			scaleMatrix.scale(scaleFactorx, scaleFactory);
			scaledBitmapData.draw(sourceT, scaleMatrix); //,null,null,null,true);
			return scaledBitmapData;
		}
		private static const IDEAL_RESIZE_PERCENT:Number=.5;

		public static function resizeImage(source:BitmapData, width:uint, height:uint, constrainProportions:Boolean=true):BitmapData
		{
			var scaleX:Number=width / source.width;
			var scaleY:Number=height / source.height;
			if (constrainProportions)
			{
				if (scaleX > scaleY)
					scaleX=scaleY;
				else
					scaleY=scaleX;
			}

			var bitmapData:BitmapData=source;

			if (scaleX >= 1 && scaleY >= 1)
			{
				bitmapData=new BitmapData(Math.ceil(source.width * scaleX), Math.ceil(source.height * scaleY), true, 0);
				bitmapData.draw(source, new Matrix(scaleX, 0, 0, scaleY), null, null, null, true);
				return bitmapData;
			}

			var nextScaleX:Number=scaleX;
			var nextScaleY:Number=scaleY;
			while (nextScaleX < 1)
				nextScaleX/=IDEAL_RESIZE_PERCENT;
			while (nextScaleY < 1)
				nextScaleY/=IDEAL_RESIZE_PERCENT;

			if (scaleX < IDEAL_RESIZE_PERCENT)
				nextScaleX*=IDEAL_RESIZE_PERCENT;
			if (scaleY < IDEAL_RESIZE_PERCENT)
				nextScaleY*=IDEAL_RESIZE_PERCENT;

			var temp:BitmapData=new BitmapData(bitmapData.width * nextScaleX, bitmapData.height * nextScaleY, true, 0);
			temp.draw(bitmapData, new Matrix(nextScaleX, 0, 0, nextScaleY), null, null, null, true);
			bitmapData=temp;

			nextScaleX*=IDEAL_RESIZE_PERCENT;
			nextScaleY*=IDEAL_RESIZE_PERCENT;

			while (nextScaleX >= scaleX || nextScaleY >= scaleY)
			{
				var actualScaleX:Number=nextScaleX >= scaleX ? IDEAL_RESIZE_PERCENT : 1;
				var actualScaleY:Number=nextScaleY >= scaleY ? IDEAL_RESIZE_PERCENT : 1;
				temp=new BitmapData(bitmapData.width * actualScaleX, bitmapData.height * actualScaleY, true, 0);
				temp.draw(bitmapData, new Matrix(actualScaleX, 0, 0, actualScaleY), null, null, null, true);
				bitmapData.dispose();
				nextScaleX*=IDEAL_RESIZE_PERCENT;
				nextScaleY*=IDEAL_RESIZE_PERCENT;
				bitmapData=temp;
			}

			return bitmapData;
		}

		public static function makeFlip(dComponent:DComponent):void
		{
			var flipH:Boolean=dComponent.getDStyle().effect.flipH;
			var flipV:Boolean=dComponent.getDStyle().effect.flipV;
			var mx:Matrix=new Matrix();
			var bmd:BitmapData=dComponent.getSource().bitmapData.clone();
			mx.scale((flipH) ? -1 : 1, (flipV) ? -1 : 1);
			mx.translate((flipH) ? bmd.width : 0, (flipV) ? bmd.height : 0);
			dComponent.getSource().bitmapData=new BitmapData(bmd.width, bmd.height, true, 0x00000000);
			dComponent.getSource().bitmapData.draw(bmd, mx);
			for (var i:Number=0; i < dComponent.eraserLayers.length; i++)
			{
				var shape:Sprite=EraserLayer(dComponent.eraserLayers[i]).shape;
				if (flipH)
				{
					shape.scaleX=-EraserLayer(dComponent.eraserLayers[i]).width;
				}
				if (flipV)
				{
					shape.scaleY=-EraserLayer(dComponent.eraserLayers[i]).height;
				}
			}
		}
		
		public static function rotate(dComponent:DComponent):void
		{
			var matrix:Matrix=new Matrix();
			// PI radians == 180 degress
			matrix.translate(-dComponent.getSource().bitmapData.width/2, -dComponent.getSource().bitmapData.height/2);
			matrix.rotate(5*(Math.PI/180));
			matrix.translate(dComponent.getSource().bitmapData.width/2, dComponent.getSource().bitmapData.height/2);
			var rotatedBitmap:BitmapData=new BitmapData(dComponent.getSource().bitmapData.width, dComponent.getSource().bitmapData.height, true, 0x00000000);
			rotatedBitmap.draw(dComponent.getSource().bitmapData, matrix);
			// copy rotated data into original bitmap data
			dComponent.getSource().bitmapData.copyPixels(rotatedBitmap, dComponent.getSource().bitmapData.rect, new Point());
			/* 
			var m:Matrix = dComponent.getSource().transform.matrix;
			var x:Number,y:Number;
			x=dComponent.getController().width;
			y=dComponent.getController().height;
			m.translate(-x/2, -y/2);
			m.rotate(5*(Math.PI/180));
			m.translate(x/2, y/2); 
			dComponent.getSource().transform.matrix = m; */
			//Application.application.desktop.resizeFomDComponent();
 		}

		public static function flipEraseLayer(erase:EraserLayer, flipH:Boolean, flipV:Boolean):void
		{

			var bmd:BitmapData=new BitmapData(erase.width, erase.height, true, 0x00000000);
			var mx:Matrix=new Matrix();
			mx.scale((flipH) ? -1 : 1, (flipV) ? -1 : 1);
			mx.translate((flipH) ? bmd.width : 0, (flipV) ? bmd.height : 0);
			bmd.draw(erase.shape,mx);
			var shape:Bitmap=new Bitmap(bmd);
			erase.shape=new Sprite();
			erase.shape.addChild(shape);
		}

		public static function clean(arr:Array):void
		{
			for (var i:Number=0; i < arr.length; i++)
			{
				arr.pop();
			}
		}
		
		public static function byteArrayfromBitmapdata(bData:BitmapData):ByteArray{
			var e:PNGEncoder = new PNGEncoder(); 
			return e.encode(bData);
		}
		public static function currentTime():String{
			var currentTime:Date = new Date();
			return currentTime.fullYear+""+(currentTime.month+1)+""+currentTime.date+""+currentTime.hours+""+currentTime.minutes+""+currentTime.seconds+""+currentTime.milliseconds; 
		}
		
//------------------------------------------------------------------------		
//-----------------------Distress-----------------------------------------
//------------------------------------------------------------------------		
		public static function makeDistress(efBitmapData:BitmapData,distressN:Number):void
		{
			distressImage(efBitmapData, distressN);
			// rotate the image to apply same distortion in opposite directions 
			rotateImage(efBitmapData);
			distressImage(efBitmapData, distressN);
			// rotate image back right side up
			rotateImage(efBitmapData);
		}

		/**
		 * Draws a copy of the image, rotated 180 degrees, into the original image.
		 *
		 * @param bitmapData The image to rotate.
		 */
		public static function rotateImage(bitmapData:BitmapData):void
		{
			var matrix:Matrix=new Matrix();
			// PI radians == 180 degress
			matrix.rotate(Math.PI);
			matrix.translate(bitmapData.width, bitmapData.height);
			var rotatedBitmap:BitmapData=new BitmapData(bitmapData.width, bitmapData.height, true, 0x00000000);
			rotatedBitmap.draw(bitmapData, matrix);
			// copy rotated data into original bitmap data
			bitmapData.copyPixels(rotatedBitmap, bitmapData.rect, new Point());
		}


		/**
		 * Applies distress effects to the specified image at the specified amount.
		 *
		 * @param bitmapData The image to distress
		 * @param amount The amount to distress the image. This should be somethig between 0 and 20, ideally.
		 */
		private static function distressImage(bitmapData:BitmapData, amount:Number):void
		{
			// Perlin noise that will be used for displacemen
			var perlin:BitmapData=new BitmapData(bitmapData.width, bitmapData.height);
			perlin.perlinNoise(10, 10, 5, Math.random(), true, true, BitmapDataChannel.RED);
			// create more light than dark in the noise
			Adjustments.setLevels(perlin, 0, 50, 100);
			var displaceX:Number=amount;
			// displacing more vertically works better for maintaining text legibility
			var displaceY:Number=amount * 3;
			ImageUtil.applyFilter(bitmapData, new DisplacementMapFilter(perlin, new Point(), BitmapDataChannel.RED, BitmapDataChannel.RED, displaceX, displaceY, DisplacementMapFilterMode.WRAP));

			// this noise will be used to alter opacity of distressed image with transparent speckles
			var noise:BitmapData=new BitmapData(bitmapData.width, bitmapData.height);
			noise.noise(Math.random(), 0, 255, BitmapDataChannel.RED, true);
			// apply blur to noise
			ImageUtil.applyFilter(noise, new BlurFilter(displaceX, displaceY));
			// really reduce contrast of noise
			Adjustments.setLevels(noise, 105, 107, 109);
			// draw a grayscale image of the distressed image's alpha channel
			var alpha:BitmapData=ImageUtil.getChannelData(bitmapData, BitmapDataChannel.ALPHA);
			// apply the noise to the grayscale alpha channel image using multiply
			alpha.draw(noise, null, new ColorTransform(1, 1, 1, Math.min(1, amount * .2)), BlendMode.MULTIPLY);
			// copy the altered grayscale image into the alpha channel of the distressed image
			bitmapData.copyChannel(alpha, alpha.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
		}

	}
}