

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
	 * generated bindable wrapper for property selectBrushIcon (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'selectBrushIcon' moved to '_614211273selectBrushIcon'
	 */

    [Bindable(event="propertyChange")]
    private function get selectBrushIcon():Class
    {
        return this._614211273selectBrushIcon;
    }

    private function set selectBrushIcon(value:Class):void
    {
    	var oldValue:Object = this._614211273selectBrushIcon;
        if (oldValue !== value)
        {
            this._614211273selectBrushIcon = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "selectBrushIcon", oldValue, value));
        }
    }



}
