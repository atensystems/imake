package com.atensys.imake.draw.componentprovider {
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.component.DComponent;
	import com.atensys.imake.draw.styles.DStyle;


	/**
	 * The super interface for each component provider which.
	 * A component provider creates ui components of specific type, corresponding to pallete instruments.
	 *
	 * @author Andrei Sirghi.
	 */
	public interface DComponentProvider {

		/**
		 * Sets parent compontent controller. For all providers parent component is the draw desktop.
		 * This method is inwoked after the instanciation of an implementor object.
		 */
		function setParent(parent:DrawDesktop):void;

		/**
		 * Sets a new style for this types of component.
		 * @param style the style object for this component provider.
		 */
		function setDStyle(style:DStyle):void;

		/**
		 * Sets active state of this component provider.
		 * If component provider deactivated it must disable its drawing events.
		 * @param active a boolean parameter that shows if component is activated or deactivated.
		 */
		function setActive(active:Boolean):void;
		
		function setDComponent(comp:DComponent):void;
	}
}