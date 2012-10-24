

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.DataGrid;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property layersGrid (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'layersGrid' moved to '_30645336layersGrid'
	 */

    [Bindable(event="propertyChange")]
    public function get layersGrid():mx.controls.DataGrid
    {
        return this._30645336layersGrid;
    }

    public function set layersGrid(value:mx.controls.DataGrid):void
    {
    	var oldValue:Object = this._30645336layersGrid;
        if (oldValue !== value)
        {
            this._30645336layersGrid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "layersGrid", oldValue, value));
        }
    }



}
