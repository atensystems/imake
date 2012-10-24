






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
public class _com_atensys_imake_draw_ZoomSliderWatcherSetupUtil extends Sprite
    implements mx.binding.IWatcherSetupUtil
{
    public function _com_atensys_imake_draw_ZoomSliderWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import com.atensys.imake.draw.ZoomSlider;
        (com.atensys.imake.draw.ZoomSlider).watcherSetupUtil = new _com_atensys_imake_draw_ZoomSliderWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import mx.core.DeferredInstanceFromFunction;
        import flash.events.EventDispatcher;
        import mx.containers.HBox;
        import mx.utils.UIDUtil;
        import flash.events.MouseEvent;
        import mx.controls.HSlider;
        import mx.binding.IBindingClient;
        import mx.core.IDeferredInstance;
        import mx.core.Application;
        import mx.events.SliderEvent;
        import mx.core.ClassFactory;
        import mx.core.UIComponentDescriptor;
        import mx.core.mx_internal;
        import __AS3__.vec.Vector;
        import mx.events.PropertyChangeEvent;
        import mx.controls.Image;
        import mx.core.IPropertyChangeNotifier;
        import flash.events.Event;
        import mx.core.IFactory;
        import mx.core.DeferredInstanceFromClass;
        import mx.utils.ObjectProxy;
        import mx.controls.Label;
        import mx.binding.BindingManager;
        import flash.events.IEventDispatcher;

        // writeWatcher id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[0] = new mx.binding.PropertyWatcher("zoomSlider",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=0 size=1
        [
        bindings[0]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[1] = new mx.binding.PropertyWatcher("value",
            {
                valueCommit: true,
                change: true
            }
,         // writeWatcherListeners id=1 size=1
        [
        bindings[0]
        ]
,
                                                                 null
);


        // writeWatcherBottom id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].updateParent(target);

 





        // writeWatcherBottom id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].addChild(watchers[1]);

 





    }
}

}
