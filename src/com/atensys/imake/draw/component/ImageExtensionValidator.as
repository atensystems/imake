package com.atensys.imake.draw.component
{
	import mx.utils.StringUtil;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	/**
	 * The FileExtensionValidator class validates a file's extension
	 * against an array of valid extensions.
	 *
	 * @see mx.validators.Validator
	 */

	public class ImageExtensionValidator extends Validator
	{

		/**
		 * Indicates the error code.
		 */

		private var ERROR_BAD_EXTENSION:String="BadFileExtension";

		/**
		 * Array stores the return value of doValidation().
		 */

		private var _results:Array;

		/**
		 * Class constructor.
		 */

		public function ImageExtensionValidator()
		{
			// Call the base class' constructor.
			super();

		}
		private var _validExtensions:Array;

		/**
		 * Array contains valid file extensions.
		 */

		public function get validExtensions():Array
		{
			return _validExtensions;
		}

		/**
		 * @private
		 */

		public function set validExtensions(value:Array):void
		{
			_validExtensions=value;
		}
		private var _errorMessage:String;

		/**
		 * Provides a custom error message.
		 */

		public function get errorMessage():String
		{
			return _errorMessage;
		}

		/**
		 * @private
		 */

		public function set errorMessage(value:String):void
		{
			_errorMessage=value;
		}

		/**
		 * Overrides the superclass' doValidation() method and defines
		 * a custom implementation.
		 *
		 * @param value Object to validate.
		 * @return Array containing a ValidationResult object for each error.
		 */

		override protected function doValidation(value:Object):Array
		{
			// Convert value to a String.
			var inputValue:String=StringUtil.trim(String(value));
			// Clear the results array.
			_results=[];
			// Call base class doValidation().
			_results=super.doValidation(inputValue);
			// Return if there are errors.
			if (_results.length > 0)
				return _results;
			// If the string is empty, return.
			if (inputValue.length == 0)
				return _results;
			// Get the filename's extension.
			var fileExtension:String=inputValue.substring(inputValue.lastIndexOf(".")).toLowerCase();
			// If file extension isn't in the array, add an error.
			if (_validExtensions.indexOf(fileExtension) == -1)
			{
				_results.push(new ValidationResult(true, null, ERROR_BAD_EXTENSION, _errorMessage));
				return _results;
			}
			return _results;
		}
	}

}