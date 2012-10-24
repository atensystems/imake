






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
public class _drawerWatcherSetupUtil extends Sprite
    implements mx.binding.IWatcherSetupUtil
{
    public function _drawerWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import drawer;
        (drawer).watcherSetupUtil = new _drawerWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import flash.events.EventDispatcher;
        import mx.core.DeferredInstanceFromFunction;
        import mx.skins.halo.ButtonBarButtonSkin;
        import com.atensys.imake.draw.Pallete;
        import com.atensys.imake.draw.ZoomSlider;
        import mx.containers.HBox;
        import mx.controls.TileList;
        import com.atensys.imake.draw.colors.ColorsPallete;
        import mx.core.IDeferredInstance;
        import mx.core.Application;
        import mx.core.ClassFactory;
        import com.atensys.imake.draw.DrawDesktop;
        import mx.core.mx_internal;
        import __AS3__.vec.Vector;
        import com.atensys.imake.draw.colors.PartRenderer;
        import mx.core.IPropertyChangeNotifier;
        import mx.containers.Panel;
        import mx.utils.ObjectProxy;
        import mx.utils.UIDUtil;
        import com.atensys.imake.draw.colors.Swatches;
        import mx.events.ListEvent;
        import mx.binding.IBindingClient;
        import mx.events.FlexEvent;
        import com.atensys.imake.draw.layers.LayersView;
        import com.atensys.imake.draw.ProductChooser;
        import com.atensys.imake.draw.layers.PreviewLayerIR;
        import mx.core.UIComponentDescriptor;
        import mx.containers.VBox;
        import mx.collections.ArrayCollection;
        import mx.events.PropertyChangeEvent;
        import flash.events.Event;
        import mx.core.IFactory;
        import com.atensys.imake.draw.colors.ProductColorSwatches;
        import mx.core.DeferredInstanceFromClass;
        import mx.binding.BindingManager;
        import com.atensys.imake.draw.ApplicationToolBar;
        import flash.events.IEventDispatcher;

        // writeWatcher id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[0] = new mx.binding.PropertyWatcher("pallete",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=0 size=2
        [
        bindings[1],
        bindings[0]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=2 shouldWriteSelf=false class=flex2.compiler.as3.binding.FunctionReturnWatcher shouldWriteChildren=true

        // writeWatcher id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[1] = new mx.binding.PropertyWatcher("width",
            {
                widthChanged: true
            }
,         // writeWatcherListeners id=1 size=1
        [
        bindings[0]
        ]
,
                                                                 null
);

        // writeWatcher id=3 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[3] = new mx.binding.PropertyWatcher("colorSwatchesPanel",
            {
                propertyChange: true
            }
,         // writeWatcherListeners id=3 size=2
        [
        bindings[2],
        bindings[3]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=4 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[4] = new mx.binding.PropertyWatcher("width",
            {
                widthChanged: true
            }
,         // writeWatcherListeners id=4 size=2
        [
        bindings[2],
        bindings[3]
        ]
,
                                                                 null
);


        // writeWatcherBottom id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].updateParent(target);

 





        // writeWatcherBottom id=2 shouldWriteSelf=false class=flex2.compiler.as3.binding.FunctionReturnWatcher

 





        // writeWatcherBottom id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].addChild(watchers[1]);

 





        // writeWatcherBottom id=3 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[3].updateParent(target);

 





        // writeWatcherBottom id=4 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[3].addChild(watchers[4]);

 





    }
}

}
