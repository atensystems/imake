package com.atensys.imake.draw {
	import com.atensys.imake.Util;
	import com.atensys.imake.draw.colors.PartData;
	import com.atensys.imake.draw.component.BrushStroke;
	import com.atensys.imake.draw.component.CircleComponent;
	import com.atensys.imake.draw.component.ComponentResizeContainer;
	import com.atensys.imake.draw.component.ComponentResizeEvent;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.component.DComponentType;
	import com.atensys.imake.draw.component.ImageUIComponent;
	import com.atensys.imake.draw.component.LineStroke;
	import com.atensys.imake.draw.component.PaintBucketComponent;
	import com.atensys.imake.draw.component.PencilStroke;
	import com.atensys.imake.draw.component.RectangleComponent;
	import com.atensys.imake.draw.component.TextUIComponent;
	import com.atensys.imake.draw.componentprovider.BrushComponentProvider;
	import com.atensys.imake.draw.componentprovider.CircleComponentProvider;
	import com.atensys.imake.draw.componentprovider.DComponentProvider;
	import com.atensys.imake.draw.componentprovider.EraserComponentProvider;
	import com.atensys.imake.draw.componentprovider.EyedropperComponentProvider;
	import com.atensys.imake.draw.componentprovider.ImageComponentProvider;
	import com.atensys.imake.draw.componentprovider.LineComponentProvider;
	import com.atensys.imake.draw.componentprovider.PaintBucketComponentProvider;
	import com.atensys.imake.draw.componentprovider.PencilComponentProvider;
	import com.atensys.imake.draw.componentprovider.ProviderUtils;
	import com.atensys.imake.draw.componentprovider.RectangleComponentProvider;
	import com.atensys.imake.draw.componentprovider.SelectionComponentProvider;
	import com.atensys.imake.draw.componentprovider.TextComponentProvider;
	import com.atensys.imake.draw.layers.LayerData;
	import com.atensys.imake.draw.saveload.SaveLoadProject;
	import com.atensys.imake.draw.stylepanels.StyleProvider;
	import com.atensys.imake.draw.styles.DStyle;
	import com.atensys.imake.draw.styles.ImageStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.containers.Canvas;
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.core.Application;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.SliderEvent;

	/**
	 *DrawaDesktop represents the class which provides all properties for drawing,
	 * it provides method for working with layers,
	 * and provides method for component creation and management.
	 *
	 * @author Andrei Sirghi.
	 */
	public class DrawDesktop extends Panel {

		public function DrawDesktop() {
			super();
			componentProviders=new ArrayCollection();
			dComponentList=new ArrayCollection();
			layerdatas=new ArrayCollection();
			prodParts=new ArrayCollection();
			desktops=new ArrayCollection();
			tc=new Canvas();
			tc.percentHeight=100;
			tc.percentWidth=100;
			addChild(tc);
			canv=new Canvas();
			canv.height=100;
			canv.width=100;
			tc.addChild(canv);
			productImage=new Image();
			productImage.setStyle("verticalAlign", "middle");
			productImage.setStyle("horizontalAlign", "center");
			productImage.addEventListener(Event.COMPLETE, imageLoaded);
			canv.addChild(productImage);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, updateCanvas);
			canv.addEventListener(FlexEvent.UPDATE_COMPLETE, moveScrolls);
			desktopSizes=new ArrayCollection();
			componentSizes=new ArrayCollection();
		}

		public var layerdatas:ArrayCollection;
		public var productImage:Image

		private var bit:BitmapData;
		private var cHeight:Number=-1;
		private var cWidth:Number=-1;
		private var canv:Canvas;
		private var componentProviders:IList;
		private var componentSizes:ArrayCollection;
		private var _currentComponentProvider:DComponentProvider;
		private var _dComponentList:ArrayCollection;
		private var desktopSizes:ArrayCollection;
		private var desktops:ArrayCollection;
		private var drawable:Canvas;
		private var prodParts:ArrayCollection;
		private var product:String;
		private var productColor:Number;
		private var productPart:String;
		private var resizeContainer:ComponentResizeContainer;
		private var scale:Number=1;
		private var scaleXDesk:Number=1;
		private var scaleYDesk:Number=1;
		private var tc:Canvas;
		private var tempComponent:DisplayObject;

		public function addDComponentItem(obj:DComponent):void {
			dComponentList.addItem(obj);
		}

		/**
		 * Add eventListeners to Drawable Canvas
		 * */
		public function addListenerVisibilitiButton():void {
			this.drawable.addEventListener(MouseEvent.CLICK, focusResizeToComponent);
		}
		public function resizeFomDComponent():void{
			resizeContainer.resizeFomDComponent();
		}

		/**
		 * Remove eventListeners from Drawable Canvas
		 * */
		public function removeListenerVisibilitiButton():void {
			this.drawable.removeEventListener(MouseEvent.CLICK, focusResizeToComponent);
			if (resizeContainer != null) {
				resizeContainer.setButtonsVisibility(false);
			}
		}

		/**
		 * Focus ResizeContainer to clicked Component
		 *
		 * */
		public function focusResizeToComponent(event:MouseEvent):void {
			if (resizeContainer == null)
				return;
			resizeContainer.setButtonsVisibility(false);
			var targ:Object=event.target as Button;
			if (targ != null) {
				resizeContainer.setButtonsVisibility(true);
				event.stopPropagation();
				return;
			}
			targ=event.target as DComponent;
			if (targ != null) {
				setFocusC(DComponent(targ));
				return;
			}
			targ=event.target as UITextField;
			if (targ != null) {
				setFocusC(DComponent(event.target.parent.parent));
				return;
			}
			targ=event.target as Canvas;
			if (targ != null) {
				resizeContainer.setButtonsVisibility(false);
				StyleProvider.getInstance().removeAllChildren();
				if (currentComponentProvider is TextComponentProvider) {
					if (!TextComponentProvider(currentComponentProvider).getTextUIComponent().style.isEffectEnable)
						TextComponentProvider(currentComponentProvider).getTextUIComponent().setTextEffect();
				}
				return;
			}

		}

		/**
		 * Gets the DComponent at the specified index.
		 * @param index The index in the list from which to retrieve the item.
		 * */
		public function getComponentAt(index:int):DComponent {
			return DComponent(dComponentList.getItemAt(index));
		}

		/**
		 * return a list of all DComponentProviders
		 * */
		public function getComponentProviders():IList {
			return this.componentProviders;
		}

		/**
		 * return current ComponentProvider
		 * */
		public function get currentComponentProvider():DComponentProvider {
			return this._currentComponentProvider;
		}

		/**
		 * return current ComponentProvider
		 * */
		public function set currentComponentProvider(cProvider:DComponentProvider):void {
			this._currentComponentProvider=cProvider;
		}

		public function get dComponentList():ArrayCollection {
			return this._dComponentList;
		}

		public function set dComponentList(list:ArrayCollection):void {
			this._dComponentList=list;
		}

		public function getDrawable():Canvas {
			return drawable;
		}

		/**
		 * Creates a new component.
		 *
		 * @param type component type, one of DComponentType constants.
		 * @return  created component.
		 */
		public function getNewComponent(type:int):void {
			this.currentComponentProvider.setActive(false);
			var exists:Boolean=false;
			var i:int;
			if (type == DComponentType.PENCIL) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is PencilComponentProvider) {
						this.currentComponentProvider=PencilComponentProvider(componentProviders.getItemAt(i));
						this.currentComponentProvider.setDComponent(null);
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new PencilComponentProvider();
				}
			} else if (type == DComponentType.BRUSH) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is BrushComponentProvider) {
						this.currentComponentProvider=BrushComponentProvider(componentProviders.getItemAt(i));
						this.currentComponentProvider.setDComponent(null);
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new BrushComponentProvider();
				}
			} else if (type == DComponentType.ERASER) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is EraserComponentProvider) {
						this.currentComponentProvider=EraserComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new EraserComponentProvider();
				}
			} else if (type == DComponentType.LINE) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is LineComponentProvider) {
						this.currentComponentProvider=LineComponentProvider(componentProviders.getItemAt(i));
						this.currentComponentProvider.setDComponent(null);
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new LineComponentProvider();
				}
			} else if (type == DComponentType.TEXT) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is TextComponentProvider) {
						this.currentComponentProvider=TextComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new TextComponentProvider();
				}
			} else if (type == DComponentType.SELECTION) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is SelectionComponentProvider) {
						this.currentComponentProvider=SelectionComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new SelectionComponentProvider();
				}
			} else if (type == DComponentType.RECTANGLE) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is RectangleComponentProvider) {
						this.currentComponentProvider=RectangleComponentProvider(componentProviders.getItemAt(i));
						this.currentComponentProvider.setDComponent(null);
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new RectangleComponentProvider();
				}
			} else if (type == DComponentType.IMAGE) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is ImageComponentProvider) {
						this.currentComponentProvider=ImageComponentProvider(componentProviders.getItemAt(i));
						this.currentComponentProvider.setDComponent(null);
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new ImageComponentProvider();
				}
			} else if (type == DComponentType.CIRCLE) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is CircleComponentProvider) {
						this.currentComponentProvider=CircleComponentProvider(componentProviders.getItemAt(i));
						this.currentComponentProvider.setDComponent(null);
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new CircleComponentProvider();
				}
			} else if (type == DComponentType.EYEDROPPER) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is EyedropperComponentProvider) {
						this.currentComponentProvider=EyedropperComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new EyedropperComponentProvider();
				}

			} else if (type == DComponentType.PAINT_BUCKET) {
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is PaintBucketComponentProvider) {
						this.currentComponentProvider=PaintBucketComponentProvider(componentProviders.getItemAt(i));
						this.currentComponentProvider.setDComponent(null);
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new PaintBucketComponentProvider();
				}
			} else if (type == DComponentType.POINTER) {
				return;
			}

			if (!exists) {
				this.componentProviders.addItem(currentComponentProvider);
			}

			currentComponentProvider.setParent(this);
			currentComponentProvider.setActive(true);
		}

		public function getProduct():String {
			return this.product;
		}

		public function getProductColor():Number {
			return this.productColor;
		}

		public function hideToolTips():void {
			if (resizeContainer != null) {
				resizeContainer.setButtonsVisibility(false);
			}
		}


		public function init():void {
			currentComponentProvider=new PencilComponentProvider();
			currentComponentProvider.setParent(this);
			StyleProvider.getInstance().setStyleBar(1);
			getNewComponent(1);
		}

		public function layerSelectionChanged(event:ListEvent):void {
			if(Application.application.layersView.layersGrid.selectedItem!=null){
				setFocusC(Application.application.layersView.layersGrid.selectedItem.component as DComponent);
			}	
		}

		public function setFocusC(c:DComponent):void {
			hideToolTips();
			resizeContainer.setFocusC(c);
			Application.application.pallete.setInstrument(DComponentType.POINTER);
			setCurrentComponentProvider(c);
			StyleProvider.getInstance().updateStyle(c.getDStyle());
		}

		public function moveDownComponent(component:DComponent):void {
			var j:int=0;
			for (var i:int=0; i < dComponentList.length; i++) {
				if (this.dComponentList.getItemAt(i) == component) {
					if (i > 0) {
						j=i - 1;
						dComponentList.removeItemAt(i);
						dComponentList.addItemAt(component, j);
						var r:Rectangle=componentSizes.getItemAt(i) as Rectangle;
						componentSizes.removeItemAt(i);
						componentSizes.addItemAt(r, j);
						break;
					}
				}
			}
			j=this.drawable.getChildIndex(component.getController()) - 1;
			if (j >= 0) {
				this.drawable.removeChild(component.getController());
				this.drawable.addChildAt(component.getController(), j);
			}
			for (i=0; i < Application.application.layerData.length; i++) {
				var ld:LayerData=Application.application.layerData.getItemAt(i);
				if (ld.component == component) {
					if (i < Application.application.layerData.length - 1) {
						Application.application.layerData.removeItemAt(i);
						j=i + 1;
						Application.application.layerData.addItemAt(ld, j);
					}
					break;
				}
			}
		}

		public function moveLayer(event:DragEvent):void {
			drawable.removeAllChildren();
			var cursor:IViewCursor=Application.application.layerData.createCursor();
			while (!cursor.afterLast) {
				for (var i:int=0; i < dComponentList.length; i++) {
					if (dComponentList.getItemAt(i) == cursor.current.component) {
						drawable.addChildAt(dComponentList.getItemAt(i).getController() as UIComponent, 0);
					}
				}
				cursor.moveNext();
			}
			drawable.addChild(resizeContainer);
		}

		public function moveUpComponent(component:DComponent):void {
			var j:int=0;
			for (var i:int=0; i < dComponentList.length; i++) {
				if (this.dComponentList.getItemAt(i) == component) {
					if (i < dComponentList.length - 2) {
						j=i + 2;
						dComponentList.removeItemAt(i);
						dComponentList.addItemAt(component, j);
						var r:Rectangle=componentSizes.getItemAt(i) as Rectangle;
						componentSizes.removeItemAt(i);
						componentSizes.addItemAt(r, j);
						break;
					}
				}
			}
			j=this.drawable.getChildIndex(component.getController()) + 1;
			if (j < drawable.getChildren().length - 1) {
				this.drawable.removeChild(component.getController());
				this.drawable.addChildAt(component.getController(), j);
			}
			for (i=0; i < Application.application.layerData.length; i++) {
				var ld:LayerData=Application.application.layerData.getItemAt(i);
				if (ld.component == component) {
					if (i > 0) {
						Application.application.layerData.removeItemAt(i);
						j=i - 1;
						Application.application.layerData.addItemAt(ld, j);
					}
					break;
				}
			}
		}


		public function partChanged(le:ListEvent):void {
			useDesktop(le.itemRenderer.data.label);
			Application.application.desktop.productImage.source=le.itemRenderer.data.thumbnailImage;
		}



		public function registerComponent(component:DComponent):void {
			drawable.addChild(component.getController());
			if (resizeContainer == null) {
				resizeContainer=new ComponentResizeContainer(component);
				drawable.addChild(resizeContainer);
			} else {
				drawable.removeChild(resizeContainer);
				resizeContainer.setFocusC(component);
				drawable.addChild(resizeContainer);
			}
			component.getController().addEventListener("repaint", repaint);
			dComponentList.addItem(component);
			componentSizes.addItem(null);
			component.getController().addEventListener(ComponentResizeEvent.COMPONENT_RESIZE, resizeComponent);
			if (component.getController() is TextUIComponent)
				return;
			Application.application.pallete.setInstrument(DComponentType.POINTER);
		}

		public function registerDesktop(name:String):void {
			var drawable:Canvas=new Canvas();
			drawable.setStyle("horizontalCenter", 0);
			drawable.setStyle("verticalCenter", 0);
			drawable.setStyle("borderThickness", 1);
			drawable.setStyle("borderStyle", "outset");
			drawable.horizontalScrollPolicy=ScrollPolicy.OFF;
			drawable.verticalScrollPolicy=ScrollPolicy.OFF;
			prodParts.addItem(name);
			desktops.addItem(drawable);
			layerdatas.addItem(new ArrayCollection());
			desktopSizes.addItem(null);
		}

		public function registerTempComponent(component:DComponent):void {
			tempComponent=drawable.addChild(component.getController());
		}

		/**
		 *Removes current component.
		 */
		public function removeComponent(dcomponent:DComponent):void {
			hideToolTips();
			for (var i:int=0; i < dComponentList.length; i++) {
				if (this.dComponentList.getItemAt(i) == dcomponent) {
					dComponentList.removeItemAt(i);
					componentSizes.removeItemAt(i);
					break;
				}
			}
			this.drawable.removeChild(dcomponent.getController());
			for (var j:int=0; j < Application.application.layerData.length; j++) {
				var ld:LayerData=Application.application.layerData.getItemAt(j);
				if (ld.component == dcomponent) {
					Application.application.layerData.removeItemAt(j);
					break;
				}
			}
			if (dComponentList.length > 0) {
				var comp:DComponent=DComponent(dComponentList.getItemAt(dComponentList.length - 1));
				drawable.removeChild(resizeContainer);
				resizeContainer=new ComponentResizeContainer(comp);
				drawable.addChild(resizeContainer);
			} else {
				resizeContainer=null;
			}
		}

		/**
		 *Removes component at given order.
		 *
		 *@param index order of component to remove.
		 */
		public function removeComponentAt(index:int):void {
		}




		public function repaint(evt:Event):void {
			var uic:UIComponent=UIComponent(evt.currentTarget);
			if (uic.width == 0 || uic.height == 0) {
				return;
			}
			var exists:Boolean=false;
			var cursor:IViewCursor=Application.application.layerData.createCursor();
			while (!cursor.afterLast) {
				var c:DComponent=cursor.current.component as DComponent;
				if (c.getController() == uic) {
					cursor.current.image=c.getSource();
					exists=true;
					break;
				}
				cursor.moveNext();
			}

			if (!exists) {
				var obj:LayerData=new LayerData();
				obj.visible=true;
				obj.name="layerash";
				for (var i:int=0; i < dComponentList.length; i++) {
					if (dComponentList.getItemAt(i).getController() == uic) {
						var dc:DComponent=dComponentList.getItemAt(i) as DComponent;
						obj.component=dc;
						obj.image=dc.getSource();
						break;
					}
				}
			}

			Application.application.layerData.addItemAt(obj, 0);
		}

		public function get scaleXDesktop():Number {
			return this.scaleXDesk;
		}

		public function get scaleYDesktop():Number {
			return this.scaleYDesk;
		}

		public function setComponentProviders(components:ArrayCollection):void {
			this.componentProviders=components;
		}

		public function setCurrentComponentProvider(comp:DComponent):void {
			var exists:Boolean=false;
			if (comp.getController() is PencilStroke) {
				StyleProvider.getInstance().setStyleBar(DComponentType.PENCIL);
				for (var i:int=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is PencilComponentProvider) {
						this.currentComponentProvider=PencilComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new PencilComponentProvider();
					currentComponentProvider.setParent(this);
					this.componentProviders.addItem(currentComponentProvider);
				}
				currentComponentProvider.setDComponent(comp);
				return;
			}
			if (comp.getController() is LineStroke) {
				StyleProvider.getInstance().setStyleBar(DComponentType.LINE);
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is LineComponentProvider) {
						this.currentComponentProvider=LineComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new LineComponentProvider();
					currentComponentProvider.setParent(this);
					this.componentProviders.addItem(currentComponentProvider);
				}
				currentComponentProvider.setDComponent(comp);
				return;
			}
			if (comp.getController() is BrushStroke) {
				StyleProvider.getInstance().setStyleBar(DComponentType.BRUSH);
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is BrushComponentProvider) {
						this.currentComponentProvider=BrushComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new BrushComponentProvider();
					currentComponentProvider.setParent(this);
					this.componentProviders.addItem(currentComponentProvider);
				}
				currentComponentProvider.setDComponent(comp);
				return;
			}
			if (comp.getController() is RectangleComponent) {
				StyleProvider.getInstance().setStyleBar(DComponentType.RECTANGLE);
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is RectangleComponentProvider) {
						this.currentComponentProvider=RectangleComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new RectangleComponentProvider();
					currentComponentProvider.setParent(this);
					this.componentProviders.addItem(currentComponentProvider);
				}
				currentComponentProvider.setDComponent(comp);
				return;
			}
			if (comp.getController() is CircleComponent) {
				StyleProvider.getInstance().setStyleBar(DComponentType.CIRCLE);
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is CircleComponentProvider) {
						this.currentComponentProvider=CircleComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new CircleComponentProvider();
					currentComponentProvider.setParent(this);
					this.componentProviders.addItem(currentComponentProvider);
				}
				currentComponentProvider.setDComponent(comp);
				return;
			}
			if (comp.getController() is ImageUIComponent) {
				StyleProvider.getInstance().setStyleBar(DComponentType.IMAGE);
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is ImageComponentProvider) {
						this.currentComponentProvider=ImageComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new ImageComponentProvider();
					currentComponentProvider.setParent(this);
					this.componentProviders.addItem(currentComponentProvider);
				}
				currentComponentProvider.setDComponent(comp);
				return;
			}
			if (comp.getController() is TextUIComponent) {
				StyleProvider.getInstance().setStyleBar(DComponentType.TEXT);
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is TextComponentProvider) {
						this.currentComponentProvider=TextComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new TextComponentProvider();
					currentComponentProvider.setParent(this);
					this.componentProviders.addItem(currentComponentProvider);
				}
				currentComponentProvider.setDComponent(comp);
				return;
			}
			if (comp.getController() is PaintBucketComponent) {
				StyleProvider.getInstance().setStyleBar(DComponentType.PAINT_BUCKET);
				for (i=0; i < componentProviders.length; i++) {
					if (componentProviders.getItemAt(i) is PaintBucketComponentProvider) {
						this.currentComponentProvider=PaintBucketComponentProvider(componentProviders.getItemAt(i));
						exists=true;
					}
				}
				if (!exists) {
					this.currentComponentProvider=new PaintBucketComponentProvider();
					currentComponentProvider.setParent(this);
					this.componentProviders.addItem(currentComponentProvider);
				}
				currentComponentProvider.setDComponent(comp);
				return;
			}
		}

		public function setDComponentList(dComponents:ArrayCollection):void {
			this.dComponentList=dComponents;
		}

		/**
		 *Sets style for current component.
		 * @param style style to set.
		 */
		public function setDStyle(style:DStyle):void {
			if (this.currentComponentProvider != null) {
				this.currentComponentProvider.setDStyle(style);
			}
		}

		public function setProduct(product:String):void {
			this.product=product;
			Application.application.productChooser.getPopupList().loadColors(product);
		}

		public function setProductColor(c:Number):void {
			this.productColor=c;
			Application.application.productColorsPanel.selectColor(c);
			Application.application.productChooser.getPopupList().loadParts(product);
		}

		public function unregisterTempComponent():void {
			drawable.removeChild(tempComponent);
		}

		public function updateState():void {
			var componentType:int=Application.application.pallete.getComponentType();
			StyleProvider.getInstance().setStyleBar(componentType);
			getNewComponent(componentType);
		}

		public function updateStyle(style:DStyle):void {
		}

		public function useDesktop(name:String):void {
			hideToolTips();
			this.productPart=name;
			if (this.currentComponentProvider != null) {
				this.currentComponentProvider.setActive(false);
			}
			if (drawable != null) {
				canv.removeChild(drawable);
			}
			for (var i:int=0; i < prodParts.length; i++) {
				if (prodParts.getItemAt(i) == name) {
					drawable=Canvas(desktops.getItemAt(i));
					if (getProductColor() < 0xAFFFFF) {
						drawable.setStyle("borderColor", 0xdbdbdc);
					} else {
						drawable.setStyle("borderColor", 0x6b6e73);
					}
					canv.addChild(drawable);
					Application.application.layerData=layerdatas.getItemAt(i);
				}
			}
			if (this.currentComponentProvider == null) {
				init();
			} else {
				currentComponentProvider.setParent(this);
			}
		}

		public function usePart(part:PartData):void {
			useDesktop(part.label);
			productImage.source=part.thumbnailImage;
		}

		public function zoom(event:SliderEvent):void {
			var percentage:Number=event.value;
			var scale:Number=percentage / 100.0;
			this.scale=scale;
			canv.height=cHeight * scale;
			canv.width=cWidth * scale;
			rearangeContent();
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			StyleProvider.getInstance().height=22;
			StyleProvider.getInstance().width=this.width;
			StyleProvider.getInstance().move(10, 4);
			titleBar.addChild(StyleProvider.getInstance());
		}

		public function doSave():void {
			var sav:SaveLoadProject=new SaveLoadProject(this);
			sav.save("project.xml");
		}

		public function doLoad():void {
			var lod:SaveLoadProject=new SaveLoadProject(this);
			lod.load("project.zip");
		}

		private function imageLoaded(event:Event):void {
			rearangeContent();
		}

		private function moveScrolls(event:FlexEvent):void {
			if (drawable != null) {
				if (drawable.width < cWidth && tc.horizontalScrollBar != null) {
					tc.horizontalScrollPosition=(canv.width - tc.horizontalScrollBar.width) / 2;
				}
				if (drawable.height < cHeight && tc.verticalScrollBar != null) {
					tc.verticalScrollPosition=(canv.height - tc.verticalScrollBar.height) / 2;
				}
			}
		}

		private function rearangeContent():void {
			if(productImage==null||productImage.content==null){
				return;
			}
			var rh:Number=productImage.content.height;
			var rw:Number=productImage.content.width;
			var cHeight:Number=canv.height;
			var cWidth:Number=canv.width;
			var scale1:Number=Math.min(cHeight / rh, cWidth / rw);
			productImage.width=rw * scale1;
			productImage.height=rh * scale1;
			productImage.x=(cWidth - productImage.width) / 2.0;
			productImage.y=(cHeight - productImage.height) / 2.0;

			var bw:Boolean=rh / productImage.height < rw / productImage.width;
			var scale:Number=Math.min(productImage.height / rh, productImage.width / rw);
			var x:Number=0;
			var y:Number=0;
			var x1:Number=productImage.width;
			var y1:Number=productImage.height;
			if (bw) {
				y=(productImage.height - rh * scale) / 2;
				y1=productImage.height - (productImage.height - rh * scale) / 2;
			} else {
				x=(productImage.width - rw * scale) / 2;
				x1=productImage.width - (productImage.width - rw * scale) / 2;
			}
			var partData:PartData=Application.application.productParts.selectedItem;
			if (partData == null) {
				return;
			}
			y+=partData.ptl.y * scale;
			x+=partData.ptl.x * scale;

			x1-=(rw - partData.pbr.x) * scale;
			y1-=(rh - partData.pbr.y) * scale;
			this.drawable.x=x;
			this.drawable.y=y;
			this.drawable.width=x1 - x;
			this.drawable.height=y1 - y;
			for (var i:int=0; i < prodParts.length; i++) {
				if (prodParts.getItemAt(i) == productPart) {
					if (desktopSizes.getItemAt(i) == null) {
						var ds:Point=new Point();
						ds.x=drawable.width;
						ds.y=drawable.height;
						desktopSizes.setItemAt(ds, i);
					}

					var scaleX:Number=drawable.width / Point(desktopSizes.getItemAt(i)).x;
					scaleXDesk=scaleX;
					var scaleY:Number=drawable.height / Point(desktopSizes.getItemAt(i)).y;
					scaleYDesk=scaleY;
					for (var j:int=0; j < dComponentList.length; j++) {
						var c:UIComponent=UIComponent(dComponentList.getItemAt(j).getController());
						if (drawable.contains(c)) {
							if (componentSizes.getItemAt(j) == null) {
								var cs:Rectangle=new Rectangle();
								cs.width=c.width;
								cs.height=c.height;
								cs.x=c.x;
								cs.y=c.y;
								componentSizes.setItemAt(cs, j);
							}
							c.width=Rectangle(componentSizes.getItemAt(j)).width * scaleX;
							c.height=Rectangle(componentSizes.getItemAt(j)).height * scaleY;
							c.x=Rectangle(componentSizes.getItemAt(j)).x * scaleX;
							c.y=Rectangle(componentSizes.getItemAt(j)).y * scaleY;
						}
					}
				}
			}
			drawable.scrollRect=new Rectangle(-2, -2, drawable.width + 2, drawable.height + 2);
		}

		private function resizeComponent(event:ComponentResizeEvent):void {
			var crc:UIComponent=UIComponent(event.target);
			o: for (var i:int=0; i < dComponentList.length; i++) {
				if (dComponentList.getItemAt(i).getController() == crc) {
					for (var j:int=0; j < prodParts.length; j++) {
						if (prodParts.getItemAt(j) == productPart) {
							var scaleX:Number=drawable.width / Point(desktopSizes.getItemAt(j)).x;
							var scaleY:Number=drawable.height / Point(desktopSizes.getItemAt(j)).y;
							var cs:Rectangle=new Rectangle();
							cs.width=crc.width / scaleX;
							cs.height=crc.height / scaleY;
							cs.x=crc.x / scaleX;
							cs.y=crc.y / scaleY;
							componentSizes.setItemAt(cs, i);
							break o;
						}
					}
				}
			}
		}

		private function updateCanvas(event:FlexEvent):void {
			cHeight=this.height - 40;
			cWidth=this.width - 20;
			canv.height=cHeight;
			canv.width=cWidth;
		}

		public function merge(c1:DComponent, c2:DComponent):DComponent {
			var bd:BitmapData=new BitmapData(drawable.width, drawable.height, true, 0x00000000);

			var m1:Matrix=new Matrix();
			m1.translate(c1.getController().x, c1.getController().y);
			var m2:Matrix=new Matrix();
			m2.translate(c2.getController().x, c2.getController().y);
			bd.draw(c1.getController(), m1);
			bd.draw(c2.getController(), m2);
			
			
			var r:Rectangle=bd.getColorBoundsRect(0xFFFFFFFF, 0x00000000, false);
			var btFinal:BitmapData=new BitmapData(r.width, r.height, true, 0x00000000);
			btFinal.copyPixels(bd, r, new Point());
			var i:ImageUIComponent = new ImageUIComponent(ProviderUtils.newID(),Util.currentTime(),new ImageStyle(), this);
			i.setBitmapImage(new Bitmap(btFinal));
			i.x=Math.min(c1.getController().x, c2.getController().x);
			i.y=Math.min(c1.getController().y, c2.getController().y);
			return i;			
		}
	}
}

