
/**
 * 	Generated by mxmlc 2.0
 *
 *	Package:	
 *	Class: 		drawer
 *	Source: 	D:\Work\imake.md\imake\src\drawer.mxml
 *	Template: 	flex2/compiler/mxml/gen/ClassDef.vm
 *	Time: 		2010.12.20 07:02:36 EET
 */

package 
{

import com.atensys.imake.draw.ApplicationToolBar;
import com.atensys.imake.draw.DrawDesktop;
import com.atensys.imake.draw.Pallete;
import com.atensys.imake.draw.ProductChooser;
import com.atensys.imake.draw.ZoomSlider;
import com.atensys.imake.draw.colors.ColorsPallete;
import com.atensys.imake.draw.colors.PartRenderer;
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
import mx.binding.IBindingClient;
import mx.containers.HBox;
import mx.containers.Panel;
import mx.containers.VBox;
import mx.controls.TileList;
import mx.core.Application;
import mx.core.ClassFactory;
import mx.core.DeferredInstanceFromClass;
import mx.core.DeferredInstanceFromFunction;
import mx.core.IDeferredInstance;
import mx.core.IFactory;
import mx.core.IPropertyChangeNotifier;
import mx.core.UIComponentDescriptor;
import mx.core.mx_internal;
import mx.events.FlexEvent;
import mx.events.ListEvent;
import mx.styles.*;


[Frame(extraClass="_drawer_FlexInit")]

[Frame(factoryClass="_drawer_mx_managers_SystemManager")]


//	begin class def

public class drawer
	extends mx.core.Application
	implements mx.binding.IBindingClient
{

	//	instance variables
/**
 * @private
 **/
	public var _drawer_Panel1 : mx.containers.Panel;

/**
 * @private
 **/
	public var _drawer_Panel3 : mx.containers.Panel;

	[Bindable]
/**
 * @private
 **/
	public var brushes : Array;

	[Bindable]
/**
 * @private
 **/
	public var colorSwatchesPanel : mx.containers.Panel;

	[Bindable]
/**
 * @private
 **/
	public var colorsPanel : com.atensys.imake.draw.colors.Swatches;

	[Bindable]
/**
 * @private
 **/
	public var desktop : com.atensys.imake.draw.DrawDesktop;

	[Bindable]
/**
 * @private
 **/
	public var layersView : com.atensys.imake.draw.layers.LayersView;

	[Bindable]
/**
 * @private
 **/
	public var pallete : com.atensys.imake.draw.Pallete;

	[Bindable]
/**
 * @private
 **/
	public var productChooser : com.atensys.imake.draw.ProductChooser;

	[Bindable]
/**
 * @private
 **/
	public var productColorsPanel : com.atensys.imake.draw.colors.ProductColorSwatches;

	[Bindable]
/**
 * @private
 **/
	public var productParts : mx.controls.TileList;

	[Bindable]
/**
 * @private
 **/
	public var rootSplit : mx.containers.HBox;

	[Bindable]
/**
 * @private
 **/
	public var toolbar : com.atensys.imake.draw.ApplicationToolBar;

	[Bindable]
/**
 * @private
 **/
	public var zoom : com.atensys.imake.draw.ZoomSlider;


	//	type-import dummies


	//	Container document descriptor
private var _documentDescriptor_ : mx.core.UIComponentDescriptor = 
new mx.core.UIComponentDescriptor({
  type: mx.core.Application
  ,
  propertiesFactory: function():Object { return {
    childDescriptors: [
      new mx.core.UIComponentDescriptor({
        type: com.atensys.imake.draw.ApplicationToolBar
        ,
        id: "toolbar"
        ,
        propertiesFactory: function():Object { return {
          percentWidth: 100.0
        }}
      })
    ,
      new mx.core.UIComponentDescriptor({
        type: mx.containers.HBox
        ,
        id: "rootSplit"
        ,
        propertiesFactory: function():Object { return {
          percentWidth: 100.0,
          percentHeight: 100.0,
          childDescriptors: [
            new mx.core.UIComponentDescriptor({
              type: mx.containers.VBox
              ,
              propertiesFactory: function():Object { return {
                childDescriptors: [
                  new mx.core.UIComponentDescriptor({
                    type: com.atensys.imake.draw.Pallete
                    ,
                    id: "pallete"
                    ,
                    events: {
                      creationComplete: "__pallete_creationComplete"
                    }
                  })
                ,
                  new mx.core.UIComponentDescriptor({
                    type: com.atensys.imake.draw.ProductChooser
                    ,
                    id: "productChooser"
                  })
                ,
                  new mx.core.UIComponentDescriptor({
                    type: mx.containers.Panel
                    ,
                    id: "_drawer_Panel1"
                    ,
                    stylesFactory: function():void {
                      this.backgroundAlpha = 0.2;
                    }
                    ,
                    propertiesFactory: function():Object { return {
                      title: "Parts",
                      percentHeight: 100.0,
                      childDescriptors: [
                        new mx.core.UIComponentDescriptor({
                          type: mx.controls.TileList
                          ,
                          id: "productParts"
                          ,
                          events: {
                            change: "__productParts_change"
                          }
                          ,
                          stylesFactory: function():void {
                            this.backgroundAlpha = 0.2;
                          }
                          ,
                          propertiesFactory: function():Object { return {
                            width: 60,
                            percentHeight: 100.0,
                            maxColumns: 1,
                            itemRenderer: _drawer_ClassFactory1_c()
                          }}
                        })
                      ]
                    }}
                  })
                ]
              }}
            })
          ,
            new mx.core.UIComponentDescriptor({
              type: com.atensys.imake.draw.DrawDesktop
              ,
              id: "desktop"
              ,
              stylesFactory: function():void {
                this.backgroundAlpha = 0.2;
                this.verticalAlign = "middle";
                this.horizontalAlign = "center";
              }
              ,
              propertiesFactory: function():Object { return {
                percentWidth: 100.0,
                percentHeight: 100.0,
                horizontalScrollPolicy: "auto",
                verticalScrollPolicy: "auto"
              }}
            })
          ,
            new mx.core.UIComponentDescriptor({
              type: mx.containers.VBox
              ,
              propertiesFactory: function():Object { return {
                percentHeight: 100.0,
                childDescriptors: [
                  new mx.core.UIComponentDescriptor({
                    type: mx.containers.Panel
                    ,
                    id: "colorSwatchesPanel"
                    ,
                    stylesFactory: function():void {
                      this.backgroundAlpha = 0.5;
                    }
                    ,
                    propertiesFactory: function():Object { return {
                      title: "Colors",
                      childDescriptors: [
                        new mx.core.UIComponentDescriptor({
                          type: com.atensys.imake.draw.colors.Swatches
                          ,
                          id: "colorsPanel"
                        })
                      ]
                    }}
                  })
                ,
                  new mx.core.UIComponentDescriptor({
                    type: mx.containers.Panel
                    ,
                    id: "_drawer_Panel3"
                    ,
                    stylesFactory: function():void {
                      this.backgroundAlpha = 0.5;
                    }
                    ,
                    propertiesFactory: function():Object { return {
                      title: "Product Colors",
                      childDescriptors: [
                        new mx.core.UIComponentDescriptor({
                          type: com.atensys.imake.draw.colors.ProductColorSwatches
                          ,
                          id: "productColorsPanel"
                        })
                      ]
                    }}
                  })
                ,
                  new mx.core.UIComponentDescriptor({
                    type: com.atensys.imake.draw.ZoomSlider
                    ,
                    id: "zoom"
                  })
                ,
                  new mx.core.UIComponentDescriptor({
                    type: com.atensys.imake.draw.layers.LayersView
                    ,
                    id: "layersView"
                  })
                ]
              }}
            })
          ]
        }}
      })
    ]
  }}
})

	//	constructor (Flex display object)
    /**
     * @private
     **/
	public function drawer()
	{
		super();

		mx_internal::_document = this;

		//	our style settings
		//	initialize component styles
		if (!this.styleDeclaration)
		{
			this.styleDeclaration = new CSSStyleDeclaration();
		}

		this.styleDeclaration.defaultFactory = function():void
		{
			this.paddingTop = 0;
			this.paddingLeft = 0;
			this.paddingRight = 0;
			this.paddingBottom = 0;
		};


		//	ambient styles
		mx_internal::_drawer_StylesInit();

		//	properties
		this.horizontalScrollPolicy = "off";
		this.verticalScrollPolicy = "off";
		_drawer_Array1_i();

		//	events
		this.addEventListener("applicationComplete", ___drawer_Application1_applicationComplete);

	}

	//	initialize()
    /**
     * @private
     **/
	override public function initialize():void
	{
 		mx_internal::setDocumentDescriptor(_documentDescriptor_);

		var bindings:Array = _drawer_bindingsSetup();
		var watchers:Array = [];

		var target:drawer = this;

		if (_watcherSetupUtil == null)
		{
			var watcherSetupUtilClass:Object = getDefinitionByName("_drawerWatcherSetupUtil");
			watcherSetupUtilClass["init"](null);
		}

		_watcherSetupUtil.setup(this,
					function(propertyName:String):* { return target[propertyName]; },
					bindings,
					watchers);

		for (var i:uint = 0; i < bindings.length; i++)
		{
			Binding(bindings[i]).execute();
		}

		mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
		mx_internal::_watchers = mx_internal::_watchers.concat(watchers);


		super.initialize();
	}

	//	scripts
	//	<Script>, line 17 - 31

			import mx.skins.halo.ButtonBarButtonSkin;
			import com.atensys.imake.draw.layers.PreviewLayerIR;

			import mx.collections.ArrayCollection;
			import mx.events.FlexEvent;
			[Bindable]
			public var layerData:ArrayCollection=new ArrayCollection();

			protected function applicationComplete(event:FlexEvent):void {
				productChooser.getPopupList().selectedIndex=0;
				productChooser.getPopupList().selectFirstProduct();
				zoom.zoomSlider.value=101;
			}
		

	//	end scripts


    //	supporting function definitions for properties, events, styles, effects
private function _drawer_Array1_i() : Array
{
	var temp : Array = [{label: "", icon: _embed_mxml_assets_brushes_brush_1_png_238830127}, {label: "", icon: _embed_mxml_assets_brushes_brush_2_png_238858799}, {label: "", icon: _embed_mxml_assets_brushes_brush_3_png_234128943}, {label: "", icon: _embed_mxml_assets_brushes_dry_brush_1_png_196339625}, {label: "", icon: _embed_mxml_assets_brushes_dry_brush_2_png_194750377}, {label: "", icon: _embed_mxml_assets_brushes_chalk_1_png_2062762513}, {label: "", icon: _embed_mxml_assets_brushes_chalk_2_png_2060673297}, {label: "", icon: _embed_mxml_assets_brushes_chalk_3_png_2060165137}, {label: "", icon: _embed_mxml_assets_brushes_oil_brush_1_png_801343281}, {label: "", icon: _embed_mxml_assets_brushes_oil_brush_2_png_796943929}, {label: "", icon: _embed_mxml_assets_brushes_oil_brush_3_png_797157177}, {label: "", icon: _embed_mxml_assets_brushes_oil_brush_4_png_800819257}, {label: "", icon: _embed_mxml_assets_brushes_oil_brush_5_png_802940729}, {label: "", icon: _embed_mxml_assets_brushes_oil_brush_6_png_741582385}, {label: "", icon: _embed_mxml_assets_brushes_oil_brush_7_png_739477297}, {label: "", icon: _embed_mxml_assets_brushes_oil_brush_8_png_742097969}, {label: "", icon: _embed_mxml_assets_brushes_air_brush_1_png_60549073}, {label: "", icon: _embed_mxml_assets_brushes_air_brush_2_png_62629673}, {label: "", icon: _embed_mxml_assets_brushes_air_brush_3_png_63146025}, {label: "", icon: _embed_mxml_assets_brushes_air_brush_4_png_63137577}, {label: "", icon: _embed_mxml_assets_brushes_air_brush_5_png_37463593}, {label: "", icon: _embed_mxml_assets_brushes_circle_png_1397467351}, {label: "", icon: _embed_mxml_assets_brushes_ellipse_png_108279375}, {label: "", icon: _embed_mxml_assets_brushes_thin_ellipse_png_1941569113}, {label: "", icon: _embed_mxml_assets_brushes_diamond_png_2027060625}, {label: "", icon: _embed_mxml_assets_brushes_star_1_png_1400155983}, {label: "", icon: _embed_mxml_assets_brushes_star_2_png_1399598927}, {label: "", icon: _embed_mxml_assets_brushes_star_3_png_1397500231}, {label: "", icon: _embed_mxml_assets_brushes_hexagon_png_24396487}, {label: "", icon: _embed_mxml_assets_brushes_square_png_1442064751}, {label: "", icon: _embed_mxml_assets_brushes_moon_png_1543277271}, {label: "", icon: _embed_mxml_assets_brushes_triangle_png_363558087}, {label: "", icon: _embed_mxml_assets_brushes_leaf_1_png_1639198551}, {label: "", icon: _embed_mxml_assets_brushes_leaf_2_png_1643392855}, {label: "", icon: _embed_mxml_assets_brushes_leaf_3_png_1642899823}, {label: "", icon: _embed_mxml_assets_brushes_leaf_4_png_1640802671}, {label: "", icon: _embed_mxml_assets_brushes_heart_png_1965723855}, {label: "", icon: _embed_mxml_assets_brushes_club_png_1001097895}, {label: "", icon: _embed_mxml_assets_brushes_spade_png_2137489743}, {label: "", icon: _embed_mxml_assets_brushes_diamond_2_png_1129441969}, {label: "", icon: _embed_mxml_assets_brushes_diamond_icon_png_196768463}, {label: "", icon: _embed_mxml_assets_brushes_star_icon_1_png_1545307945}, {label: "", icon: _embed_mxml_assets_brushes_star_icon_2_png_1543742505}, {label: "", icon: _embed_mxml_assets_brushes_star_icon_3_png_1556342569}, {label: "", icon: _embed_mxml_assets_brushes_hexagon_icon_png_189420455}, {label: "", icon: _embed_mxml_assets_brushes_square_icon_png_600610903}, {label: "", icon: _embed_mxml_assets_brushes_moon_icon_png_1549728559}, {label: "", icon: _embed_mxml_assets_brushes_triangle_icon_png_695524121}, {label: "", icon: _embed_mxml_assets_brushes_spiral_png_2108959191}, {label: "", icon: _embed_mxml_assets_brushes_snowflake_png_952890855}, {label: "", icon: _embed_mxml_assets_brushes_ornament_png_2075722927}, {label: "", icon: _embed_mxml_assets_brushes_wheel_png_1021903831}, {label: "", icon: _embed_mxml_assets_brushes_jing_jang_png_1483396431}, {label: "", icon: _embed_mxml_assets_brushes_circle_icon_png_205236009}, {label: "", icon: _embed_mxml_assets_brushes_spatter_png_1983136359}, {label: "", icon: _embed_mxml_assets_brushes_radioactive_png_603756615}, {label: "", icon: _embed_mxml_assets_brushes_flora_1_png_1774958889}, {label: "", icon: _embed_mxml_assets_brushes_flora_2_png_1846265897}, {label: "", icon: _embed_mxml_assets_brushes_flora_3_png_1845754129}, {label: "", icon: _embed_mxml_assets_brushes_flora_4_png_1858316817}, {label: "", icon: _embed_mxml_assets_brushes_flora_5_png_1858829585}, {label: "", icon: _embed_mxml_assets_brushes_flora_6_png_1854622737}, {label: "", icon: _embed_mxml_assets_brushes_flora_7_png_1855175961}, {label: "", icon: _embed_mxml_assets_brushes_flora_8_png_1861476889}, {label: "", icon: _embed_mxml_assets_brushes_cube_png_1141437777}, {label: "", icon: _embed_mxml_assets_brushes_cube_invert_png_543455687}, {label: "", icon: _embed_mxml_assets_brushes_cat_png_1782659985}, {label: "", icon: _embed_mxml_assets_brushes_planet_1_png_1683551153}, {label: "", icon: _embed_mxml_assets_brushes_planet_2_png_1685369777}, {label: "", icon: _embed_mxml_assets_brushes_ball_png_1509640919}, {label: "", icon: _embed_mxml_assets_brushes_balls_png_945766639}, {label: "", icon: _embed_mxml_assets_brushes_drops_png_1738895153}];
	brushes = temp;
	return temp;
}

/**
 * @private
 **/
public function ___drawer_Application1_applicationComplete(event:mx.events.FlexEvent):void
{
	applicationComplete(event)
}

/**
 * @private
 **/
public function __pallete_creationComplete(event:mx.events.FlexEvent):void
{
	pallete.addColorsEvents()
}

private function _drawer_ClassFactory1_c() : mx.core.ClassFactory
{
	var temp : mx.core.ClassFactory = new mx.core.ClassFactory();
	temp.generator = com.atensys.imake.draw.colors.PartRenderer;
	return temp;
}

/**
 * @private
 **/
public function __productParts_change(event:mx.events.ListEvent):void
{
	{desktop.partChanged(event)}
}


	//	binding mgmt
    private function _drawer_bindingsSetup():Array
    {
        var result:Array = [];
        var binding:Binding;

        binding = new mx.binding.Binding(this,
            function():Number
            {
                return (pallete.width);
            },
            function(_sourceFunctionReturnValue:Number):void
            {
				
                _drawer_Panel1.width = _sourceFunctionReturnValue;
            },
            "_drawer_Panel1.width");
        result[0] = binding;
        binding = new mx.binding.Binding(this,
            function():com.atensys.imake.draw.colors.ColorsPallete
            {
                return (pallete.getColors());
            },
            function(_sourceFunctionReturnValue:com.atensys.imake.draw.colors.ColorsPallete):void
            {
				
                colorsPanel.colors = _sourceFunctionReturnValue;
            },
            "colorsPanel.colors");
        result[1] = binding;
        binding = new mx.binding.Binding(this,
            function():Number
            {
                return (colorSwatchesPanel.width);
            },
            function(_sourceFunctionReturnValue:Number):void
            {
				
                _drawer_Panel3.width = _sourceFunctionReturnValue;
            },
            "_drawer_Panel3.width");
        result[2] = binding;
        binding = new mx.binding.Binding(this,
            function():Number
            {
                return (colorSwatchesPanel.width);
            },
            function(_sourceFunctionReturnValue:Number):void
            {
				
                layersView.width = _sourceFunctionReturnValue;
            },
            "layersView.width");
        result[3] = binding;

        return result;
    }

    private function _drawer_bindingExprs():void
    {
        var destination:*;
		[Binding(id='0')]
		destination = (pallete.width);
		[Binding(id='1')]
		destination = (pallete.getColors());
		[Binding(id='2')]
		destination = (colorSwatchesPanel.width);
		[Binding(id='3')]
		destination = (colorSwatchesPanel.width);
    }

    /**
     * @private
     **/
    public static function set watcherSetupUtil(watcherSetupUtil:IWatcherSetupUtil):void
    {
        (drawer)._watcherSetupUtil = watcherSetupUtil;
    }

    private static var _watcherSetupUtil:IWatcherSetupUtil;

	//	initialize style defs for drawer

	mx_internal static var _drawer_StylesInit_done:Boolean = false;

	mx_internal function _drawer_StylesInit():void
	{
		//	only add our style defs to the StyleManager once
		if (mx_internal::_drawer_StylesInit_done)
			return;
		else
			mx_internal::_drawer_StylesInit_done = true;

		var style:CSSStyleDeclaration;
		var effects:Array;


		StyleManager.mx_internal::initProtoChainRoots();
	}


	//	embed carrier vars
[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', source='assets/fonts/ADrinkForAllAges.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='ADrinkForAllAges', _line='96')]
 private var _embed__font_ADrinkForAllAges_medium_normal_2050633986:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', source='assets/fonts/ABITE.ttf', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Abite', _line='91')]
 private var _embed__font_Abite_medium_normal_1583535619:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontWeight='bold', fontStyle='italic', source='assets/fonts/ARIALBI.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Arial', _line='68')]
 private var _embed__font_Arial_bold_italic_422370884:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontWeight='bold', source='assets/fonts/ARIALBD.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Arial', _line='56')]
 private var _embed__font_Arial_bold_normal_866554856:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontStyle='italic', source='assets/fonts/ARIALI.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Arial', _line='62')]
 private var _embed__font_Arial_medium_italic_1448597590:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', source='assets/fonts/ARIAL.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Arial', _line='51')]
 private var _embed__font_Arial_medium_normal_2088993131:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontWeight='bold', fontStyle='italic', source='assets/fonts/COURBI.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='CourierNew', _line='44')]
 private var _embed__font_CourierNew_bold_italic_2141842978:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontWeight='bold', source='assets/fonts/COURBD.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='CourierNew', _line='32')]
 private var _embed__font_CourierNew_bold_normal_1712339014:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontStyle='italic', source='assets/fonts/COURI.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='CourierNew', _line='38')]
 private var _embed__font_CourierNew_medium_italic_289075687:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', source='assets/fonts/cour.ttf', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='CourierNew', _line='27')]
 private var _embed__font_CourierNew_medium_normal_1612764144:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontWeight='bold', fontStyle='italic', source='assets/fonts/SFIntellivised-BoldItalic.ttf', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Intellivised', _line='118')]
 private var _embed__font_Intellivised_bold_italic_317682302:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontWeight='bold', source='assets/fonts/SFIntellivised-Bold.ttf', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Intellivised', _line='106')]
 private var _embed__font_Intellivised_bold_normal_1475568089:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontStyle='italic', source='assets/fonts/SFIntellivised-Italic.ttf', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Intellivised', _line='112')]
 private var _embed__font_Intellivised_medium_italic_1865184059:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', source='assets/fonts/SFIntellivised.ttf', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Intellivised', _line='101')]
 private var _embed__font_Intellivised_medium_normal_870386202:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', source='assets/fonts/graphicpixel.ttf', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Pixel', _line='86')]
 private var _embed__font_Pixel_medium_normal_1278024909:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontWeight='bold', source='assets/fonts/tahomabd.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Tahoma', _line='80')]
 private var _embed__font_Tahoma_bold_normal_179763215:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', source='assets/fonts/TAHOMA.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Tahoma', _line='75')]
 private var _embed__font_Tahoma_medium_normal_2128819367:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontWeight='bold', fontStyle='italic', source='assets/fonts/verdanaz.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Verdana', _line='20')]
 private var _embed__font_Verdana_bold_italic_244728411:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontWeight='bold', source='assets/fonts/verdanab.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Verdana', _line='8')]
 private var _embed__font_Verdana_bold_normal_523992343:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', fontStyle='italic', source='assets/fonts/verdanai.TTF', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Verdana', _line='14')]
 private var _embed__font_Verdana_medium_italic_474117399:Class;

[Embed(advancedAntiAliasing='true', mimeType='application/x-font', _pathsep='true', source='assets/fonts/verdana.ttf', _file='D:/Work/imake.md/imake/src/css/Fonts.css', fontName='Verdana', _line='3')]
 private var _embed__font_Verdana_medium_normal_1867231238:Class;

[Embed(source='assets/brushes/air_brush_1.png')]
 private var _embed_mxml_assets_brushes_air_brush_1_png_60549073:Class;

[Embed(source='assets/brushes/air_brush_2.png')]
 private var _embed_mxml_assets_brushes_air_brush_2_png_62629673:Class;

[Embed(source='assets/brushes/air_brush_3.png')]
 private var _embed_mxml_assets_brushes_air_brush_3_png_63146025:Class;

[Embed(source='assets/brushes/air_brush_4.png')]
 private var _embed_mxml_assets_brushes_air_brush_4_png_63137577:Class;

[Embed(source='assets/brushes/air_brush_5.png')]
 private var _embed_mxml_assets_brushes_air_brush_5_png_37463593:Class;

[Embed(source='assets/brushes/ball.png')]
 private var _embed_mxml_assets_brushes_ball_png_1509640919:Class;

[Embed(source='assets/brushes/balls.png')]
 private var _embed_mxml_assets_brushes_balls_png_945766639:Class;

[Embed(source='assets/brushes/brush_1.png')]
 private var _embed_mxml_assets_brushes_brush_1_png_238830127:Class;

[Embed(source='assets/brushes/brush_2.png')]
 private var _embed_mxml_assets_brushes_brush_2_png_238858799:Class;

[Embed(source='assets/brushes/brush_3.png')]
 private var _embed_mxml_assets_brushes_brush_3_png_234128943:Class;

[Embed(source='assets/brushes/cat.png')]
 private var _embed_mxml_assets_brushes_cat_png_1782659985:Class;

[Embed(source='assets/brushes/chalk_1.png')]
 private var _embed_mxml_assets_brushes_chalk_1_png_2062762513:Class;

[Embed(source='assets/brushes/chalk_2.png')]
 private var _embed_mxml_assets_brushes_chalk_2_png_2060673297:Class;

[Embed(source='assets/brushes/chalk_3.png')]
 private var _embed_mxml_assets_brushes_chalk_3_png_2060165137:Class;

[Embed(source='assets/brushes/circle_icon.png')]
 private var _embed_mxml_assets_brushes_circle_icon_png_205236009:Class;

[Embed(source='assets/brushes/circle.png')]
 private var _embed_mxml_assets_brushes_circle_png_1397467351:Class;

[Embed(source='assets/brushes/club.png')]
 private var _embed_mxml_assets_brushes_club_png_1001097895:Class;

[Embed(source='assets/brushes/cube_invert.png')]
 private var _embed_mxml_assets_brushes_cube_invert_png_543455687:Class;

[Embed(source='assets/brushes/cube.png')]
 private var _embed_mxml_assets_brushes_cube_png_1141437777:Class;

[Embed(source='assets/brushes/diamond_2.png')]
 private var _embed_mxml_assets_brushes_diamond_2_png_1129441969:Class;

[Embed(source='assets/brushes/diamond_icon.png')]
 private var _embed_mxml_assets_brushes_diamond_icon_png_196768463:Class;

[Embed(source='assets/brushes/diamond.png')]
 private var _embed_mxml_assets_brushes_diamond_png_2027060625:Class;

[Embed(source='assets/brushes/drops.png')]
 private var _embed_mxml_assets_brushes_drops_png_1738895153:Class;

[Embed(source='assets/brushes/dry_brush_1.png')]
 private var _embed_mxml_assets_brushes_dry_brush_1_png_196339625:Class;

[Embed(source='assets/brushes/dry_brush_2.png')]
 private var _embed_mxml_assets_brushes_dry_brush_2_png_194750377:Class;

[Embed(source='assets/brushes/ellipse.png')]
 private var _embed_mxml_assets_brushes_ellipse_png_108279375:Class;

[Embed(source='assets/brushes/flora_1.png')]
 private var _embed_mxml_assets_brushes_flora_1_png_1774958889:Class;

[Embed(source='assets/brushes/flora_2.png')]
 private var _embed_mxml_assets_brushes_flora_2_png_1846265897:Class;

[Embed(source='assets/brushes/flora_3.png')]
 private var _embed_mxml_assets_brushes_flora_3_png_1845754129:Class;

[Embed(source='assets/brushes/flora_4.png')]
 private var _embed_mxml_assets_brushes_flora_4_png_1858316817:Class;

[Embed(source='assets/brushes/flora_5.png')]
 private var _embed_mxml_assets_brushes_flora_5_png_1858829585:Class;

[Embed(source='assets/brushes/flora_6.png')]
 private var _embed_mxml_assets_brushes_flora_6_png_1854622737:Class;

[Embed(source='assets/brushes/flora_7.png')]
 private var _embed_mxml_assets_brushes_flora_7_png_1855175961:Class;

[Embed(source='assets/brushes/flora_8.png')]
 private var _embed_mxml_assets_brushes_flora_8_png_1861476889:Class;

[Embed(source='assets/brushes/heart.png')]
 private var _embed_mxml_assets_brushes_heart_png_1965723855:Class;

[Embed(source='assets/brushes/hexagon_icon.png')]
 private var _embed_mxml_assets_brushes_hexagon_icon_png_189420455:Class;

[Embed(source='assets/brushes/hexagon.png')]
 private var _embed_mxml_assets_brushes_hexagon_png_24396487:Class;

[Embed(source='assets/brushes/jing-jang.png')]
 private var _embed_mxml_assets_brushes_jing_jang_png_1483396431:Class;

[Embed(source='assets/brushes/leaf_1.png')]
 private var _embed_mxml_assets_brushes_leaf_1_png_1639198551:Class;

[Embed(source='assets/brushes/leaf_2.png')]
 private var _embed_mxml_assets_brushes_leaf_2_png_1643392855:Class;

[Embed(source='assets/brushes/leaf_3.png')]
 private var _embed_mxml_assets_brushes_leaf_3_png_1642899823:Class;

[Embed(source='assets/brushes/leaf_4.png')]
 private var _embed_mxml_assets_brushes_leaf_4_png_1640802671:Class;

[Embed(source='assets/brushes/moon_icon.png')]
 private var _embed_mxml_assets_brushes_moon_icon_png_1549728559:Class;

[Embed(source='assets/brushes/moon.png')]
 private var _embed_mxml_assets_brushes_moon_png_1543277271:Class;

[Embed(source='assets/brushes/oil_brush_1.png')]
 private var _embed_mxml_assets_brushes_oil_brush_1_png_801343281:Class;

[Embed(source='assets/brushes/oil_brush_2.png')]
 private var _embed_mxml_assets_brushes_oil_brush_2_png_796943929:Class;

[Embed(source='assets/brushes/oil_brush_3.png')]
 private var _embed_mxml_assets_brushes_oil_brush_3_png_797157177:Class;

[Embed(source='assets/brushes/oil_brush_4.png')]
 private var _embed_mxml_assets_brushes_oil_brush_4_png_800819257:Class;

[Embed(source='assets/brushes/oil_brush_5.png')]
 private var _embed_mxml_assets_brushes_oil_brush_5_png_802940729:Class;

[Embed(source='assets/brushes/oil_brush_6.png')]
 private var _embed_mxml_assets_brushes_oil_brush_6_png_741582385:Class;

[Embed(source='assets/brushes/oil_brush_7.png')]
 private var _embed_mxml_assets_brushes_oil_brush_7_png_739477297:Class;

[Embed(source='assets/brushes/oil_brush_8.png')]
 private var _embed_mxml_assets_brushes_oil_brush_8_png_742097969:Class;

[Embed(source='assets/brushes/ornament.png')]
 private var _embed_mxml_assets_brushes_ornament_png_2075722927:Class;

[Embed(source='assets/brushes/planet_1.png')]
 private var _embed_mxml_assets_brushes_planet_1_png_1683551153:Class;

[Embed(source='assets/brushes/planet_2.png')]
 private var _embed_mxml_assets_brushes_planet_2_png_1685369777:Class;

[Embed(source='assets/brushes/radioactive.png')]
 private var _embed_mxml_assets_brushes_radioactive_png_603756615:Class;

[Embed(source='assets/brushes/snowflake.png')]
 private var _embed_mxml_assets_brushes_snowflake_png_952890855:Class;

[Embed(source='assets/brushes/spade.png')]
 private var _embed_mxml_assets_brushes_spade_png_2137489743:Class;

[Embed(source='assets/brushes/spatter.png')]
 private var _embed_mxml_assets_brushes_spatter_png_1983136359:Class;

[Embed(source='assets/brushes/spiral.png')]
 private var _embed_mxml_assets_brushes_spiral_png_2108959191:Class;

[Embed(source='assets/brushes/square_icon.png')]
 private var _embed_mxml_assets_brushes_square_icon_png_600610903:Class;

[Embed(source='assets/brushes/square.png')]
 private var _embed_mxml_assets_brushes_square_png_1442064751:Class;

[Embed(source='assets/brushes/star_1.png')]
 private var _embed_mxml_assets_brushes_star_1_png_1400155983:Class;

[Embed(source='assets/brushes/star_2.png')]
 private var _embed_mxml_assets_brushes_star_2_png_1399598927:Class;

[Embed(source='assets/brushes/star_3.png')]
 private var _embed_mxml_assets_brushes_star_3_png_1397500231:Class;

[Embed(source='assets/brushes/star_icon_1.png')]
 private var _embed_mxml_assets_brushes_star_icon_1_png_1545307945:Class;

[Embed(source='assets/brushes/star_icon_2.png')]
 private var _embed_mxml_assets_brushes_star_icon_2_png_1543742505:Class;

[Embed(source='assets/brushes/star_icon_3.png')]
 private var _embed_mxml_assets_brushes_star_icon_3_png_1556342569:Class;

[Embed(source='assets/brushes/thin_ellipse.png')]
 private var _embed_mxml_assets_brushes_thin_ellipse_png_1941569113:Class;

[Embed(source='assets/brushes/triangle_icon.png')]
 private var _embed_mxml_assets_brushes_triangle_icon_png_695524121:Class;

[Embed(source='assets/brushes/triangle.png')]
 private var _embed_mxml_assets_brushes_triangle_png_363558087:Class;

[Embed(source='assets/brushes/wheel.png')]
 private var _embed_mxml_assets_brushes_wheel_png_1021903831:Class;

	//	end embed carrier vars

	//	binding management vars
    /**
     * @private
     **/
    mx_internal var _bindings : Array = [];
    /**
     * @private
     **/
    mx_internal var _watchers : Array = [];
    /**
     * @private
     **/
    mx_internal var _bindingsByDestination : Object = {};
    /**
     * @private
     **/
    mx_internal var _bindingsBeginWithWord : Object = {};

//	end class def
}

//	end package def
}
