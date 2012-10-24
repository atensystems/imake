

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.ButtonBar;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property editButtons (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'editButtons' moved to '_2124409367editButtons'
	 */

    [Bindable(event="propertyChange")]
    public function get editButtons():mx.controls.ButtonBar
    {
        return this._2124409367editButtons;
    }

    public function set editButtons(value:mx.controls.ButtonBar):void
    {
    	var oldValue:Object = this._2124409367editButtons;
        if (oldValue !== value)
        {
            this._2124409367editButtons = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "editButtons", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property saveLoad (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'saveLoad' moved to '_2072841213saveLoad'
	 */

    [Bindable(event="propertyChange")]
    public function get saveLoad():mx.controls.ButtonBar
    {
        return this._2072841213saveLoad;
    }

    public function set saveLoad(value:mx.controls.ButtonBar):void
    {
    	var oldValue:Object = this._2072841213saveLoad;
        if (oldValue !== value)
        {
            this._2072841213saveLoad = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "saveLoad", oldValue, value));
        }
    }



}
