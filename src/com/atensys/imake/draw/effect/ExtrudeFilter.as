package com.atensys.imake.draw.effect
{
	import flash.geom.Point;


	public class ExtrudeFilter
	{

		private var _layers:int;
		private var _focal:int;
		private var _projectionPoint:Point;

		public function set layers(value:int):void
		{
			_layers=value;
		}

		public function get layers():int
		{
			return _layers;
		}

		public function set focal(value:int):void
		{
			_focal=value;
		}

		public function get focal():int
		{
			return _focal;
		}

		public function set projectionPoint(value:Point):void
		{
			_projectionPoint=value;
		}

		public function get projectionPoint():Point
		{
			return _projectionPoint;
		}


		public function ExtrudeFilter(layer:int, focal:int, point:Point)
		{
			layers=layer; //20;
			focal=focal; //480;
			projectionPoint=point; //new Point(0, 0);
		}

	}
}