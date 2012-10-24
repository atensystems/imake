package aether.textures.synthetic {
	
	import aether.textures.ITexture;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterType;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.Shape;
	
	public class TileTexture implements ITexture {
		
		private var _tileColor:uint;
		private var _groutColor:uint;
		private var _tileSize:Number;
		private var _gutter:Number;
		private var _tileCornerRadius:Number;
		private var _depth:Number;
		private var _knockout:Boolean;
		private var _bevelStrength:Number;
		
		public function TileTexture(
			tileSize:Number,
			tileColor:uint,
			pGutter:Number,
			pGroutColor:uint,
			pDepth:Number=2,
			tileCornerRadius:Number=0,
			pBevelStrength:Number=1,
			pKnockout:Boolean=false
		) {
			_tileColor = tileColor;
			_groutColor = pGroutColor;
			_tileSize = tileSize;
			_gutter = pGutter;
			_tileCornerRadius = tileCornerRadius;
			_depth = pDepth;
			_knockout = pKnockout;
			_bevelStrength = pBevelStrength;
		}
	
		public function draw():BitmapData {
			var size:Number = _tileSize + _gutter;
			var bitmap:BitmapData = new BitmapData(size, size, true, 0x000000);
			var container:Sprite = new Sprite();
			container.graphics.beginFill(_groutColor, 1);
			container.graphics.drawRect(0, 0, size, size);
			container.graphics.drawRoundRect(_gutter, _gutter, _tileSize, _tileSize, _tileCornerRadius, _tileCornerRadius);
			container.graphics.endFill();
			var tile:Shape = new Shape();
			tile.graphics.beginFill(_tileColor, 1);
			tile.graphics.drawRoundRect(0, 0, _tileSize, _tileSize, _tileCornerRadius, _tileCornerRadius);
			tile.graphics.endFill();
			tile.filters = [new BevelFilter(_depth, 45, 0xFFFFFF, _bevelStrength, 0, _bevelStrength, 2, 2, 1, 1, BitmapFilterType.INNER, _knockout)];
			tile.x = _gutter;
			tile.y = _gutter;
			container.addChild(tile);
			bitmap.draw(container);
			return bitmap;
		}
	
	}
	
}