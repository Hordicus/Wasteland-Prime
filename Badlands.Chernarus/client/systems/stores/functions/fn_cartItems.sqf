/*
	Description:
	Returns array of items in cartIDC
	
	Parameter(s):
	None
	
	Returns:
	Array - Items in cartIDC
*/

#include "macro.sqf"
disableSerialization;

private ['_dialog', '_cart', '_items', '_item', '_count'];
_dialog = uiNamespace getVariable 'storeDialog';
_cart = _dialog displayCtrl cartIDC;

_items = [];
for "_i" from 0 to ((lnbSize cartIDC) select 0)-1 do {
	_item = _cart lnbData [_i, 0];
	_count = parseNumber (_cart lnbText [_i, 1]);
	
	for "_x" from 0 to _count-1 do {
		_items set [count _items, _item call BL_fnc_itemFromIndex];
	};
};

_items