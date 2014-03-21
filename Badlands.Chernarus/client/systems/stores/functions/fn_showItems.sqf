/*
	Description:
	Shows items in store.
	Optionally pass a category to filter by.
	
	Parameter(s):
	_items - Array of categories and items
	_category - Category to show. Default: Show all.
	
	Returns:
	Items shown
*/

#include "macro.sqf"
disableSerialization;

private ['_items', '_cat', '_dialog', '_itemsToShow', '_itemsCtrl'];
_items  = [_this, 0, [], [[]]] call BIS_fnc_param;
_cat    = [_this, 1, SHOW_ALL_TEXT, [""]] call BIS_fnc_param;
_dialog = uiNamespace getVariable 'storeDialog';

_itemsToShow = [];
_itemsCtrl = _dialog displayCtrl storeItemsIDC;

lbClear _itemsCtrl;

if ( _cat == SHOW_ALL_TEXT ) then {
	// "Show all", or no category selected.
	{
		_catIndex = _forEachIndex;
		{
			_itemsToShow set [count _itemsToShow, [(_x select 0), format['%1.%2', _catIndex, _forEachIndex]]];
		} forEach (_x select 1);
	} forEach _items;
}
else {
	// Category was selected. Find and show the one.
	{
		if ( _cat == (_x select 0) ) exitwith {
			_catIndex = _forEachIndex;
			{
				_itemsToShow set [count _itemsToShow, [(_x select 0), format['%1.%2', _catIndex, _forEachIndex]]];
			} forEach (_x select 1);
		};
	} forEach _items;
};

private ['_index'];
{
	_index = _itemsCtrl lbAdd (_x select 0);
	_itemsCtrl lbSetData [_index, _x select 1];
} forEach _itemsToShow;

_itemsToShow