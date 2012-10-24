package aether.utils {

	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;

	public class ColorUtil {
	
		static public var RED:uint = 0xFF0000;
		static public var BLUE:uint = 0x0000FF;
		static public var CYAN:uint = 0x00FFFF;
		static public var GREEN:uint = 0x00FF00;
		static public var YELLOW:uint = 0xFFFF00;
		static public var PURPLE:uint = 0xFF00FF;
		static public var BLACK:uint = 0x000000;
		static public var WHITE:uint = 0xFFFFFF;
		static public var ORANGE:uint = 0xFF6600;

		static public function colorRGB(object:DisplayObject, color:uint):void {
			object.transform.colorTransform = new ColorTransform(0, 0, 0, 1, color>>16&0xFF, color>>8&0xFF, color&0xFF);
		}

		static public function decToHex(num:uint):String {
			var hex:String = num.toString(16);
			while (hex.length < 6) hex = "0" + hex;
			return hex;
		}
	
		static public function decToHexString(num:uint):String {
			return "#" + decToHex(num).toUpperCase();
		}
	
		static public function decToHex32(num:uint):String {
			var hex:String = num.toString(24);
			while (hex.length < 6) hex = "0" + hex;
			return hex;
		}
	
		static public function decToHexString32(num:uint):String {
			return "#" + decToHex32(num).toUpperCase();
		}

		static public function toRGB(c:uint):Object {
			return 	{
					r:	c >> 16 & 0xFF,
					g:	c >> 8 & 0xFF,
					b:	c & 0xFF
					};
		}
	
		static public function fromRGB(r:Number, g:Number, b:Number):Number {
			return (r << 16 | g << 8 | b);
		}
	
		static public function RGBtoHSV(r:Number, g:Number, b:Number):Object {
			if (arguments.length == 1) {
				var c:Number = r;
				r = c >> 16 & 0xFF;
				var g:Number = c >> 8 & 0xFF;
				var b:Number = c & 0xFF;
			}
			var hsv:Object = {};
			hsv.v = Math.max(Math.max(r,g),b);
			var min:Number = Math.min(Math.min(r,g),b);
			hsv.s = (hsv.v <= 0) ? 0 : Math.round(100*(hsv.v - min)/hsv.v);
			hsv.v = Math.round((hsv.v /255)*100);
			hsv.h = 0;
			if((r==g) && (g==b))  hsv.h = 0;
			else if(r>=g && g>=b) hsv.h = 60*(g-b)/(r-b);
			else if(g>=r && r>=b) hsv.h = 60  + 60*(g-r)/(g-b);
			else if(g>=b && b>=r) hsv.h = 120 + 60*(b-r)/(g-r);
			else if(b>=g && g>=r) hsv.h = 180 + 60*(b-g)/(b-r);
			else if(b>=r && r>=g) hsv.h = 240 + 60*(r-g)/(b-g);
			else if(r>=b && b>=g) hsv.h = 300 + 60*(r-b)/(r-g);
			else hsv.h = 0;
			hsv.h = Math.round(hsv.h);
			return hsv;
		}
	
		static public function findHue(r:Number, g:Number, b:Number):Object {
			var h:Number=0;
			if(r==g==b)return 0;
			else if(r>=g&&g>=b)h=60*(g-b)/(r-b);
			else if(g>=r&&r>=b)h=60+60*(g-r)/(g-b);
			else if(g>=b&&b>=r)h=120+60*(b-r)/(g-r);
			else if(b>=g&&g>=r)h=180+60*(b-g)/(b-r);
			else if(b>=r&&r>=g)h=240+60*(r-g)/(b-g);
			else if(r>=b&&b>=g)h=300+60*(r-b)/(r-g);
			else return 0;
			return h|0;
		}
	
		static public function HSVtoRGB(h:Number, s:Number, v:Number):Object {
			var rgb:Object = {};
			h = Math.round(h);
			s = Math.round(s*255/100);
			v = Math.round(v*255/100);
			if(s == 0) {
				rgb.r = rgb.g = rgb.b = v;
			} else {
				var t1:Number = v;	
				var t2:Number = (255-s)*v/255;	
				var t3:Number = (t1-t2)*(h%60)/60;
				if(h==360) h = 0;
				if(h<60) {rgb.r=t1;	rgb.b=t2;	rgb.g=t2+t3}
				else if(h<120) {rgb.g=t1;	rgb.b=t2;	rgb.r=t1-t3}
				else if(h<180) {rgb.g=t1;	rgb.r=t2;	rgb.b=t2+t3}
				else if(h<240) {rgb.b=t1;	rgb.r=t2;	rgb.g=t1-t3}
				else if(h<300) {rgb.b=t1;	rgb.g=t2;	rgb.r=t2+t3}
				else if(h<360) {rgb.r=t1;	rgb.g=t2;	rgb.b=t1-t3}
				else {rgb.r=0;	rgb.g=0;	rgb.b=0}
			}
			return rgb;
		}
	
		static public function HSVtoInt(h:Number, s:Number, v:Number):Number {
			var rgb:Object = HSVtoRGB(h, s, v);
			return (rgb.r<<16|rgb.g<<8|rgb.b);
		}
	
		static public function darken(c:Number, v:Number):Number {
			var r:Number=c>>16&0xFF;
			var g:Number=c>>8&0xFF;
			var b:Number=c&0xFF;
			r=(r-(r)*v)|0;
			g=(g-(g)*v)|0;
			b=(b-(b)*v)|0;
			return r<<16|g<<8|b;
		}

		static public function brighten(c:Number, v:Number):Number {
			var r:Number=c>>16&0xFF;
			var g:Number=c>>8&0xFF;
			var b:Number=c&0xFF;
			r=Math.min(255,(r+(r)*v)|0);
			g=Math.min(255,(g+(g)*v)|0);
			b=Math.min(255,(b+(b)*v)|0);
			return r<<16|g<<8|b;
		}

	}

}