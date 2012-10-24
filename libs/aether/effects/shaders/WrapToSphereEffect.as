package aether.effects.shaders {
	
	import flash.geom.Point;
	
	public class WrapToSphereEffect extends ShaderEffect {

		public static var shaderClass:String = "WrapToSphereKernel";
		public static var shaderFile:String = "wrapToSphere.pbj";

		private var _radius:uint;
		private var _textureWidth:uint;
		private var _textureHeight:uint;
		
		public function WrapToSphereEffect(
			radius:uint=256,
			textureWidth:uint=512,
			textureHeight:uint=512,
			blendMode:String=null,
			alpha:Number=1
		) {
			_shaderClass = shaderClass;
			_shaderFile = shaderFile;
			this.textureWidth = textureWidth;
			this.textureHeight = textureHeight;
			this.radius = radius;
			init(blendMode, alpha);
		}
		
		override protected function configureShader(data:Object):void {
			data.radius.value = [_radius];
			data.textureWidth.value = [_textureWidth];
			data.textureHeight.value = [_textureHeight];
		}
		
		public function set textureWidth(width:uint):void {
			_textureWidth = width;
		}

		public function set textureHeight(height:uint):void {
			_textureHeight = height;
		}

		public function set radius(radius:uint):void {
			_radius = radius;
		}

	}

}