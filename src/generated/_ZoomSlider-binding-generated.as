

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.HSlider;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property zoomSlider (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'zoomSlider' moved to '_652534124zoomSlider'
	 */

    [Bindable(event="propertyChange")]
    public function get zoomSlider():mx.controls.HSlider
    {
        return this._652534124zoomSlider;
    }

    public function set zoomSlider(value:mx.controls.HSlider):void
    {
    	var oldValue:Object = this._652534124zoomSlider;
        if (oldValue !== value)
        {
            this._652534124zoomSlider = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "zoomSlider", oldValue, value));
        }
    }



}
