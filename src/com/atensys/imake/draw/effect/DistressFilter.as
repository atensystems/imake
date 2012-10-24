package com.atensys.imake.draw.effect
{

	public class DistressFilter
	{
		private var _distressN:int;

		public function DistressFilter(n:int)
		{
			distressN=n;
		}

		public function get distressN():int
		{
			return _distressN;
		}

		public function set distressN(n:int):void
		{
			_distressN=n;
		}
	}
}