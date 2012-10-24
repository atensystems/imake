package {
import flash.utils.*;
import mx.core.IFlexModuleFactory;
import flash.system.*
import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.atensys.imake.draw.layers.LayerData;
import mx.collections.ArrayCollection;
import mx.collections.ArrayList;
import mx.utils.ObjectProxy;
import mx.effects.EffectManager;
import mx.core.mx_internal;

[Mixin]
public class _drawer_FlexInit
{
   public function _drawer_FlexInit()
   {
       super();
   }
   public static function init(fbs:IFlexModuleFactory):void
   {
      EffectManager.mx_internal::registerEffectTrigger("addedEffect", "added");
      EffectManager.mx_internal::registerEffectTrigger("completeEffect", "complete");
      EffectManager.mx_internal::registerEffectTrigger("creationCompleteEffect", "creationComplete");
      EffectManager.mx_internal::registerEffectTrigger("focusInEffect", "focusIn");
      EffectManager.mx_internal::registerEffectTrigger("focusOutEffect", "focusOut");
      EffectManager.mx_internal::registerEffectTrigger("hideEffect", "hide");
      EffectManager.mx_internal::registerEffectTrigger("itemsChangeEffect", "itemsChange");
      EffectManager.mx_internal::registerEffectTrigger("mouseDownEffect", "mouseDown");
      EffectManager.mx_internal::registerEffectTrigger("mouseUpEffect", "mouseUp");
      EffectManager.mx_internal::registerEffectTrigger("moveEffect", "move");
      EffectManager.mx_internal::registerEffectTrigger("removedEffect", "removed");
      EffectManager.mx_internal::registerEffectTrigger("resizeEffect", "resize");
      EffectManager.mx_internal::registerEffectTrigger("resizeEndEffect", "resizeEnd");
      EffectManager.mx_internal::registerEffectTrigger("resizeStartEffect", "resizeStart");
      EffectManager.mx_internal::registerEffectTrigger("rollOutEffect", "rollOut");
      EffectManager.mx_internal::registerEffectTrigger("rollOverEffect", "rollOver");
      EffectManager.mx_internal::registerEffectTrigger("showEffect", "show");
      try {
      if (flash.net.getClassByAlias(">com.atensys.imake.draw.layers.LayerData") == null){
          flash.net.registerClassAlias(">com.atensys.imake.draw.layers.LayerData", com.atensys.imake.draw.layers.LayerData);}
      } catch (e:Error) {
          flash.net.registerClassAlias(">com.atensys.imake.draw.layers.LayerData", com.atensys.imake.draw.layers.LayerData); }
      try {
      if (flash.net.getClassByAlias("flex.messaging.io.ArrayCollection") == null){
          flash.net.registerClassAlias("flex.messaging.io.ArrayCollection", mx.collections.ArrayCollection);}
      } catch (e:Error) {
          flash.net.registerClassAlias("flex.messaging.io.ArrayCollection", mx.collections.ArrayCollection); }
      try {
      if (flash.net.getClassByAlias("flex.messaging.io.ArrayList") == null){
          flash.net.registerClassAlias("flex.messaging.io.ArrayList", mx.collections.ArrayList);}
      } catch (e:Error) {
          flash.net.registerClassAlias("flex.messaging.io.ArrayList", mx.collections.ArrayList); }
      try {
      if (flash.net.getClassByAlias("flex.messaging.io.ObjectProxy") == null){
          flash.net.registerClassAlias("flex.messaging.io.ObjectProxy", mx.utils.ObjectProxy);}
      } catch (e:Error) {
          flash.net.registerClassAlias("flex.messaging.io.ObjectProxy", mx.utils.ObjectProxy); }
      var styleNames:Array = ["strokeColor", "fontWeight", "modalTransparencyBlur", "rollOverColor", "textRollOverColor", "verticalGridLineColor", "backgroundDisabledColor", "textIndent", "barColor", "fontSize", "kerning", "footerColors", "textAlign", "disabledIconColor", "fontStyle", "dropdownBorderColor", "modalTransparencyDuration", "textSelectedColor", "strokeWidth", "horizontalGridLineColor", "selectionColor", "modalTransparency", "shadowCapColor", "fontGridFitType", "selectionDisabledColor", "disabledColor", "fontAntiAliasType", "modalTransparencyColor", "alternatingItemColors", "leading", "shadowColor", "iconColor", "dropShadowColor", "themeColor", "letterSpacing", "fontFamily", "highlightColor", "color", "fontThickness", "errorColor", "headerColors", "fontSharpness", "textDecoration"];

      import mx.styles.StyleManager;

      for (var i:int = 0; i < styleNames.length; i++)
      {
         StyleManager.registerInheritingStyle(styleNames[i]);
      }
   }
}  // FlexInit
}  // package
