package aether.utils {

	/**
	* Class performs common Math utility functions.
	*/
	public class MathUtil {
	
		/**
		* Converts degrees to radians.
		*
		* @param  num  Number to convert.
		*
		* @returns  Number values in radians.
		*/
		static public function degreesToRadians(num:Number):Number {
			return num*Math.PI/180;
		}
	
		static public function clamp(num:Number, min:Number, max:Number):Number {
			return Math.max(min, Math.min(num, max));
		}

	}
	
}