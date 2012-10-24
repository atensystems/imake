package aether.effects.shaders {

	import aether.effects.ImageEffect;
	
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filters.ShaderFilter;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	public class ShaderEffect extends ImageEffect implements IEventDispatcher {
		
		public static var shaderFilePath:String = "/pixelBender/";
		public static var shaderClassPath:String = "";
		
		private var _filter:ShaderFilter;
		private var _ready:Boolean;
		private var _eventDispatcher:EventDispatcher;

		protected var _shaderClass:String;
		protected var _shaderFile:String;
				
		override protected function init(blendMode:String=null, alpha:Number=1):void {
			super.init(blendMode, alpha);
			_eventDispatcher = new EventDispatcher();
			try {
				var shaderClass:Class = getDefinitionByName(shaderClassPath + "_" + _shaderClass) as Class;
				createShader(ByteArray(new shaderClass()));
			} catch (e:Error) {
				loadShader(shaderFilePath + _shaderFile);
			}
		}
		
		private function loadShader(pPath:String):void {
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onShaderLoaded);
			loader.load(new URLRequest(pPath));
		}
		
		private function createShader(data:ByteArray):void {
			var shader:Shader = new Shader(data);
			_filter = new ShaderFilter(shader);
			_ready = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function configureShader(data:Object):void {}
		
		private function onShaderLoaded(event:Event):void {
			var loader:URLLoader = event.target as URLLoader;
			createShader(loader.data as ByteArray);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=true):void {
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean {
			return _eventDispatcher.dispatchEvent(event);
		}
		
		public function willTrigger(type:String):Boolean {
			return _eventDispatcher.willTrigger(type);
		}

		public function hasEventListener(type:String):Boolean {
			return _eventDispatcher.hasEventListener(type);
		}

		override protected function applyEffect(bitmapData:BitmapData):void {
			if (_ready) {
				configureShader(_filter.shader.data);
				bitmapData.applyFilter(bitmapData, bitmapData.rect, new Point(), _filter);
			}
		}
		
		public function get ready():Boolean {
			return _ready;
		}

	}

}