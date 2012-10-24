package com.atensys.imake.draw.effect
{
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;

	public class ComponentEffects
	{
		private var _isDistress:Boolean;
		private var _isExtrude:Boolean;
		private var _isBevel:Boolean;
		private var _isBlur:Boolean;
		private var _isShadow:Boolean;
		private var _isGlow:Boolean;
		private var _bevel:BevelFilter;
		private var _shadow:DropShadowFilter;
		private var _glow:GlowFilter;
		private var _blur:BlurFilter;
		private var _distress:DistressFilter;
		private var _extrude:ExtrudeFilter;
		private var _flipH:Boolean;
		private var _flipV:Boolean;
		private var _rotation:Number=0;

		public function set flipH(value:Boolean):void
		{
			_flipH=value;
		}

		public function get flipH():Boolean
		{
			return _flipH;
		}
		public function set rotation(value:Number):void
		{
			_rotation=value;
		}

		public function get rotation():Number
		{
			return _rotation;
		}
		public function set flipV(value:Boolean):void
		{
			_flipV=value;
		}

		public function get flipV():Boolean
		{
			return _flipV;
		}
		public function set isDistress(value:Boolean):void
		{
			_isDistress=value;
		}

		public function get isDistress():Boolean
		{
			return _isDistress;
		}

		public function set isExtrude(value:Boolean):void
		{
			_isExtrude=value;
		}

		public function get isExtrude():Boolean
		{
			return _isExtrude;
		}

		public function set isBevel(value:Boolean):void
		{
			_isBevel=value;
		}

		public function get isBevel():Boolean
		{
			return _isBevel;
		}

		public function set isBlur(value:Boolean):void
		{
			_isBlur=value;
		}

		public function get isBlur():Boolean
		{
			return _isBlur;
		}

		public function set isShadow(value:Boolean):void
		{
			_isShadow=value;
		}

		public function get isShadow():Boolean
		{
			return _isShadow;
		}

		public function set isGlow(value:Boolean):void
		{
			_isGlow=value;
		}

		public function get isGlow():Boolean
		{
			return _isGlow;
		}

		public function set bevel(value:BevelFilter):void
		{
			_bevel=value;
		}

		public function get bevel():BevelFilter
		{
			return _bevel;
		}

		public function set shadow(value:DropShadowFilter):void
		{
			_shadow=value;
		}

		public function get shadow():DropShadowFilter
		{
			return _shadow;
		}

		public function set glow(value:GlowFilter):void
		{
			_glow=value;
		}

		public function get glow():GlowFilter
		{
			return _glow;
		}

		public function set blur(value:BlurFilter):void
		{
			_blur=value;
		}

		public function get blur():BlurFilter
		{
			return _blur;
		}

		public function set distress(value:DistressFilter):void
		{
			_distress=value;
		}

		public function get distress():DistressFilter
		{
			return _distress;
		}

		public function set extrude(value:ExtrudeFilter):void
		{
			_extrude=value;
		}

		public function get extrude():ExtrudeFilter
		{
			return _extrude;
		}
		public function get filters():Array{
			var array:Array = new Array();
			if(isBevel)array.push(bevel);
			if(isShadow)array.push(shadow);
			if(isGlow)array.push(glow);
			if(isBlur)array.push(blur);
			return array;
		}

		public function ComponentEffects()
		{
			bevel=new BevelFilter(4.0, 45, 0xFFFFFF, 1.0, 0x000000, 1.0, 4.0, 4.0, 1, 1, BitmapFilterType.INNER, false);
			shadow=new DropShadowFilter(4.0, 45, 0, 1.0, 4.0, 4.0, 1.0, 1, false, false, false);
			glow=new GlowFilter(0xFF0000, 1.0, 6.0, 6.0, 2, 1, false, false);
			blur=new BlurFilter(5, 5, 1);
			distress=new DistressFilter(15);
			extrude=new ExtrudeFilter(20, 480, new Point(0, 0));
			isBevel=false;
			isBlur=false;
			isShadow=false;
			isDistress=false;
			isExtrude=false;
			isGlow=false;
			flipH = false;
			flipV = false;
		}

		public function toXML():XML
		{
			var root:XML=<componentEffect></componentEffect>;
			var bevelF:XML=<bevel></bevel>;
			var shadowF:XML=<shadow></shadow>;
			var glowF:XML=<glow></glow>;
			var blurF:XML=<blur></blur>;
			var distressF:XML=<distress></distress>;
			root.@['flipH']= flipH;
			root.@['flipV']= flipV;

			if (isBevel)
			{
				bevelF.@['distance']=bevel.distance;
				bevelF.@['angle']=bevel.angle;
				bevelF.@['highlightColor']=bevel.highlightColor;
				bevelF.@['highlightAlpha']=bevel.highlightAlpha;
				bevelF.@['shadowColor']=bevel.shadowColor;
				bevelF.@['shadowAlpha']=bevel.shadowAlpha;
				bevelF.@['blurX']=bevel.blurX;
				bevelF.@['blurY']=bevel.blurY;
				bevelF.@['strength']=bevel.strength;
				bevelF.@['quality']=bevel.quality;
				bevelF.@['type']=bevel.type;
				bevelF.@['knockout']=bevel.knockout;
				root.appendChild(bevelF);
			}
			if (isShadow)
			{
				shadowF.@['distance']=shadow.distance;
				shadowF.@['angle']=shadow.angle;
				shadowF.@['color']=shadow.color;
				shadowF.@['alpha']=shadow.alpha;
				shadowF.@['blurX']=shadow.blurX;
				shadowF.@['blurY']=shadow.blurY;
				shadowF.@['strength']=shadow.strength;
				shadowF.@['quality']=shadow.quality;
				shadowF.@['inner']=shadow.inner;
				shadowF.@['knockout']=shadow.knockout;
				shadowF.@['hideObject']=shadow.hideObject;
				root.appendChild(shadowF);
			}
			if (isGlow)
			{
				glowF.@['color']=glow.color;
				glowF.@['alpha']=glow.alpha;
				glowF.@['blurX']=glow.blurX;
				glowF.@['blurY']=glow.blurY;
				glowF.@['strength']=glow.strength;
				glowF.@['quality']=glow.quality;
				glowF.@['inner']=glow.inner;
				glowF.@['knockout']=glow.knockout;
				root.appendChild(glowF);
			}
			if (isBlur)
			{
				blurF.@['blurX']=blur.blurX;
				blurF.@['blurY']=blur.blurY;
				blurF.@['quality']=blur.quality;
				root.appendChild(blurF);
			}
			if (isDistress)
			{
				distressF.@['distressN']=distress.distressN;
				root.appendChild(distressF);
			}
			/* if (isExtrude)
			{
				extrudeF.@['layers']=extrude.layers;
				extrudeF.@['focal']=extrude.focal;
				extrudeF.@['projectionPointX']=extrude.projectionPoint.x;
				extrudeF.@['projectionPointY']=extrude.projectionPoint.y;
				root.appendChild(extrudeF);
			} */

			return root;
		}
		public function clone():ComponentEffects{
			var clone:ComponentEffects = new ComponentEffects();
			clone.bevel = _bevel;
			clone.shadow=_shadow;
			clone.glow=_glow;
			clone.blur=_blur;
			clone.distress=_distress;
			clone.extrude=_extrude;
			clone.isBevel=_isBevel;
			clone.isBlur=_isBlur;
			clone.isShadow=_isShadow;
			clone.isDistress=_isDistress;
			clone.isExtrude=_isExtrude;
			clone.isGlow=_isGlow;
			clone.flipH = _flipH;
			clone.flipV = _flipV;
		return clone;
		}

	}
}