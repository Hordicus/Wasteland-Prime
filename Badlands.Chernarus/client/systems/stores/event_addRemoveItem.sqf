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
	
	if ( (lbCurSel _cart) == -1 ) then {
		// Nothing selected anymore.
		// Probably removed last item.
	
		(_dialog displayCtrl addRemoveBtnIDC) ctrlShow false;
	};
}};

_storeCfg = uiNamespace getVariable 'storeCfg';
_cart = _dialog displayCtrl cartIDC;

// Get items in cart
_items = [] call BL_Store_fnc_cartItems;
[_items, _dialog displayCtrl cartInfoIDC, _dialog displayCtrl purchaseIDC] call (_storeCfg select 3);