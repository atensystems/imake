

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
	 * generated bindable wrapper for property iconSymbol (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'iconSymbol' moved to '_492527759iconSymbol'
	 */

    [Bindable(event="propertyChange")]
    public function get iconSymbol():Class
    {
        return this._492527759iconSymbol;
    }

    public function set iconSymbol(value:Class):void
    {
    	var oldValue:Object = this._492527759iconSymbol;
        if (oldValue !== value)
        {
            this._492527759iconSymbol = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "iconSymbol", oldValue, value));
        }
    }



}
