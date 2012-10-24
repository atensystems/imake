package aether.utils {

	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	public class Adjustments {
	
		static public const IDENTITY_MATRIX:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
		static public const GRAYSCALE_MATRIX:Array = [.3, .59, .11, 0, 0, .3, .59, .11, 0, 0, .3, .59, .11, 0, 0, 0, 0, 0, 1, 0];
	
		static public function setLevels(
			bitmapData:BitmapData,
			blackPoint:uint,
			midPoint:uint,
			whitePoint:uint
		):void {
			var levels:Object={};
			levels.r=[];
			levels.g=[];
			levels.b=[];
			for (var i:uint=0;i<=blackPoint;i++){
				levels.r.push(0);
				levels.g.push(0);
				levels.b.push(0);
			}
			var n:uint=0;
			var d:uint=midPoint-blackPoint;
			for (i=blackPoint+1;i<=midPoint;i++){
				n=(((i-blackPoint)/d)*127)|0;
				levels.r.push(n<<16);
				levels.g.push(n<<8);
				levels.b.push(n);
			}
			d=whitePoint-midPoint;
			for (i=midPoint+1;i<=whitePoint;i++){
				n=((((i-midPoint)/d)*128)|0)+127;
				levels.r.push(n<<16);
				levels.g.push(n<<8);
				levels.b.push(n);
			}
			for (i=whitePoint+1;i<256;i++){
				levels.r.push(0xFF<<16);
				levels.g.push(0xFF<<8);
				levels.b.push(0xFF);
			}
			bitmapData.paletteMap(bitmapData, bitmapData.rect, new Point(), levels.r, levels.g, levels.b);
		}
	
		static public function setChannelLevels(
			bitmapData:BitmapData,
			red:Array,
			green:Array,
			blue:Array
		):void {
			var ls:Array=[];
			var cs:Array=[red,green,blue];
			var b:Number;
			var m:Number;
			var w:Number;
			var i:uint;
			var n:Number;
			var d:Number;
			var c:Array;
			var l:Array;
			var sh:Number;
			for (var j:uint=0;j<3;j++){
				l=ls[j]=[];
				c=cs[j];
				sh=8*(2-j);
				b=c[0];
				for (i=0;i<=b;i++){
					ls[j].push(0);
				}
				n=0;
				m=c[1];
				d=m-b;
				for (i=b+1;i<=m;i++){
					n=(((i-b)/d)*127)|0;
					l.push(n<<(sh));
				}
				w=c[2];
				d=w-m;
				for (i=m;i<=w;i++){
					n=((((i-m)/d)*128)|0)+127;
					l.push(n<<(sh));
				}
				for (i=w+1;i<256;i++){
					l.push(0xFF<<(sh));
				}
			}
			bitmapData.paletteMap(bitmapData,bitmapData.rect, new Point(), ls[0], ls[1], ls[2]);
		}
	
		static public function invert(bitmapData:BitmapData):void {
			bitmapData.colorTransform(bitmapData.rect, new ColorTransform(-1, -1, -1, 1, 255, 255, 255, 0));
		}
	
		static public function adjustBrightness(bitmapData:BitmapData, amount:Number):void {
			if (amount < 0) {
				var bottom:uint = -amount;
				setLevels(bitmapData, bottom, bottom + (255-bottom)/2, 255);
			} else {
				var top:uint = 255-amount;
				setLevels(bitmapData, 0, top/2, top);
			}
		}
		
		static public function adjustContrast(bitmapData:BitmapData, amount:Number):void {
			amount += 1;
			var filter:ColorMatrixFilter = new ColorMatrixFilter([
				amount,      0,      0, 0, (128 * (1 - amount)), 
				     0, amount,      0, 0, (128 * (1 - amount)), 
				     0,      0, amount, 0, (128 * (1 - amount)), 
				     0,      0,      0, 1,                  1
			]);
			ImageUtil.applyFilter(bitmapData, filter);
		}
	
		static public function threshold(bitmapData:BitmapData, level:uint=128):void {
			desaturate(bitmapData);
			setLevels(bitmapData, level, level, level);
		}

		static public function posterize(bitmapData:BitmapData, levels:uint=2):void {
			levels = Math.max(2, levels);

			var red:BitmapData = ImageUtil.getChannelData(bitmapData, BitmapDataChannel.RED);
			var green:BitmapData = ImageUtil.getChannelData(bitmapData, BitmapDataChannel.GREEN);
			var blue:BitmapData = ImageUtil.getChannelData(bitmapData, BitmapDataChannel.BLUE);
			var sourceChannels:Array = [red, green, blue];
			
			var redFiltered:BitmapData = new BitmapData(bitmapData.width, bitmapData.height, true, 0x00000000);
			var greenFiltered:BitmapData = redFiltered.clone();
			var blueFiltered:BitmapData = redFiltered.clone();
			var filteredChannels:Array = [redFiltered, greenFiltered, blueFiltered];

			var channelData:BitmapData;
			var level:uint;
			var colorTransform:ColorTransform;
			var brightnessAdjust:uint;
			var j:uint;
			levels--;
			for (var i:uint = 0; i < levels; i++) {
				level = 255*((levels-i)/(levels+1));
				brightnessAdjust = 255*((levels-i-1)/(levels));
				colorTransform = new ColorTransform(1, 1, 1, 1, brightnessAdjust, brightnessAdjust, brightnessAdjust);
				for (j = 0; j < 3; j++) {
					channelData = (sourceChannels[j] as BitmapData).clone();
					setLevels(channelData, level, level, level);
					(filteredChannels[j] as BitmapData).draw(channelData, null, colorTransform, BlendMode.MULTIPLY);
				}
			}
			
			ImageUtil.copyChannel(redFiltered, bitmapData, BitmapDataChannel.RED);
			ImageUtil.copyChannel(greenFiltered, bitmapData, BitmapDataChannel.GREEN);
			ImageUtil.copyChannel(blueFiltered, bitmapData, BitmapDataChannel.BLUE);
		}

		static public function desaturate(bitmapData:BitmapData, percent:Number=1):void {
			saturate(bitmapData, 1-percent);
		}
	
		static public function saturate(bitmapData:BitmapData, amount:Number):void {
			var r:Number = 0.3;
			var g:Number = 0.59;
			var b:Number = 0.11;
			var p:Number = 1-amount;
			var matrix:Array=[
				p*r+amount, p*g,        p*b,        0, 0,
				p*r,        p*g+amount, p*b,        0, 0,
				p*r,        p*g,        p*b+amount, 0, 0,
				0,          0,          0,          1, 0
			];
			ImageUtil.applyFilter(bitmapData, new ColorMatrixFilter(matrix));
		}

	}
	
}