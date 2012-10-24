package com.atensys.imake.draw.componentprovider {

	public class ProviderUtils {
		private static var id:int=1;

		public function ProviderUtils() {
		}


		public static function newID():int {
			return id++;
		}

	}
}