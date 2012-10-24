

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import com.atensys.imake.draw.Pallete;
import mx.containers.HBox;
import com.atensys.imake.draw.ZoomSlider;
import mx.controls.TileList;
import com.atensys.imake.draw.colors.Swatches;
import com.atensys.imake.draw.layers.LayersView;
import com.atensys.imake.draw.ProductChooser;
import com.atensys.imake.draw.DrawDesktop;
import Array;
import mx.collections.ArrayCollection;
import mx.containers.Panel;
import com.atensys.imake.draw.colors.ProductColorSwatches;
import com.atensys.imake.draw.ApplicationToolBar;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property brushes (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'brushes' moved to '_156351848brushes'
	 */

    [Bindable(event="propertyChange")]
    public function get brushes():Array
    {
        return this._156351848brushes;
    }

    public function set brushes(value:Array):void
    {
    	var oldValue:Object = this._156351848brushes;
        if (oldValue !== value)
        {
            this._156351848brushes = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "brushes", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property colorSwatchesPanel (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'colorSwatchesPanel' moved to '_401009769colorSwatchesPanel'
	 */

    [Bindable(event="propertyChange")]
    public function get colorSwatchesPanel():mx.containers.Panel
    {
        return this._401009769colorSwatchesPanel;
    }

    public function set colorSwatchesPanel(value:mx.containers.Panel):void
    {
    	var oldValue:Object = this._401009769colorSwatchesPanel;
        if (oldValue !== value)
        {
            this._401009769colorSwatchesPanel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "colorSwatchesPanel", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property colorsPanel (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'colorsPanel' moved to '_1864581748colorsPanel'
	 */

    [Bindable(event="propertyChange")]
    public function get colorsPanel():com.atensys.imake.draw.colors.Swatches
    {
        return this._1864581748colorsPanel;
    }

    public function set colorsPanel(value:com.atensys.imake.draw.colors.Swatches):void
    {
    	var oldValue:Object = this._1864581748colorsPanel;
        if (oldValue !== value)
        {
            this._1864581748colorsPanel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "colorsPanel", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property desktop (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'desktop' moved to '_1557106716desktop'
	 */

    [Bindable(event="propertyChange")]
    public function get desktop():com.atensys.imake.draw.DrawDesktop
    {
        return this._1557106716desktop;
    }

    public function set desktop(value:com.atensys.imake.draw.DrawDesktop):void
    {
    	var oldValue:Object = this._1557106716desktop;
        if (oldValue !== value)
        {
            this._1557106716desktop = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "desktop", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property layersView (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'layersView' moved to '_30207225layersView'
	 */

    [Bindable(event="propertyChange")]
    public function get layersView():com.atensys.imake.draw.layers.LayersView
    {
        return this._30207225layersView;
    }

    public function set layersView(value:com.atensys.imake.draw.layers.LayersView):void
    {
    	var oldValue:Object = this._30207225layersView;
        if (oldValue !== value)
        {
            this._30207225layersView = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "layersView", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property pallete (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'pallete' moved to '_798716731pallete'
	 */

    [Bindable(event="propertyChange")]
    public function get pallete():com.atensys.imake.draw.Pallete
    {
        return this._798716731pallete;
    }

    public function set pallete(value:com.atensys.imake.draw.Pallete):void
    {
    	var oldValue:Object = this._798716731pallete;
        if (oldValue !== value)
        {
            this._798716731pallete = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pallete", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property productChooser (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'productChooser' moved to '_618102092productChooser'
	 */

    [Bindable(event="propertyChange")]
    public function get productChooser():com.atensys.imake.draw.ProductChooser
    {
        return this._618102092productChooser;
    }

    public function set productChooser(value:com.atensys.imake.draw.ProductChooser):void
    {
    	var oldValue:Object = this._618102092productChooser;
        if (oldValue !== value)
        {
            this._618102092productChooser = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "productChooser", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property productColorsPanel (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'productColorsPanel' moved to '_1719598587productColorsPanel'
	 */

    [Bindable(event="propertyChange")]
    public function get productColorsPanel():com.atensys.imake.draw.colors.ProductColorSwatches
    {
        return this._1719598587productColorsPanel;
    }

    public function set productColorsPanel(value:com.atensys.imake.draw.colors.ProductColorSwatches):void
    {
    	var oldValue:Object = this._1719598587productColorsPanel;
        if (oldValue !== value)
        {
            this._1719598587productColorsPanel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "productColorsPanel", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property productParts (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'productParts' moved to '_1000151857productParts'
	 */

    [Bindable(event="propertyChange")]
    public function get productParts():mx.controls.TileList
    {
        return this._1000151857productParts;
    }

    public function set productParts(value:mx.controls.TileList):void
    {
    	var oldValue:Object = this._1000151857productParts;
        if (oldValue !== value)
        {
            this._1000151857productParts = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "productParts", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property rootSplit (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'rootSplit' moved to '_878188712rootSplit'
	 */

    [Bindable(event="propertyChange")]
    public function get rootSplit():mx.containers.HBox
    {
        return this._878188712rootSplit;
    }

    public function set rootSplit(value:mx.containers.HBox):void
    {
    	var oldValue:Object = this._878188712rootSplit;
        if (oldValue !== value)
        {
            this._878188712rootSplit = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rootSplit", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property toolbar (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'toolbar' moved to '_1140094085toolbar'
	 */

    [Bindable(event="propertyChange")]
    public function get toolbar():com.atensys.imake.draw.ApplicationToolBar
    {
        return this._1140094085toolbar;
    }

    public function set toolbar(value:com.atensys.imake.draw.ApplicationToolBar):void
    {
    	var oldValue:Object = this._1140094085toolbar;
        if (oldValue !== value)
        {
            this._1140094085toolbar = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "toolbar", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property zoom (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'zoom' moved to '_3744723zoom'
	 */

    [Bindable(event="propertyChange")]
    public function get zoom():com.atensys.imake.draw.ZoomSlider
    {
        return this._3744723zoom;
    }

    public function set zoom(value:com.atensys.imake.draw.ZoomSlider):void
    {
    	var oldValue:Object = this._3744723zoom;
        if (oldValue !== value)
        {
            this._3744723zoom = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "zoom", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property layerData (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'layerData' moved to '_1664931685layerData'
	 */

    [Bindable(event="propertyChange")]
    public function get layerData():ArrayCollection
    {
        return this._1664931685layerData;
    }

    public function set layerData(value:ArrayCollection):void
    {
    	var oldValue:Object = this._1664931685layerData;
        if (oldValue !== value)
        {
            this._1664931685layerData = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "layerData", oldValue, value));
        }
    }



}
