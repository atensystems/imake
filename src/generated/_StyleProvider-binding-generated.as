

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;


class BindableProperty
{
	/**
	 * generated bindable wrapper for property currentStylePanel (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'currentStylePanel' moved to '_1070315820currentStylePanel'
	 */

    [Bindable(event="propertyChange")]
    public function get currentStylePanel():DStylePanel
    {
        return this._1070315820currentStylePanel;
    }

    public function set currentStylePanel(value:DStylePanel):void
    {
    	var oldValue:Object = this._1070315820currentStylePanel;
        if (oldValue !== value)
        {
            this._1070315820currentStylePanel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "currentStylePanel", oldValue, value));
        }
    }



}
