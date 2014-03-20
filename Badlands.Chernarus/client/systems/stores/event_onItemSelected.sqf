/*
	Description:
	Calls store item sel fnc.
*/

#include "functions\macro.sqf"

private ['_dialog', '_cat', '_items'];
_dialog = uiNamespace getVariable 'storeDialog';
_storeCfg = uiNamespace getVariable 'storeCfg';

_pane = '';
_item = (_this select 0) lbText lbCurSel (_this select 0);
_itemData = (_this select 0) lbData lbCurSel (_this select 0);
_itemBtnOne = _dialog displayCtrl itemBtnOneIDC;

_itemBtnOne ctrlShow true;
if ( ctrlIDC (_this select 0) == storeItemsIDC) then {
	_pane = 'items';
	_itemBtnOne ctrlSetText "Add to cart";
}
else {
	_pane = 'cart';
	_itemBtnOne ctrlSetText "Remove from cart";
};

[_pane, _item, _itemData] call (_storeCfg select 2);