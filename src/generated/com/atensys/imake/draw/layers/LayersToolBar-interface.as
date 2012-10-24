
package com.atensys.imake.draw.layers
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
import mx.containers.HBox;
import mx.controls.Button;
import mx.controls.Label;
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.mx_internal;
import mx.styles.*;
import mx.containers.HBox;

public class LayersToolBar extends mx.containers.HBox
{
	public function LayersToolBar() {}

	[Bindable]
	public var title : mx.controls.Label;
	[Bindable]
	public var deleteLayer : mx.controls.Button;
	[Bindable]
	public var mergeLayers : mx.controls.Button;

	mx_internal var _bindings : Array;
	mx_internal var _watchers : Array;
	mx_internal var _bindingsByDestination : Object;
	mx_internal var _bindingsBeginWithWord : Object;

include "D:/Work/imake.md/imake/src/com/atensys/imake/draw/layers/LayersToolBar.mxml:4,41";

}}
