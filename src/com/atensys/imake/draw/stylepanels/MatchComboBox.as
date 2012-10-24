﻿
package com.atensys.imake.draw.stylepanels
{

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import mx.collections.ArrayCollection;
	import mx.controls.ComboBox;
	import mx.core.ClassFactory;
	import mx.events.FlexEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;

	[Exclude(name="editable",kind="property")]

	/**
	 *	<b>FEATURES</b>
	 *	MatchComboBox a replacement for a standard non-editable combobox. But instead of
	 * 	searching via the first character it uses the text input field  for an incremental
	 * 	search to match the text input against the list an show the actual match in the
	 * 	dropdown list.
	 * 	It doesn't make sense in smaller lists, but in huge list it can be helpful.
	 * 	See demo at http://blog.sbistram.de
	 *
	 *  <pre>
	 *  &lt;MatchComboBox
	 *    <b>Properties</b>
	 *    matchFromFirstPosition="false"
	 *    matchCaseSensitive="false"
	 *  /&gt;
	 *  </pre>
	 *
	 * @see mx.controls.ComboBox
	 *
	 * <b>TODO's</b>
	 * - Its a non-editable combobox, so the skin should changed dynamically. It should look like
	 *   a non-editable when the component has no focus and like an editable when it has focus.
	 * - The dropdown renderer has some HTML limitations and the match color should be a
	 *   style property.
	 * - UI unit tests are missing (Flex Monkeys).
	 * - never ever used or tested in any serious application (so be careful!!!)
	 * - Make an editable version (should be easy to do).
	 * - what else..?
	 *
	 * <b>OPEN BUGS/ISSUES</b>
	 * 1. Using the prompt property is not working correctly
	 * 2. Flex 3.2 bug:
	 *    Start editing in the input field will open the dropdown list, but when
	 *    you resize the window so the dropdown list will close the dropdown list
	 *    will stay invisible (dropdown.visible returns true!)
	 *
	 * @version 0.2
	 */
	public class MatchComboBox extends ComboBox
	{

		private var _log:ILogger=Log.getLogger("de.sbistram.controls.MatchComboBox");

		[Bindable]
		public var matchCaseSensitive:Boolean=false;
		[Bindable]
		public var matchFirstPosition:Boolean=false;

		// match key or other key strokes like enter, arrow up/down, page up/down
		private var _matchKey:Boolean=true;

		// initial index must be kept for restoring
		private var _lastValidIndex:int=-1;

		// initial rowCount needed for restoring
		private var _initialRowCount:int;

		/**
		 * Constructor
		 */
		public function MatchComboBox()
		{
			super();
			editable=true;
			rowCount=5;
			itemRenderer=new ClassFactory(MatchComboBoxRenderer);
		}

		/**
		 *  @private
		 */
		override public function set editable(value:Boolean):void
		{
			// must always be set to true
			super.editable=true;
		}

		/**
		 * Use <code>Array</code> or an <code>ArrayCollection</code> of String items.
		 */
		override public function set dataProvider(value:Object):void
		{
			if (value is Array)
			{
				value=new ArrayCollection(value as Array);
			}
			(value as ArrayCollection).filterFunction=filterFunction;
			super.dataProvider=value;
		}

		override protected function createChildren():void
		{
			super.createChildren();
			if (prompt == null)
			{
				selectedIndex=0;
			}
		}

		/**
		 * Get the original rowCount value
		 * @see collectionChangeHandler
		 */
		override public function set rowCount(value:int):void
		{
			_initialRowCount=value;
			super.rowCount=value;
		}

		override public function close(event:Event=null):void
		{
			(dataProvider as ArrayCollection).refresh();
			super.close();
		}

		override public function open():void
		{
			super.open();
		}

		override public function set text(value:String):void
		{
			super.text=value;
		}

		override protected function textInput_changeHandler(event:Event):void
		{
			super.textInput_changeHandler(event); // do the text change before filtering 
			if (_matchKey == true)
			{ // don't do it for other keystokes
				(dataProvider as ArrayCollection).refresh(); // do filtering with actual input text
				if (dropdown.visible == false)
				{ // show list for filtering
					// BUG in Flex 3.2:
					// dropdown.visible returns still true after the dropdown
					// was closed while resizing the app. window.
					open();
				}
			}
		}

		/**
		 * Collection can change with any keystroke. The rowCount will be refreshed
		 */
		override protected function collectionChangeHandler(event:Event):void
		{
			super.rowCount=_initialRowCount; // otherwise it will shrink
		}

		/**
		 * Don't know why, but with any keystroke it's been called twice
		 * @param	event
		 */
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ENTER)
			{
				_matchKey=false;
			}
			else if (event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.UP || event.keyCode == Keyboard.PAGE_DOWN || event.keyCode == Keyboard.PAGE_UP)
			{
				_matchKey=false; // don't show dropdown
			}
			else
			{
				_matchKey=true; // can be a valid match input char
			}
			super.keyDownHandler(event);
		}

		override protected function focusOutHandler(event:FocusEvent):void
		{
			validateSelection();
			super.focusOutHandler(event);
		}

		override protected function downArrowButton_buttonDownHandler(event:FlexEvent):void
		{
			super.downArrowButton_buttonDownHandler(event);
		}

		override protected function focusInHandler(event:FocusEvent):void
		{
			super.focusInHandler(event);
		}

		//---------------------------------------------------------------------
		// PRIVATE
		//---------------------------------------------------------------------

		/**
		 * If the <code>_matchKey</code> is false the collection will be restored
		 * without any filtering, otherwise the actual text input will be used
		 * to filter the collection.
		 *
		 * @param	item
		 * @return	true if item matched
		 */
		private function filterFunction(item:Object):Boolean
		{
			if (_matchKey == false)
			{ // show the hole list for non match keys
				return true;
			}
			return text.length == 0 || isMatch(itemToLabel(item));
		}

		/**
		 * Get the index of the matched item out of the collection
		 *
		 * @param	value the
		 * @param	forceExactMatch
		 * @return  the index of the match or -1
		 */
		private function getMatchIndex(value:String, forceExactMatch:Boolean):int
		{
			if (value.length == 0)
			{
				return -1;
			}
			var ac:Array=(dataProvider as ArrayCollection).source;
			for (var index:int=0; index < ac.length; index++)
			{
				if (isMatch(itemToLabel(ac[index]), forceExactMatch))
				{
					return index;
				}
			}
			return -1;
		}

		/**
		 * Using <code>matchCaseSensitive</code> and <code>matchFirstPosition</code>
		 * to find a match
		 *
		 * @param	value of the collection
		 * @param	forceExactMatch = false
		 * @return  true if it is a match
		 */
		private function isMatch(value:String, forceExactMatch:Boolean=false):Boolean
		{
			var valueText:String=matchCaseSensitive ? value : value.toLowerCase();
			var matchText:String=matchCaseSensitive ? text : text.toLowerCase();
			if (forceExactMatch == true)
			{
				return (valueText == matchText);
			}
			else
			{
				if (matchFirstPosition == true)
				{
					return valueText.indexOf(matchText) == 0;
				}
				else
				{
					return valueText.indexOf(matchText) != -1;
				}
			}
		}

		/**
		 * Make sure the selection is valid, even if the input text doesn't match any item.
		 */
		private function validateSelection():void
		{

			// it is a difference whether we have a selection via a match or via an arrow selection
			// Example: Arkansas, Kansas -> input match text:kansas
			// 1. The match was given in via text field
			// 		Select the first entry in the list: Arkansas
			// 2. The match was given by arrow selection from dropdown list
			//		Select the exact entry: Kansas
			// In both cases the last keystroke could be ENTER, so we have to check if there was a 
			// selection done (selectedIndex).
			var index:int=getMatchIndex(text, selectedIndex != -1);

			if (index == -1 && _lastValidIndex != -1)
			{ // no match, use last valid selection
				index=_lastValidIndex;
			}

			if (index == -1 && prompt == null)
			{ // nothing was selected, use the default or prompt
				index=0;
			}

			_matchKey=false;
			(dataProvider as ArrayCollection).refresh();
			selectedIndex=index; // if -1 -> show prompt
			_lastValidIndex=index; // remember last valid selection
		}

	}
}

//---------------------------------------------------------------------
// INTERNAL CLASSES
//---------------------------------------------------------------------

import mx.controls.Label;
import mx.controls.List;
import mx.controls.ComboBox;
import mx.logging.ILogger;
import mx.logging.Log;

/**
 * MatchComboBox renderer for highlighting the matched text in the dropdown via HTML tags
 */
class MatchComboBoxRenderer extends Label
{

	// @todo the match color should be defined somewhere else
	private static const MATCH_BEGIN_TAG:String="<font color='#0000ff'><b>";
	private static const MATCH_END_TAG:String="</b></font>";

	private var _log:ILogger=Log.getLogger("MatchComboBox.MatchComboBoxRenderer");

	public function MatchComboBoxRenderer()
	{
		super();
	}

	/**
	 * Check if search text part of the value and if so mark it via HTML
	 * @todo Can't handle HTML text always correctly, maybe a reg. exp.
	 */
	override public function set text(value:String):void
	{
		var isHTML:Boolean=false;
		var searchText:String=(((listData.owner as List).owner) as ComboBox).text;
		if (searchText != null && searchText.length != 0)
		{
			var index:int=value.toLowerCase().indexOf(searchText.toLowerCase());
			if (index != -1)
			{
				value=htmlMatch(value, searchText.length, index);
				isHTML=true;
			}
		}
		if (isHTML == true)
		{
			super.htmlText=value;
		}
		else
		{
			super.text=value;
		}
	}

	/**
	 * Decorate the match in the text value via HTML
	 */
	private function htmlMatch(value:String, len:int, index:int):String
	{
		return value.substr(0, index).concat(MATCH_BEGIN_TAG, value.substr(index, len), MATCH_END_TAG, value.substr(index + len));
	}
}

