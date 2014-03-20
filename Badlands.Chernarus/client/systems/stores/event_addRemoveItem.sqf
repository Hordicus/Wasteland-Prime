#include "functions\macro.sqf"

_lastPane = uiNamespace getVariable ['storeLastPane', ""];
_dialog = uiNamespace getVariable 'storeDialog';
_items = _dialog displayCtrl storeItemsIDC;
_cart = _dialog displayCtrl cartIDC;

if ( _lastPane == "items" ) then {
	// User clicked add to cart.
	_item = _items lbText lbCurSel _items;
	_data = _items lbData lbCurSel _items;
	
	_index = _cart lbAdd _item;
	_cart lbSetData [_index, _data];
}
else { if ( _lastPane == "cart" ) then {
	// User clicked remove from cart
	_cart lbDelete lbCurSel _cart;
}};

_dialog = uiNamespace getVariable 'storeDialog';
_storeCfg = uiNamespace getVariable 'storeCfg';
_cart = _dialog displayCtrl cartIDC;

// Get items in cart
_items = [];
for "_i" from 0 to (lbSize _cart)-1 do {
	_items set [_i, (_cart lbData _i) call BL_Store_fnc_itemFromIndex];
};

[_items, _dialog displayCtrl purchaseIDC] call (_storeCfg select 3);