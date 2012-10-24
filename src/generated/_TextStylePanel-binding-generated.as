

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
	 * generated bindable wrapper for property bold (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'bold' moved to '_3029637bold'
	 */

    [Bindable(event="propertyChange")]
    private function get bold():Class
    {
        return this._3029637bold;
    }

    private function set bold(value:Class):void
    {
    	var oldValue:Object = this._3029637bold;
        if (oldValue !== value)
        {
            this._3029637bold = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bold", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property italic (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'italic' moved to '_1178781136italic'
	 */

    [Bindable(event="propertyChange")]
    private function get italic():Class
    {
        return this._1178781136italic;
    }

    private function set italic(value:Class):void
    {
    	var oldValue:Object = this._1178781136italic;
        if (oldValue !== value)
        {
            this._1178781136italic = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "italic", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property underline (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'underline' moved to '_1026963764underline'
	 */

    [Bindable(event="propertyChange")]
    private function get underline():Class
    {
        return this._1026963764underline;
    }

    private function set underline(value:Class):void
    {
    	var oldValue:Object = this._1026963764underline;
        if (oldValue !== value)
        {
            this._1026963764underline = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "underline", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property bulet (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'bulet' moved to '_94097640bulet'
	 */

    [Bindable(event="propertyChange")]
    private function get bulet():Class
    {
        return this._94097640bulet;
    }

    private function set bulet(value:Class):void
    {
    	var oldValue:Object = this._94097640bulet;
        if (oldValue !== value)
        {
            this._94097640bulet = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bulet", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property align_left (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'align_left' moved to '_1043178239align_left'
	 */

    [Bindable(event="propertyChange")]
    private function get align_left():Class
    {
        return this._1043178239align_left;
    }

    private function set align_left(value:Class):void
    {
    	var oldValue:Object = this._1043178239align_left;
        if (oldValue !== value)
        {
            this._1043178239align_left = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "align_left", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property align_center (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'align_center' moved to '_2024328497align_center'
	 */

    [Bindable(event="propertyChange")]
    private function get align_center():Class
    {
        return this._2024328497align_center;
    }

    private function set align_center(value:Class):void
    {
    	var oldValue:Object = this._2024328497align_center;
        if (oldValue !== value)
        {
            this._2024328497align_center = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "align_center", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property align_right (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'align_right' moved to '_2026873954align_right'
	 */

    [Bindable(event="propertyChange")]
    private function get align_right():Class
    {
        return this._2026873954align_right;
    }

    private function set align_right(value:Class):void
    {
    	var oldValue:Object = this._2026873954align_right;
        if (oldValue !== value)
        {
            this._2026873954align_right = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "align_right", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property align_justify (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'align_justify' moved to '_244395178align_justify'
	 */

    [Bindable(event="propertyChange")]
    private function get align_justify():Class
    {
        return this._244395178align_justify;
    }

    private function set align_justify(value:Class):void
    {
    	var oldValue:Object = this._244395178align_justify;
        if (oldValue !== value)
        {
            this._244395178align_justify = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "align_justify", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property togle (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'togle' moved to '_110537669togle'
	 */

    [Bindable(event="propertyChange")]
    private function get togle():ArrayCollection
    {
        return this._110537669togle;
    }

    private function set togle(value:ArrayCollection):void
    {
    	var oldValue:Object = this._110537669togle;
        if (oldValue !== value)
        {
            this._110537669togle = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "togle", oldValue, value));
        }
    }



}
