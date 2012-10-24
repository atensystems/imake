

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.Image;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property productImage (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'productImage' moved to '_994027948productImage'
	 */

    [Bindable(event="propertyChange")]
    public function get productImage():mx.controls.Image
    {
        return this._994027948productImage;
    }

    public function set productImage(value:mx.controls.Image):void
    {
    	var oldValue:Object = this._994027948productImage;
        if (oldValue !== value)
        {
            this._994027948productImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "productImage", oldValue, value));
        }
    }



}
