

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
	 * generated bindable wrapper for property nev (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'nev' moved to '_108959nev'
	 */

    [Bindable(event="propertyChange")]
    private function get nev():Class
    {
        return this._108959nev;
    }

    private function set nev(value:Class):void
    {
    	var oldValue:Object = this._108959nev;
        if (oldValue !== value)
        {
            this._108959nev = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "nev", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property add (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'add' moved to '_96417add'
	 */

    [Bindable(event="propertyChange")]
    private function get add():Class
    {
        return this._96417add;
    }

    private function set add(value:Class):void
    {
    	var oldValue:Object = this._96417add;
        if (oldValue !== value)
        {
            this._96417add = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "add", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property del (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'del' moved to '_99339del'
	 */

    [Bindable(event="propertyChange")]
    private function get del():Class
    {
        return this._99339del;
    }

    private function set del(value:Class):void
    {
    	var oldValue:Object = this._99339del;
        if (oldValue !== value)
        {
            this._99339del = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "del", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property rectangle (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'rectangle' moved to '_1121299823rectangle'
	 */

    [Bindable(event="propertyChange")]
    private function get rectangle():Class
    {
        return this._1121299823rectangle;
    }

    private function set rectangle(value:Class):void
    {
    	var oldValue:Object = this._1121299823rectangle;
        if (oldValue !== value)
        {
            this._1121299823rectangle = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rectangle", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property ellipse (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'ellipse' moved to '_1656480802ellipse'
	 */

    [Bindable(event="propertyChange")]
    private function get ellipse():Class
    {
        return this._1656480802ellipse;
    }

    private function set ellipse(value:Class):void
    {
    	var oldValue:Object = this._1656480802ellipse;
        if (oldValue !== value)
        {
            this._1656480802ellipse = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "ellipse", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property lasso (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'lasso' moved to '_102744186lasso'
	 */

    [Bindable(event="propertyChange")]
    private function get lasso():Class
    {
        return this._102744186lasso;
    }

    private function set lasso(value:Class):void
    {
    	var oldValue:Object = this._102744186lasso;
        if (oldValue !== value)
        {
            this._102744186lasso = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lasso", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property mode (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'mode' moved to '_3357091mode'
	 */

    [Bindable(event="propertyChange")]
    private function get mode():ArrayCollection
    {
        return this._3357091mode;
    }

    private function set mode(value:ArrayCollection):void
    {
    	var oldValue:Object = this._3357091mode;
        if (oldValue !== value)
        {
            this._3357091mode = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mode", oldValue, value));
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

	/**
	 * generated bindable wrapper for property colors (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'colors' moved to '_1354842768colors'
	 */

    [Bindable(event="propertyChange")]
    private function get colors():ArrayCollection
    {
        return this._1354842768colors;
    }

    private function set colors(value:ArrayCollection):void
    {
    	var oldValue:Object = this._1354842768colors;
        if (oldValue !== value)
        {
            this._1354842768colors = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "colors", oldValue, value));
        }
    }



}
