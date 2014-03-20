/*
	Description:
	Updates item list based on category selected.
*/

#include "functions\macro.sqf"

private ['_dialog', '_cat', '_items'];
_dialog = uiNamespace getVariable 'storeDialog';
_cat = lbText [storeCategoriesIDC, lbCurSel storeCategoriesIDC];
_items = (uiNamespace getVariable 'storeCfg') select 1;

[_items, _cat] call BL_Store_fnc_showItems;