package com.atensys.imake.draw.effect
{
	import aether.effects.common.OverlayImageEffect;

	public class ListItemValueObject
	{

		[Bindable]
		public var name:String;

		[Bindable]
		public var isSelected:Boolean;

		public function ListItemValueObject(lab:String, select:Boolean)
		{
			super();
			this.name=lab;
			this.isSelected=select;
		}

		public function getState():Boolean
		{
			return isSelected;
		}
	}
}
