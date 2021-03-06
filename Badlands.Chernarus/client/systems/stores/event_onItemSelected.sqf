/*
	Description:
	Calls store item sel fnc.
*/

#include "functions\macro.sqf"

private ['_dialog', '_cat', '_items'];
_dialog = uiNamespace getVariable 'storeDialog';
_storeCfg = uiNamespace getVariable 'storeCfg';

_pane = '';
_item = [];
_itemData = (_this select 0) lbData lbCurSel (_this select 0);
_addRemoveBtn = _dialog displayCtrl addRemoveBtnIDC;

_addRemoveBtn ctrlShow true;
if ( ctrlIDC (_this select 0) == storeItemsIDC) then {
	_pane = 'items';
	_addRemoveBtn ctrlSetText "Add to cart";
}
else {
	_pane = 'cart';
	_addRemoveBtn ctrlSetText "Remove from cart";
};

uiNamespace setVariable ['storeLastPane', _pane];
if ( _pane == 'items' ) then {
	_item = ((_this select 0) lbData lbCurSel (_this select 0)) call BL_fnc_itemFromIndex;
}
else {
	_item = ((_this select 0) lnbData [lnbCurSelRow (_this select 0),0]) call BL_fnc_itemFromIndex;
};
[_pane, _item, (_dialog displayCtrl selectedItemInfoIDC)] call (_storeCfg select 2);