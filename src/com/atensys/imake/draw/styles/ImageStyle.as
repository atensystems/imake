package com.atensys.imake.draw.styles {
	import com.atensys.imake.draw.effect.ComponentEffects;
	
	import flash.display.Bitmap;
	import flash.geom.Transform;

	public class ImageStyle implements DStyle {

		private var _imageBitmap:Bitmap;
		private var _initialImageBitmap:Bitmap;
		private var _blackWhite:Boolean;
		private var _imgTransform:Transform;
		private var _effect:ComponentEffects;

		public function ImageStyle() {
			effect=new ComponentEffects();
		}

		public function set imageBitmap(value:Bitmap):void {
			_imageBitmap=value;
		}

		public function get imageBitmap():Bitmap {
			return _imageBitmap;
		}

		public function set effect(value:ComponentEffects):void {
			_effect=value;
		}

		public function get effect():ComponentEffects {
			return _effect;
		}

		public function set initialImageBitmap(value:Bitmap):void {
			_initialImageBitmap=value;
		}

		public function get initialImageBitmap():Bitmap {
			return _initialImageBitmap;
		}

		public function set blackWhite(value:Boolean):void {
			_blackWhite=value;
		}

		public function get blackWhite():Boolean {
			return _blackWhite;
		}

		public function set imgTransform(value:Transform):void {
			_imgTransform=value;
		}

		public function get imgTransform():Transform {
			return _imgTransform;
		}

		public function set color(color:uint):void {
		}

		public function get color():uint {
			return null;
		}

		public function set color2(color:uint):void {
		}

		public function get color2():uint {
			return null;
		}

		private function transformToXML():XML {
			var root:XML=<transform></transform>;
			if(imgTransform==null) return root;
			root.@['alphaMultiplier']=imgTransform.colorTransform.alphaMultiplier;
			root.@['alphaOffset']=imgTransform.colorTransform.alphaOffset;
			root.@['blueMultiplier']=imgTransform.colorTransform.blueMultiplier;
			root.@['blueOffset']=imgTransform.colorTransform.blueOffset;
			root.@['greenMultiplier']=imgTransform.colorTransform.greenMultiplier;
			root.@['greenOffset']=imgTransform.colorTransform.greenOffset;
			root.@['redMultiplier']=imgTransform.colorTransform.redMultiplier;
			root.@['redOffset']=imgTransform.colorTransform.redOffset;
			return root;
		}

		public function toXML():XML {
			var root:XML=<imageStyle></imageStyle>;
			root.@['blackWhite']=blackWhite;
			root.appendChild(transformToXML());
			root.appendChild(effect.toXML());
			return root;
		}

		public function clone():DStyle {
			var s:ImageStyle=new ImageStyle();
			s._imageBitmap=new Bitmap(this._imageBitmap.bitmapData.clone());
			s._initialImageBitmap=new Bitmap(this._initialImageBitmap.bitmapData.clone());
			s._blackWhite=this._blackWhite;
			s._imageBitmap.transform.colorTransform = this.imageBitmap.transform.colorTransform;
			s._imgTransform=this.imageBitmap.transform;
			s._effect=this._effect.clone();
			return s;
		}
	}
}