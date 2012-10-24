

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
	 * generated bindable wrapper for property pointerImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'pointerImage' moved to '_1945708258pointerImage'
	 */

    [Bindable(event="propertyChange")]
    private function get pointerImage():Class
    {
        return this._1945708258pointerImage;
    }

    private function set pointerImage(value:Class):void
    {
    	var oldValue:Object = this._1945708258pointerImage;
        if (oldValue !== value)
        {
            this._1945708258pointerImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pointerImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property pencilImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'pencilImage' moved to '_713733042pencilImage'
	 */

    [Bindable(event="propertyChange")]
    private function get pencilImage():Class
    {
        return this._713733042pencilImage;
    }

    private function set pencilImage(value:Class):void
    {
    	var oldValue:Object = this._713733042pencilImage;
        if (oldValue !== value)
        {
            this._713733042pencilImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pencilImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property paintBucketImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'paintBucketImage' moved to '_875398573paintBucketImage'
	 */

    [Bindable(event="propertyChange")]
    private function get paintBucketImage():Class
    {
        return this._875398573paintBucketImage;
    }

    private function set paintBucketImage(value:Class):void
    {
    	var oldValue:Object = this._875398573paintBucketImage;
        if (oldValue !== value)
        {
            this._875398573paintBucketImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "paintBucketImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property lineImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'lineImage' moved to '_1816600121lineImage'
	 */

    [Bindable(event="propertyChange")]
    private function get lineImage():Class
    {
        return this._1816600121lineImage;
    }

    private function set lineImage(value:Class):void
    {
    	var oldValue:Object = this._1816600121lineImage;
        if (oldValue !== value)
        {
            this._1816600121lineImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lineImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property brushImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'brushImage' moved to '_2107414081brushImage'
	 */

    [Bindable(event="propertyChange")]
    private function get brushImage():Class
    {
        return this._2107414081brushImage;
    }

    private function set brushImage(value:Class):void
    {
    	var oldValue:Object = this._2107414081brushImage;
        if (oldValue !== value)
        {
            this._2107414081brushImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "brushImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property eracerImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'eracerImage' moved to '_2037981121eracerImage'
	 */

    [Bindable(event="propertyChange")]
    private function get eracerImage():Class
    {
        return this._2037981121eracerImage;
    }

    private function set eracerImage(value:Class):void
    {
    	var oldValue:Object = this._2037981121eracerImage;
        if (oldValue !== value)
        {
            this._2037981121eracerImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "eracerImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property rectangleImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'rectangleImage' moved to '_844110124rectangleImage'
	 */

    [Bindable(event="propertyChange")]
    private function get rectangleImage():Class
    {
        return this._844110124rectangleImage;
    }

    private function set rectangleImage(value:Class):void
    {
    	var oldValue:Object = this._844110124rectangleImage;
        if (oldValue !== value)
        {
            this._844110124rectangleImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rectangleImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property circleImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'circleImage' moved to '_86999445circleImage'
	 */

    [Bindable(event="propertyChange")]
    private function get circleImage():Class
    {
        return this._86999445circleImage;
    }

    private function set circleImage(value:Class):void
    {
    	var oldValue:Object = this._86999445circleImage;
        if (oldValue !== value)
        {
            this._86999445circleImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "circleImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property textImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'textImage' moved to '_1058101202textImage'
	 */

    [Bindable(event="propertyChange")]
    private function get textImage():Class
    {
        return this._1058101202textImage;
    }

    private function set textImage(value:Class):void
    {
    	var oldValue:Object = this._1058101202textImage;
        if (oldValue !== value)
        {
            this._1058101202textImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "textImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property eyedropperImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'eyedropperImage' moved to '_2144023842eyedropperImage'
	 */

    [Bindable(event="propertyChange")]
    private function get eyedropperImage():Class
    {
        return this._2144023842eyedropperImage;
    }

    private function set eyedropperImage(value:Class):void
    {
    	var oldValue:Object = this._2144023842eyedropperImage;
        if (oldValue !== value)
        {
            this._2144023842eyedropperImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "eyedropperImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property selectImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'selectImage' moved to '_194920895selectImage'
	 */

    [Bindable(event="propertyChange")]
    private function get selectImage():Class
    {
        return this._194920895selectImage;
    }

    private function set selectImage(value:Class):void
    {
    	var oldValue:Object = this._194920895selectImage;
        if (oldValue !== value)
        {
            this._194920895selectImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "selectImage", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property imageImage (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'imageImage' moved to '_1463308096imageImage'
	 */

    [Bindable(event="propertyChange")]
    private function get imageImage():Class
    {
        return this._1463308096imageImage;
    }

    private function set imageImage(value:Class):void
    {
    	var oldValue:Object = this._1463308096imageImage;
        if (oldValue !== value)
        {
            this._1463308096imageImage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imageImage", oldValue, value));
        }
    }



}
