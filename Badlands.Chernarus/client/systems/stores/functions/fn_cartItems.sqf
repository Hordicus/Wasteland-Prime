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

private ['_dialog', '_cart', '_items'];
_dialog = uiNamespace getVariable 'storeDialog';
_cart = _dialog displayCtrl cartIDC;

_items = [];
for "_i" from 0 to (lbSize _cart)-1 do {
	_items set [_i, (_cart lbData _i) call BL_Store_fnc_itemFromIndex];
};

_items