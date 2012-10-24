

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.Button;
import mx.controls.Label;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property deleteLayer (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'deleteLayer' moved to '_1139920282deleteLayer'
	 */

    [Bindable(event="propertyChange")]
    public function get deleteLayer():mx.controls.Button
    {
        return this._1139920282deleteLayer;
    }

    public function set deleteLayer(value:mx.controls.Button):void
    {
    	var oldValue:Object = this._1139920282deleteLayer;
        if (oldValue !== value)
        {
            this._1139920282deleteLayer = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "deleteLayer", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property mergeLayers (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'mergeLayers' moved to '_25076838mergeLayers'
	 */

    [Bindable(event="propertyChange")]
    public function get mergeLayers():mx.controls.Button
    {
        return this._25076838mergeLayers;
    }

    public function set mergeLayers(value:mx.controls.Button):void
    {
    	var oldValue:Object = this._25076838mergeLayers;
        if (oldValue !== value)
        {
            this._25076838mergeLayers = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mergeLayers", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property title (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'title' moved to '_110371416title'
	 */

    [Bindable(event="propertyChange")]
    public function get title():mx.controls.Label
    {
        return this._110371416title;
    }

    public function set title(value:mx.controls.Label):void
    {
    	var oldValue:Object = this._110371416title;
        if (oldValue !== value)
        {
            this._110371416title = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "title", oldValue, value));
        }
    }



}
