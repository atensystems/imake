

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
	 * generated bindable wrapper for property checkbox (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'checkbox' moved to '_1536891843checkbox'
	 */

    [Bindable(event="propertyChange")]
    public function get checkbox():mx.controls.CheckBox
    {
        return this._1536891843checkbox;
    }

    public function set checkbox(value:mx.controls.CheckBox):void
    {
    	var oldValue:Object = this._1536891843checkbox;
        if (oldValue !== value)
        {
            this._1536891843checkbox = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "checkbox", oldValue, value));
        }
    }



}
