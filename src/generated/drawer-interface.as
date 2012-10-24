
package 
{
import com.atensys.imake.draw.ApplicationToolBar;
import com.atensys.imake.draw.DrawDesktop;
import com.atensys.imake.draw.Pallete;
import com.atensys.imake.draw.ProductChooser;
import com.atensys.imake.draw.ZoomSlider;
import com.atensys.imake.draw.colors.ProductColorSwatches;
import com.atensys.imake.draw.colors.Swatches;
import com.atensys.imake.draw.layers.LayersView;
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
import mx.containers.Panel;
import mx.controls.TileList;
import mx.core.Application;
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.mx_internal;
import mx.styles.*;
import mx.containers.VBox;
import mx.containers.Panel;
import Object;
import mx.core.Application;

public class drawer extends mx.core.Application
{
	public function drawer() {}

	[Bindable]
	public var toolbar : com.atensys.imake.draw.ApplicationToolBar;
	[Bindable]
	public var rootSplit : mx.containers.HBox;
	[Bindable]
	public var pallete : com.atensys.imake.draw.Pallete;
	[Bindable]
	public var productChooser : com.atensys.imake.draw.ProductChooser;
	[Bindable]
	public var productParts : mx.controls.TileList;
	[Bindable]
	public var desktop : com.atensys.imake.draw.DrawDesktop;
	[Bindable]
	public var colorSwatchesPanel : mx.containers.Panel;
	[Bindable]
	public var colorsPanel : com.atensys.imake.draw.colors.Swatches;
	[Bindable]
	public var productColorsPanel : com.atensys.imake.draw.colors.ProductColorSwatches;
	[Bindable]
	public var zoom : com.atensys.imake.draw.ZoomSlider;
	[Bindable]
	public var layersView : com.atensys.imake.draw.layers.LayersView;
	[Bindable]
	public var brushes : Array;

	mx_internal var _bindings : Array;
	mx_internal var _watchers : Array;
	mx_internal var _bindingsByDestination : Object;
	mx_internal var _bindingsBeginWithWord : Object;

include "D:/Work/imake.md/imake/src/drawer.mxml:17,31";

}}
