package com.atensys.imake.draw.layers
{
	import com.atensys.imake.draw.component.DComponent;
	
	import flash.display.Bitmap;
	/**
	 * Stores information about a layer. And serves as an item in Layers table datasource.  
	 * Layer name must be unique. 
	 */ 
	[RemoteClass]
	public class LayerData extends Object
	{
		public function LayerData(){
			super();
		}
		public var visible:Boolean;
		[Bindable]
		public var name:String;
		[Bindable]
		public var image:Bitmap;
		public var component:DComponent;
	}
}