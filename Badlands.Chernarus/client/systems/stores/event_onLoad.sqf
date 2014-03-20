#include "functions\macro.sqf"
disableSerialization;

_dialog = _this select 0;
_items = _dialog displayCtrl storeItemsIDC;
_cats  = _dialog displayCtrl storeCategoriesIDC;

_items lbAdd "Item";
_items lbAdd "Item";
_items lbAdd "Item";
_items lbAdd "Item";
_items lbAdd "Item";

_cats lbAdd "Category";
_cats lbAdd "Category";
_cats lbAdd "Category";
_cats lbAdd "Category";