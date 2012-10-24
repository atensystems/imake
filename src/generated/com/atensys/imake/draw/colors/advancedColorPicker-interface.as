
package com.atensys.imake.draw.colors
{
import flash.accessibility.*;
import flash.debugger.*;
import flash.display.*;
import flash.errors.*;
import flash.events.*;
import flash.external.*;
import flash.filters.*;
import flash.geom.*;
import flash.media.*;
import flash.net.*;
import flash.printing.*;
import flash.profiler.*;
import flash.system.*;
import flash.text.*;
import flash.ui.*;
import flash.utils.*;
import flash.xml.*;
import mx.binding.*;
import mx.containers.Canvas;
import mx.containers.TitleWindow;
import mx.controls.Button;
import mx.controls.Image;
import mx.controls.RadioButton;
import mx.controls.TextInput;
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.mx_internal;
import mx.styles.*;
import mx.containers.Box;
import mx.containers.TitleWindow;
import mx.controls.Label;
import mx.containers.Canvas;

public class advancedColorPicker extends mx.containers.TitleWindow
{
	public function advancedColorPicker() {}

	[Bindable]
	public var maincp : mx.controls.Image;
	[Bindable]
	public var subcp : mx.controls.Image;
	[Bindable]
	public var cvsCurr : mx.containers.Canvas;
	[Bindable]
	public var cvsPrev : mx.containers.Canvas;
	[Bindable]
	public var csHue : mx.controls.RadioButton;
	[Bindable]
	public var t_hue : mx.controls.TextInput;
	[Bindable]
	public var csSaturation : mx.controls.RadioButton;
	[Bindable]
	public var t_saturation : mx.controls.TextInput;
	[Bindable]
	public var csLightness : mx.controls.RadioButton;
	[Bindable]
	public var t_lightness : mx.controls.TextInput;
	[Bindable]
	public var t_hex : mx.controls.TextInput;
	[Bindable]
	public var csRed : mx.controls.RadioButton;
	[Bindable]
	public var t_red : mx.controls.TextInput;
	[Bindable]
	public var csGreen : mx.controls.RadioButton;
	[Bindable]
	public var t_green : mx.controls.TextInput;
	[Bindable]
	public var csBlue : mx.controls.RadioButton;
	[Bindable]
	public var t_blue : mx.controls.TextInput;
	[Bindable]
	public var btnok : mx.controls.Button;
	[Bindable]
	public var btncancel : mx.controls.Button;

	mx_internal var _bindings : Array;
	mx_internal var _watchers : Array;
	mx_internal var _bindingsByDestination : Object;
	mx_internal var _bindingsBeginWithWord : Object;

include "D:/Work/imake.md/imake/src/com/atensys/imake/draw/colors/advancedColorPicker.mxml:5,1147";

}}
