

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import Class;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property flipHor (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'flipHor' moved to '_771577698flipHor'
	 */

    [Bindable(event="propertyChange")]
    private function get flipHor():Class
    {
        return this._771577698flipHor;
    }

    private function set flipHor(value:Class):void
    {
    	var oldValue:Object = this._771577698flipHor;
        if (oldValue !== value)
        {
            this._771577698flipHor = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "flipHor", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property flipVer (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'flipVer' moved to '_771564554flipVer'
	 */

    [Bindable(event="propertyChange")]
    private function get flipVer():Class
    {
        return this._771564554flipVer;
    }

    private function set flipVer(value:Class):void
    {
    	var oldValue:Object = this._771564554flipVer;
        if (oldValue !== value)
        {
            this._771564554flipVer = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "flipVer", oldValue, value));
        }
    }



}
