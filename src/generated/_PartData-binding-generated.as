

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import String;
import flash.geom.Point;

class BindableProperty
    implements flash.events.IEventDispatcher
{
	/**
	 * generated bindable wrapper for property thumbnailImage (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'thumbnailImage' moved to '_739449807thumbnailImage'
	 */

    [Bindable(event="propertyChange")]
    public function get thumbnailImage():String
    {
        return this._739449807thumbnailImage;
    }

    public function set thumbnailImage(value:String):void
    {
    	var oldValue:Object = this._739449807thumbnailImage;
        if (oldValue !== value)
        {
            this._739449807thumbnailImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "thumbnailImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property label (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'label' moved to '_102727412label'
	 */

    [Bindable(event="propertyChange")]
    public function get label():String
    {
        return this._102727412label;
    }

    public function set label(value:String):void
    {
    	var oldValue:Object = this._102727412label;
        if (oldValue !== value)
        {
            this._102727412label = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "label", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property ptl (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'ptl' moved to '_111336ptl'
	 */

    [Bindable(event="propertyChange")]
    public function get ptl():Point
    {
        return this._111336ptl;
    }

    public function set ptl(value:Point):void
    {
    	var oldValue:Object = this._111336ptl;
        if (oldValue !== value)
        {
            this._111336ptl = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "ptl", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property pbr (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'pbr' moved to '_110784pbr'
	 */

    [Bindable(event="propertyChange")]
    public function get pbr():Point
    {
        return this._110784pbr;
    }

    public function set pbr(value:Point):void
    {
    	var oldValue:Object = this._110784pbr;
        if (oldValue !== value)
        {
            this._110784pbr = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pbr", oldValue, value));
        }
    }


    //    IEventDispatcher implementation
    //
    private var _bindingEventDispatcher:flash.events.EventDispatcher =
        new flash.events.EventDispatcher(flash.events.IEventDispatcher(this));

    public function addEventListener(type:String, listener:Function,
                                     useCapture:Boolean = false,
                                     priority:int = 0,
                                     weakRef:Boolean = false):void
    {
        _bindingEventDispatcher.addEventListener(type, listener, useCapture,
                                                 priority, weakRef);
    }

    public function dispatchEvent(event:flash.events.Event):Boolean
    {
        return _bindingEventDispatcher.dispatchEvent(event);
    }

    public function hasEventListener(type:String):Boolean
    {
        return _bindingEventDispatcher.hasEventListener(type);
    }

    public function removeEventListener(type:String,
                                        listener:Function,
                                        useCapture:Boolean = false):void
    {
        _bindingEventDispatcher.removeEventListener(type, listener, useCapture);
    }

    public function willTrigger(type:String):Boolean
    {
        return _bindingEventDispatcher.willTrigger(type);
    }

}
