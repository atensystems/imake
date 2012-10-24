

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.collections.ArrayCollection;
import Class;
import com.atensys.imake.draw.component.ComponentResizeContainer;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property sourceComponent (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'sourceComponent' moved to '_719011038sourceComponent'
	 */

    [Bindable(event="propertyChange")]
    public function get sourceComponent():ComponentResizeContainer
    {
        return this._719011038sourceComponent;
    }

    public function set sourceComponent(value:ComponentResizeContainer):void
    {
    	var oldValue:Object = this._719011038sourceComponent;
        if (oldValue !== value)
        {
            this._719011038sourceComponent = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sourceComponent", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property imgMoveForward (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'imgMoveForward' moved to '_1927620111imgMoveForward'
	 */

    [Bindable(event="propertyChange")]
    private function get imgMoveForward():Class
    {
        return this._1927620111imgMoveForward;
    }

    private function set imgMoveForward(value:Class):void
    {
    	var oldValue:Object = this._1927620111imgMoveForward;
        if (oldValue !== value)
        {
            this._1927620111imgMoveForward = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imgMoveForward", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property imgMoveBackward (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'imgMoveBackward' moved to '_2011982391imgMoveBackward'
	 */

    [Bindable(event="propertyChange")]
    private function get imgMoveBackward():Class
    {
        return this._2011982391imgMoveBackward;
    }

    private function set imgMoveBackward(value:Class):void
    {
    	var oldValue:Object = this._2011982391imgMoveBackward;
        if (oldValue !== value)
        {
            this._2011982391imgMoveBackward = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imgMoveBackward", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property imgCopy (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'imgCopy' moved to '_1916412376imgCopy'
	 */

    [Bindable(event="propertyChange")]
    private function get imgCopy():Class
    {
        return this._1916412376imgCopy;
    }

    private function set imgCopy(value:Class):void
    {
    	var oldValue:Object = this._1916412376imgCopy;
        if (oldValue !== value)
        {
            this._1916412376imgCopy = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imgCopy", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property imgCut (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'imgCut' moved to '_1185106049imgCut'
	 */

    [Bindable(event="propertyChange")]
    private function get imgCut():Class
    {
        return this._1185106049imgCut;
    }

    private function set imgCut(value:Class):void
    {
    	var oldValue:Object = this._1185106049imgCut;
        if (oldValue !== value)
        {
            this._1185106049imgCut = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imgCut", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property imgFlipVertical (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'imgFlipVertical' moved to '_2049282458imgFlipVertical'
	 */

    [Bindable(event="propertyChange")]
    private function get imgFlipVertical():Class
    {
        return this._2049282458imgFlipVertical;
    }

    private function set imgFlipVertical(value:Class):void
    {
    	var oldValue:Object = this._2049282458imgFlipVertical;
        if (oldValue !== value)
        {
            this._2049282458imgFlipVertical = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imgFlipVertical", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property imgFlipHorizontal (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'imgFlipHorizontal' moved to '_1083336940imgFlipHorizontal'
	 */

    [Bindable(event="propertyChange")]
    private function get imgFlipHorizontal():Class
    {
        return this._1083336940imgFlipHorizontal;
    }

    private function set imgFlipHorizontal(value:Class):void
    {
    	var oldValue:Object = this._1083336940imgFlipHorizontal;
        if (oldValue !== value)
        {
            this._1083336940imgFlipHorizontal = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imgFlipHorizontal", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property dpMoveForwardBackward (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'dpMoveForwardBackward' moved to '_1919542667dpMoveForwardBackward'
	 */

    [Bindable(event="propertyChange")]
    private function get dpMoveForwardBackward():ArrayCollection
    {
        return this._1919542667dpMoveForwardBackward;
    }

    private function set dpMoveForwardBackward(value:ArrayCollection):void
    {
    	var oldValue:Object = this._1919542667dpMoveForwardBackward;
        if (oldValue !== value)
        {
            this._1919542667dpMoveForwardBackward = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "dpMoveForwardBackward", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property dpCopyCut (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'dpCopyCut' moved to '_112410527dpCopyCut'
	 */

    [Bindable(event="propertyChange")]
    private function get dpCopyCut():ArrayCollection
    {
        return this._112410527dpCopyCut;
    }

    private function set dpCopyCut(value:ArrayCollection):void
    {
    	var oldValue:Object = this._112410527dpCopyCut;
        if (oldValue !== value)
        {
            this._112410527dpCopyCut = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "dpCopyCut", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property dpFlipVerticalHorizontal (private)
	 * - generated setter
	 * - generated getter
	 * - original private var 'dpFlipVerticalHorizontal' moved to '_1722832691dpFlipVerticalHorizontal'
	 */

    [Bindable(event="propertyChange")]
    private function get dpFlipVerticalHorizontal():ArrayCollection
    {
        return this._1722832691dpFlipVerticalHorizontal;
    }

    private function set dpFlipVerticalHorizontal(value:ArrayCollection):void
    {
    	var oldValue:Object = this._1722832691dpFlipVerticalHorizontal;
        if (oldValue !== value)
        {
            this._1722832691dpFlipVerticalHorizontal = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "dpFlipVerticalHorizontal", oldValue, value));
        }
    }



}
