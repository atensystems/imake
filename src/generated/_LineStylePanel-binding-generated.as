

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.collections.ArrayCollection;
import Class;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property square (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'square' moved to '_894674659square'
	 */

    [Bindable(event="propertyChange")]
    private function get square():Class
    {
        return this._894674659square;
    }

    private function set square(value:Class):void
    {
    	var oldValue:Object = this._894674659square;
        if (oldValue !== value)
        {
            this._894674659square = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "square", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property round (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'round' moved to '_108704142round'
	 */

    [Bindable(event="propertyChange")]
    private function get round():Class
    {
        return this._108704142round;
    }

    private function set round(value:Class):void
    {
    	var oldValue:Object = this._108704142round;
        if (oldValue !== value)
        {
            this._108704142round = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "round", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property caps (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'caps' moved to '_3046113caps'
	 */

    [Bindable(event="propertyChange")]
    private function get caps():ArrayCollection
    {
        return this._3046113caps;
    }

    private function set caps(value:ArrayCollection):void
    {
    	var oldValue:Object = this._3046113caps;
        if (oldValue !== value)
        {
            this._3046113caps = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "caps", oldValue, value));
        }
    }



}
