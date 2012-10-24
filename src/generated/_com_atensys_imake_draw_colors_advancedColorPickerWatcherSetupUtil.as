






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
public class _com_atensys_imake_draw_colors_advancedColorPickerWatcherSetupUtil extends Sprite
    implements mx.binding.IWatcherSetupUtil
{
    public function _com_atensys_imake_draw_colors_advancedColorPickerWatcherSetupUtil()
    {
        super();
    }

    public static function init(fbs:IFlexModuleFactory):void
    {
        import com.atensys.imake.draw.colors.advancedColorPicker;
        (com.atensys.imake.draw.colors.advancedColorPicker).watcherSetupUtil = new _com_atensys_imake_draw_colors_advancedColorPickerWatcherSetupUtil();
    }

    public function setup(target:Object,
                          propertyGetter:Function,
                          bindings:Array,
                          watchers:Array):void
    {
        import mx.core.DeferredInstanceFromFunction;
        import mx.events.CloseEvent;
        import flash.events.EventDispatcher;
        import mx.graphics.GradientEntry;
        import flash.utils.getTimer;
        import mx.core.UIComponent;
        import mx.managers.PopUpManager;
        import mx.containers.TitleWindow;
        import mx.core.IDeferredInstance;
        import mx.events.MoveEvent;
        import mx.core.Application;
        import mx.binding.utils.BindingUtils;
        import mx.core.ClassFactory;
        import mx.core.mx_internal;
        import __AS3__.vec.Vector;
        import mx.controls.TextInput;
        import mx.core.IPropertyChangeNotifier;
        import mx.utils.ObjectProxy;
        import mx.controls.Label;
        import mx.events.ResizeEvent;
        import mx.containers.Canvas;
        import mx.managers.CursorManager;
        import mx.controls.Button;
        import mx.utils.UIDUtil;
        import mx.controls.Alert;
        import flash.events.MouseEvent;
        import mx.events.DragEvent;
        import mx.containers.Box;
        import mx.binding.IBindingClient;
        import mx.events.FlexEvent;
        import mx.binding.utils.ChangeWatcher;
        import mx.core.UIComponentDescriptor;
        import mx.events.PropertyChangeEvent;
        import mx.controls.Image;
        import flash.events.Event;
        import mx.core.IFactory;
        import mx.graphics.RadialGradient;
        import mx.core.DeferredInstanceFromClass;
        import mx.binding.BindingManager;
        import flash.events.IEventDispatcher;
        import mx.controls.RadioButton;

        // writeWatcher id=8 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[8] = new mx.binding.PropertyWatcher("displayBlue",
            {
                colorChanged: true
            }
,         // writeWatcherListeners id=8 size=1
        [
        bindings[8]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[0] = new mx.binding.PropertyWatcher("currentColor",
            {
                colorChanged: true
            }
,         // writeWatcherListeners id=0 size=1
        [
        bindings[0]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=6 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[6] = new mx.binding.PropertyWatcher("displayRed",
            {
                colorChanged: true
            }
,         // writeWatcherListeners id=6 size=1
        [
        bindings[6]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=3 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[3] = new mx.binding.PropertyWatcher("displaySaturation",
            {
                colorChanged: true
            }
,         // writeWatcherListeners id=3 size=1
        [
        bindings[3]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=7 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[7] = new mx.binding.PropertyWatcher("displayGreen",
            {
                colorChanged: true
            }
,         // writeWatcherListeners id=7 size=1
        [
        bindings[7]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=4 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[4] = new mx.binding.PropertyWatcher("displayLightness",
            {
                colorChanged: true
            }
,         // writeWatcherListeners id=4 size=1
        [
        bindings[4]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=2 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[2] = new mx.binding.PropertyWatcher("displayHue",
            {
                colorChanged: true
            }
,         // writeWatcherListeners id=2 size=1
        [
        bindings[2]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=5 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[5] = new mx.binding.PropertyWatcher("hex",
            {
                colorChanged: true
            }
,         // writeWatcherListeners id=5 size=1
        [
        bindings[5]
        ]
,
                                                                 propertyGetter
);

        // writeWatcher id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher shouldWriteChildren=true
        watchers[1] = new mx.binding.PropertyWatcher("previousColor",
            {
                colorChanged: true
            }
,         // writeWatcherListeners id=1 size=1
        [
        bindings[1]
        ]
,
                                                                 propertyGetter
);


        // writeWatcherBottom id=8 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[8].updateParent(target);

 





        // writeWatcherBottom id=0 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[0].updateParent(target);

 





        // writeWatcherBottom id=6 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[6].updateParent(target);

 





        // writeWatcherBottom id=3 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[3].updateParent(target);

 





        // writeWatcherBottom id=7 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[7].updateParent(target);

 





        // writeWatcherBottom id=4 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[4].updateParent(target);

 





        // writeWatcherBottom id=2 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[2].updateParent(target);

 





        // writeWatcherBottom id=5 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[5].updateParent(target);

 





        // writeWatcherBottom id=1 shouldWriteSelf=true class=flex2.compiler.as3.binding.PropertyWatcher
        watchers[1].updateParent(target);

 





    }
}

}
