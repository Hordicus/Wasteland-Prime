#include "functions\macro.sqf"
_dialog = uiNamespace getVariable 'storeDialog';
_storeCfg = uiNamespace getVariable 'storeCfg';
_items = [] call BL_Store_fnc_cartItems;

_items call (_storeCfg select 4);