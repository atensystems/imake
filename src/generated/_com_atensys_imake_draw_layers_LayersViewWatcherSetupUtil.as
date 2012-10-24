






package
{
import flash.display.Sprite;
import mx.core.IFlexModuleFactory;
import mx.binding.ArrayElementWatcher;
import mx.binding.FunctionReturnWatcher;
import mx.binding.IWatcherSetupUtil;
import mx.binding.PropertyWatcher;
import mx.binding.RepeaterComponentWatcher;
import mx.binding.RepeaterItemWatcher;
import mx.binding.StaticPropertyWatcher;
import mx.binding.XMLWatcher;
import mx.binding.Watcher;

[ExcludeClass]
[Mixin]
public class _com_atensys_imake_draw_layers_LayersViewWatcherSetupUtil extends Sprite
    implements mx.binding.IWatcherSetupUtil
{
    public function _com_atensys_imake_draw_layers_LayersViewWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import com.atensys.imake.draw.layers.LayersView;
        (com.atensys.imake.draw.layers.LayersView).watcherSetupUtil = new _com_atensys_imake_draw_layers_LayersViewWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import flash.events.EventDispatcher;
        import mx.core.DeferredInstanceFromFunction;
        import mx.controls.dataGridClasses.DataGridColumn;
        import mx.core.IDeferredInstance;
        import mx.core.Application;
        import mx.core.ClassFactory;
        import mx.core.mx_internal;
        import __AS3__.vec.Vector;
        import mx.core.IPropertyChangeNotifier;
        import mx.containers.Panel;
        import mx.utils.ObjectProxy;
        import mx.utils.UIDUtil;
        import mx.events.DragEvent;
        import mx.controls.DataGrid;
        import mx.events.ListEvent;
        import mx.binding.IBindingClient;
        import mx.events.FlexEvent;
        import com.atensys.imake.draw.layers.PreviewLayerIR;
        import com.atensys.imake.draw.layers.LayersView_inlineComponent1;
        import mx.core.UIComponentDescriptor;
        import mx.events.PropertyChangeEvent;
        import flash.events.Event;
        import mx.core.IFactory;
        import mx.core.DeferredInstanceFromClass;
        import mx.binding.BindingManager;
        import flash.events.IEventDispatcher;

        // writeWatcher id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[0] = new mx.binding.StaticPropertyWatcher("application",
            null
,         // writeWatcherListeners id=0 size=1
        [
        bindings[0]
        ]
,
                                                                 null
);

        // writeWatcher id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[1] = new mx.binding.PropertyWatcher("layerData",
            null
,         // writeWatcherListeners id=1 size=1
        [
        bindings[0]
        ]
,
                                                                 null
);


        // writeWatcherBottom id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        import mx.core.Application;
        watchers[0].updateParent(mx.core.Application);

 





        // writeWatcherBottom id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].addChild(watchers[1]);

 





    }
}

}
