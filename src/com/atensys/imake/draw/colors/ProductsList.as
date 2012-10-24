package com.atensys.imake.draw.colors
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.controls.TileList;
	import mx.core.Application;
	import mx.core.ClassFactory;
	import mx.events.ListEvent;
	
	public class ProductsList extends TileList
	{
		private var products:XML;
		private var loader:URLLoader = new URLLoader();
		private var request:URLRequest = new URLRequest("conf/products.xml");
		private var colors:ArrayCollection;
		
		public function ProductsList()
		{
			super();
			colors = new ArrayCollection();
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			itemRenderer= new ClassFactory(com.atensys.imake.draw.colors.ProductRenderer);
			columnWidth=90;
			rowHeight=90;
			columnCount=5;
		}
		
		private	function onComplete(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			if (loader != null)
			{
				products = new XML(loader.data);
				loadProducts();
			}
			else
			{
				trace("loader is not a URLLoader!");
			}
		}
		
		private function loadProducts():void{
			this.dataProvider = new ArrayCollection();
			var sel:ProductData = null;
			var c:Number= 0;
			for each(var prod:XML in products.product){
				var col:XML = prod.color[0];
				var part:XML = col.part[0];
				var pd:ProductData = new ProductData();
				pd.label = prod.attribute("name")[0].toString();
				pd.thumbnailImage = part.attribute("img")[0].toString();
				colors.addItem(Number(col.attribute("val")[0]));
				if(sel == null){
					sel = pd;
					c = Number(col.attribute("val")[0]);
				}
				dataProvider.addItem(pd);
			}
			for each(var parts:XML in products.parts){
				for each(var tpart:XML in parts.part){
					Application.application.desktop.registerDesktop(tpart.attribute("name")[0].toString());
				}
			}
			initComponents();
			selectedItem =sel;
			Application.application.desktop.setProduct(sel.label);
			Application.application.desktop.setProductColor(c);
		}
		
		private function initComponents():void{
			addEventListener(ListEvent.CHANGE, productChanged);
		}
		
		private function productChanged(le:ListEvent):void{
			Application.application.desktop.setProduct(le.itemRenderer.data.label);
			var i:Number = 0;
			for each(var prod:XML in products.product){
				if(prod.attribute("name")[0].toString() == le.itemRenderer.data.label){
					Application.application.desktop.setProductColor(colors.getItemAt(i));
					break;
				}
				i++;
			}
		}
		
		public function loadParts(pName:String):void{
			var dp:ArrayCollection = new ArrayCollection();
			var prod:XML  = products.product.(@name == pName)[0];
			for each(var col:XML in prod.color){
				if(Number(col.attribute("val")[0]) == Application.application.desktop.getProductColor()){
					for each(var pt:XML  in col.part){
						var pd:PartData = new PartData();
						pd.label = pt.attribute("name")[0].toString();
						pd.thumbnailImage = pt.attribute("img")[0].toString();
						pd.ptl = new Point();
						pd.ptl.x = pt.attribute("tlx")[0].toString();
						pd.ptl.y = pt.attribute("tly")[0].toString();
						pd.pbr = new Point();
						pd.pbr.x = pt.attribute("brx")[0].toString();
						pd.pbr.y = pt.attribute("bry")[0].toString();
						dp.addItem(pd);
					}
				}
			}
			Application.application.productChooser.productImage.source=dp.getItemAt(0).thumbnailImage;
			Application.application.productParts.dataProvider = dp;
			Application.application.productParts.selectedIndex=0;
			Application.application.desktop.usePart(dp.getItemAt(0));
		}
		
		public function loadColors(pName:String):void{
			var dp:ArrayCollection = new ArrayCollection();
			var cn:ArrayCollection = new ArrayCollection();
			var prod:XML  = products.product.(@name == pName)[0];
			for each(var col:XML in prod.color){
				dp.addItem(Number(col.attribute("val")[0]));
				cn.addItem(col.attribute("name")[0].toString());
			}
			Application.application.productColorsPanel.setColors(dp, cn);
		}
		
		public function selectFirstProduct():void
		{
			Application.application.desktop.setProduct(dataProvider.getItemAt(0).label);
			var i:Number = 0;
			for each(var prod:XML in products.product){
				if(prod.attribute("name")[0].toString() == dataProvider.getItemAt(0).label){
					Application.application.desktop.setProductColor(colors.getItemAt(i));
					break;
				}
				i++;
			}
		}
	}
}