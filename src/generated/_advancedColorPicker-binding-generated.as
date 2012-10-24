

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.Button;
import mx.controls.Image;
import mx.controls.TextInput;
import mx.containers.Canvas;
import mx.controls.RadioButton;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property btncancel (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'btncancel' moved to '_1034057686btncancel'
	 */

    [Bindable(event="propertyChange")]
    public function get btncancel():mx.controls.Button
    {
        return this._1034057686btncancel;
    }

    public function set btncancel(value:mx.controls.Button):void
    {
    	var oldValue:Object = this._1034057686btncancel;
        if (oldValue !== value)
        {
            this._1034057686btncancel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "btncancel", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property btnok (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'btnok' moved to '_94070072btnok'
	 */

    [Bindable(event="propertyChange")]
    public function get btnok():mx.controls.Button
    {
        return this._94070072btnok;
    }

    public function set btnok(value:mx.controls.Button):void
    {
    	var oldValue:Object = this._94070072btnok;
        if (oldValue !== value)
        {
            this._94070072btnok = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "btnok", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property csBlue (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'csBlue' moved to '_1352402710csBlue'
	 */

    [Bindable(event="propertyChange")]
    public function get csBlue():mx.controls.RadioButton
    {
        return this._1352402710csBlue;
    }

    public function set csBlue(value:mx.controls.RadioButton):void
    {
    	var oldValue:Object = this._1352402710csBlue;
        if (oldValue !== value)
        {
            this._1352402710csBlue = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "csBlue", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property csGreen (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'csGreen' moved to '_1029970035csGreen'
	 */

    [Bindable(event="propertyChange")]
    public function get csGreen():mx.controls.RadioButton
    {
        return this._1029970035csGreen;
    }

    public function set csGreen(value:mx.controls.RadioButton):void
    {
    	var oldValue:Object = this._1029970035csGreen;
        if (oldValue !== value)
        {
            this._1029970035csGreen = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "csGreen", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property csHue (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'csHue' moved to '_94927464csHue'
	 */

    [Bindable(event="propertyChange")]
    public function get csHue():mx.controls.RadioButton
    {
        return this._94927464csHue;
    }

    public function set csHue(value:mx.controls.RadioButton):void
    {
    	var oldValue:Object = this._94927464csHue;
        if (oldValue !== value)
        {
            this._94927464csHue = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "csHue", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property csLightness (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'csLightness' moved to '_238332451csLightness'
	 */

    [Bindable(event="propertyChange")]
    public function get csLightness():mx.controls.RadioButton
    {
        return this._238332451csLightness;
    }

    public function set csLightness(value:mx.controls.RadioButton):void
    {
    	var oldValue:Object = this._238332451csLightness;
        if (oldValue !== value)
        {
            this._238332451csLightness = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "csLightness", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property csRed (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'csRed' moved to '_94936577csRed'
	 */

    [Bindable(event="propertyChange")]
    public function get csRed():mx.controls.RadioButton
    {
        return this._94936577csRed;
    }

    public function set csRed(value:mx.controls.RadioButton):void
    {
    	var oldValue:Object = this._94936577csRed;
        if (oldValue !== value)
        {
            this._94936577csRed = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "csRed", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property csSaturation (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'csSaturation' moved to '_1166284898csSaturation'
	 */

    [Bindable(event="propertyChange")]
    public function get csSaturation():mx.controls.RadioButton
    {
        return this._1166284898csSaturation;
    }

    public function set csSaturation(value:mx.controls.RadioButton):void
    {
    	var oldValue:Object = this._1166284898csSaturation;
        if (oldValue !== value)
        {
            this._1166284898csSaturation = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "csSaturation", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property cvsCurr (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'cvsCurr' moved to '_1155108018cvsCurr'
	 */

    [Bindable(event="propertyChange")]
    public function get cvsCurr():mx.containers.Canvas
    {
        return this._1155108018cvsCurr;
    }

    public function set cvsCurr(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._1155108018cvsCurr;
        if (oldValue !== value)
        {
            this._1155108018cvsCurr = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "cvsCurr", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property cvsPrev (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'cvsPrev' moved to '_1155492019cvsPrev'
	 */

    [Bindable(event="propertyChange")]
    public function get cvsPrev():mx.containers.Canvas
    {
        return this._1155492019cvsPrev;
    }

    public function set cvsPrev(value:mx.containers.Canvas):void
    {
    	var oldValue:Object = this._1155492019cvsPrev;
        if (oldValue !== value)
        {
            this._1155492019cvsPrev = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "cvsPrev", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property maincp (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'maincp' moved to '_1081571354maincp'
	 */

    [Bindable(event="propertyChange")]
    public function get maincp():mx.controls.Image
    {
        return this._1081571354maincp;
    }

    public function set maincp(value:mx.controls.Image):void
    {
    	var oldValue:Object = this._1081571354maincp;
        if (oldValue !== value)
        {
            this._1081571354maincp = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maincp", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property subcp (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'subcp' moved to '_109787821subcp'
	 */

    [Bindable(event="propertyChange")]
    public function get subcp():mx.controls.Image
    {
        return this._109787821subcp;
    }

    public function set subcp(value:mx.controls.Image):void
    {
    	var oldValue:Object = this._109787821subcp;
        if (oldValue !== value)
        {
            this._109787821subcp = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "subcp", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property t_blue (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 't_blue' moved to '_883224251t_blue'
	 */

    [Bindable(event="propertyChange")]
    public function get t_blue():mx.controls.TextInput
    {
        return this._883224251t_blue;
    }

    public function set t_blue(value:mx.controls.TextInput):void
    {
    	var oldValue:Object = this._883224251t_blue;
        if (oldValue !== value)
        {
            this._883224251t_blue = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "t_blue", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property t_green (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 't_green' moved to '_1605366920t_green'
	 */

    [Bindable(event="propertyChange")]
    public function get t_green():mx.controls.TextInput
    {
        return this._1605366920t_green;
    }

    public function set t_green(value:mx.controls.TextInput):void
    {
    	var oldValue:Object = this._1605366920t_green;
        if (oldValue !== value)
        {
            this._1605366920t_green = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "t_green", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property t_hex (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 't_hex' moved to '_110061776t_hex'
	 */

    [Bindable(event="propertyChange")]
    public function get t_hex():mx.controls.TextInput
    {
        return this._110061776t_hex;
    }

    public function set t_hex(value:mx.controls.TextInput):void
    {
    	var oldValue:Object = this._110061776t_hex;
        if (oldValue !== value)
        {
            this._110061776t_hex = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "t_hex", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property t_hue (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 't_hue' moved to '_110062253t_hue'
	 */

    [Bindable(event="propertyChange")]
    public function get t_hue():mx.controls.TextInput
    {
        return this._110062253t_hue;
    }

    public function set t_hue(value:mx.controls.TextInput):void
    {
    	var oldValue:Object = this._110062253t_hue;
        if (oldValue !== value)
        {
            this._110062253t_hue = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "t_hue", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property t_lightness (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 't_lightness' moved to '_1204567650t_lightness'
	 */

    [Bindable(event="propertyChange")]
    public function get t_lightness():mx.controls.TextInput
    {
        return this._1204567650t_lightness;
    }

    public function set t_lightness(value:mx.controls.TextInput):void
    {
    	var oldValue:Object = this._1204567650t_lightness;
        if (oldValue !== value)
        {
            this._1204567650t_lightness = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "t_lightness", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property t_red (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 't_red' moved to '_110071366t_red'
	 */

    [Bindable(event="propertyChange")]
    public function get t_red():mx.controls.TextInput
    {
        return this._110071366t_red;
    }

    public function set t_red(value:mx.controls.TextInput):void
    {
    	var oldValue:Object = this._110071366t_red;
        if (oldValue !== value)
        {
            this._110071366t_red = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "t_red", oldValue, value));
        }
    }

	/**
	 * generated bindable wrapper for property t_saturation (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 't_saturation' moved to '_1348452227t_saturation'
	 */

    [Bindable(event="propertyChange")]
    public function get t_saturation():mx.controls.TextInput
    {
        return this._1348452227t_saturation;
    }

    public function set t_saturation(value:mx.controls.TextInput):void
    {
    	var oldValue:Object = this._1348452227t_saturation;
        if (oldValue !== value)
        {
            this._1348452227t_saturation = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "t_saturation", oldValue, value));
        }
    }



}
