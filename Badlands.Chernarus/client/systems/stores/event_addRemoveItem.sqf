#include "functions\macro.sqf"

_lastPane = uiNamespace getVariable ['storeLastPane', ""];
_dialog = uiNamespace getVariable 'storeDialog';
_items = _dialog displayCtrl storeItemsIDC;
_cart = _dialog displayCtrl cartIDC;

if ( _lastPane == "items" ) then {
	// User clicked add to cart.
	_item = _items lbText lbCurSel _items;
	_data = _items lbData lbCurSel _items;

	_cartItems = [] call BL_fnc_cartItems;
	_index = -1;
	
	for "_i" from 0 to ((lnbSize cartIDC) select 0) do {
		_curData = lnbData [cartIDC, [_i, 0]];
		if ( _curData == _data ) exitwith {
			_index = _i;
		};
	};
	
	if ( _index == -1 ) then {
		_index = lnbAddRow [cartIDC, [_item, "1"]];
		_cart lnbSetData [[_index, 0], _data];
	}
	else {
		_count = parseNumber (_cart lnbText [_index, 1]);
		_cart lnbSetText [[_index, 1], str (_count + 1)];
	};
}
else { if ( _lastPane == "cart" ) then {
	// User clicked remove from cart
	_row = lnbCurSelRow cartIDC;
	_count = parseNumber (_cart lnbText [_row, 1]);
	if ( _count == 1 ) then {
		_cart lnbDeleteRow _row;
	}
	else {
		_cart lnbSetText [[_row, 1], str (_count - 1)];
	};
	
	if ( (lnbCurSelRow cartIDC) == -1 ) then {
		// Nothing selected anymore.
		// Probably removed last item.
	
		(_dialog displayCtrl addRemoveBtnIDC) ctrlShow false;
	};
}};

_storeCfg = uiNamespace getVariable 'storeCfg';
_cart = _dialog displayCtrl cartIDC;

// Get items in cart
_items = [] call BL_fnc_cartItems;
[_items, _dialog displayCtrl cartInfoIDC, _dialog displayCtrl purchaseIDC] call (_storeCfg select 3);