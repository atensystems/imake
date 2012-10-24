package
{

import flash.text.Font;
import flash.text.TextFormat;
import flash.system.ApplicationDomain;
import flash.utils.getDefinitionByName;
import mx.core.IFlexModule;
import mx.core.IFlexModuleFactory;
import mx.core.EmbeddedFontRegistry;

import mx.managers.SystemManager;

[ResourceBundle("SharedResources")]
[ResourceBundle("collections")]
[ResourceBundle("containers")]
[ResourceBundle("controls")]
[ResourceBundle("core")]
[ResourceBundle("effects")]
[ResourceBundle("formatters")]
[ResourceBundle("skins")]
[ResourceBundle("styles")]
[ResourceBundle("validators")]
public class _drawer_mx_managers_SystemManager
    extends mx.managers.SystemManager
    implements IFlexModuleFactory
{
    // Cause the CrossDomainRSLItem class to be linked into this application.
    import mx.core.CrossDomainRSLItem; CrossDomainRSLItem;

    public function _drawer_mx_managers_SystemManager()
    {

        super();
    }

    override     public function create(... params):Object
    {
        if (params.length > 0 && !(params[0] is String))
            return super.create.apply(this, params);

        var mainClassName:String = params.length == 0 ? "drawer" : String(params[0]);
        var mainClass:Class = Class(getDefinitionByName(mainClassName));
        if (!mainClass)
            return null;

        var instance:Object = new mainClass();
        if (instance is IFlexModule)
            (IFlexModule(instance)).moduleFactory = this;
        if (params.length == 0)
            EmbeddedFontRegistry.registerFonts(info()["fonts"], this);
        return instance;
    }

    override    public function info():Object
    {
        return {
            applicationComplete: "applicationComplete(event)",
            cdRsls: [{"rsls":["framework_3.2.0.3958.swz","framework_3.2.0.3958.swf"],
"policyFiles":["",""]
,"digests":["1c04c61346a1fa3139a37d860ed92632aa13decf4c17903367141677aac966f4",""],
"types":["SHA-256","SHA-256"],
"isSigned":[true,false]
}]
,
            compiledLocales: [ "en_US" ],
            compiledResourceBundleNames: [ "SharedResources", "collections", "containers", "controls", "core", "effects", "formatters", "skins", "styles", "validators" ],
            currentDomain: ApplicationDomain.currentDomain,
            fonts:       {
"ADrinkForAllAges" : {regular:true, bold:false, italic:false, boldItalic:false}
,
"Abite" : {regular:true, bold:false, italic:false, boldItalic:false}
,
"Arial" : {regular:true, bold:true, italic:true, boldItalic:true}
,
"CourierNew" : {regular:true, bold:true, italic:true, boldItalic:true}
,
"Intellivised" : {regular:true, bold:true, italic:true, boldItalic:true}
,
"Pixel" : {regular:true, bold:false, italic:false, boldItalic:false}
,
"Tahoma" : {regular:true, bold:true, italic:false, boldItalic:false}
,
"Verdana" : {regular:true, bold:true, italic:true, boldItalic:true}
}
,
            horizontalScrollPolicy: "off",
            mainClassName: "drawer",
            mixins: [ "_drawer_FlexInit", "_alertButtonStyleStyle", "_ScrollBarStyle", "_TabStyle", "_ToolTipStyle", "_ComboBoxStyle", "_comboDropdownStyle", "_CheckBoxStyle", "_ListBaseStyle", "_globalStyle", "_windowStylesStyle", "_PanelStyle", "_activeButtonStyleStyle", "_HSliderStyle", "_ApplicationControlBarStyle", "_errorTipStyle", "_CursorManagerStyle", "_dateFieldPopupStyle", "_ButtonBarButtonStyle", "_dataGridStylesStyle", "_TitleWindowStyle", "_AlertStyle", "_VRuleStyle", "_RadioButtonStyle", "_DataGridItemRendererStyle", "_ColorPickerStyle", "_ControlBarStyle", "_activeTabStyleStyle", "_TabBarStyle", "_textAreaHScrollBarStyleStyle", "_DragManagerStyle", "_advancedDataGridStylesStyle", "_TextAreaStyle", "_ContainerStyle", "_textAreaVScrollBarStyleStyle", "_linkButtonStyleStyle", "_windowStatusStyle", "_richTextEditorTextAreaStyleStyle", "_todayStyleStyle", "_TextInputStyle", "_ButtonBarStyle", "_TabNavigatorStyle", "_plainStyle", "_SwatchPanelStyle", "_ApplicationStyle", "_SWFLoaderStyle", "_headerDateTextStyle", "_ButtonStyle", "_DataGridStyle", "_popUpMenuStyle", "_opaquePanelStyle", "_swatchPanelTextFieldStyle", "_weekDayStyleStyle", "_headerDragProxyStyleStyle", "_TileListStyle", "_drawerWatcherSetupUtil", "_com_atensys_imake_draw_layers_LayersViewWatcherSetupUtil", "_com_atensys_imake_draw_ZoomSliderWatcherSetupUtil", "_com_atensys_imake_draw_colors_PartRendererWatcherSetupUtil", "_com_atensys_imake_draw_layers_LayersView_inlineComponent1WatcherSetupUtil", "_com_atensys_imake_draw_colors_advancedColorPickerWatcherSetupUtil", "_com_atensys_imake_draw_colors_ProductRendererWatcherSetupUtil", "_com_atensys_imake_draw_effect_ListItemRendererWatcherSetupUtil" ],
            paddingBottom: "0",
            paddingLeft: "0",
            paddingRight: "0",
            paddingTop: "0",
            verticalScrollPolicy: "off"
        }
    }
}

}
