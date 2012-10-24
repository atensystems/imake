

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.CheckBox;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property checkBox (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'checkBox' moved to '_1536861091checkBox'
	 */

    [Bindable(event="propertyChange")]
    public function get checkBox():mx.controls.CheckBox
    {
        return this._1536861091checkBox;
    }

    public function set checkBox(value:mx.controls.CheckBox):void
    {
    	var oldValue:Object = this._1536861091checkBox;
        if (oldValue !== value)
        {
            this._1536861091checkBox = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "checkBox", oldValue, value));
        }
    }



}
