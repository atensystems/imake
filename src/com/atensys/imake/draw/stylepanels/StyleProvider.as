package com.atensys.imake.draw.stylepanels {
	import com.atensys.imake.draw.component.DComponentType;
	import com.atensys.imake.draw.styles.DStyle;
	
	import mx.containers.HBox;

	/**
	 *The style provider bar, positioned on top of application,
	 * where user can change the style for the selected instrument from pallete.
	 * Usually each instrument has a custom style bar.
	 *
	 * @author Andrei Sirghi
	 *
	 */
	public class StyleProvider extends HBox {
		[Bindable]
		public var currentStylePanel:DStylePanel;
		private var cashedStylePanels:Array;
		private static var instance:StyleProvider;

		public function StyleProvider() {
			cashedStylePanels=new Array();
			currentStylePanel=new PencilStylePanel();
			addChild(currentStylePanel.getController());
		}

		/**
		 *Gets current style.
		 *
		 * @return the current style.
		 */
		public function getCurrentStyle():DStyle {
			return null;
		}

		/**
		 *Sets specific style bar for selected component.
		 *
		 * @param componentType the component type, as a constant from DComponentType.
		 */
		public function setStyleBar(componentType:int):void {
			var changed:Boolean=false;
			var i:int;
			if (componentType == DComponentType.POINTER) {
				this.currentStylePanel=null;
				removeAllChildren();
				return;
			}
			if (componentType == DComponentType.PENCIL) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is PencilStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
						changed=true;
					}
				}
				if (!changed) {
					this.currentStylePanel=new PencilStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}

			if (componentType == DComponentType.BRUSH) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is BrushStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new BrushStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}
			if (componentType == DComponentType.TEXT) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is TextStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
						changed=true;
					}
				}
				if (!changed) {
					this.currentStylePanel=new TextStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}
			if (componentType == DComponentType.ERASER) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is EraserStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new EraserStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}
			if (componentType == DComponentType.LINE) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is LineStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new LineStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}

			if (componentType == DComponentType.RECTANGLE) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is RectangleStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new RectangleStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}
			if (componentType == DComponentType.CIRCLE) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is CircleStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new CircleStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}
			if (componentType == DComponentType.IMAGE) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is ImageStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new ImageStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}
			if (componentType == DComponentType.IMAGE) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is ImageStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new ImageStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}

			if (componentType == DComponentType.EYEDROPPER) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is EyedropperStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new EyedropperStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}
			if (componentType == DComponentType.SELECTION) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is SelectionStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new SelectionStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}
			if (componentType == DComponentType.PAINT_BUCKET) {
				for (i=0; i < cashedStylePanels.length; i++) {
					if (cashedStylePanels[i] is PaintBucketStylePanel) {
						this.currentStylePanel=cashedStylePanels[i];
					}
				}
				if (!changed) {
					this.currentStylePanel=new PaintBucketStylePanel();
					this.cashedStylePanels.push(currentStylePanel);
				}
			}
			removeAllChildren();
			addChild(currentStylePanel.getController());
		}

		public function updateStyle(style:DStyle):void {
			currentStylePanel.updateStyle(style);
		}

		public static function getInstance():StyleProvider {
			if (instance == null) {
				instance=new StyleProvider();
			}
			return instance;
		}

	}
}