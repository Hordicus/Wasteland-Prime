#include "dialogs\gear_defines.sqf"

private ["_type", "_config", "_items", "_name", "_price", "_string", "_img"];
_type = _this;
_config = call GEAR_config;
_items = [_config, _type] call CBA_fnc_hashGet;

lbClear ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_itemslist_idc);

{
	_name = (_x select 0) call GEAR_ItemName;
	_img = (_x select 0) call GEAR_ItemImg;
	_price = _x select 1;
	
	_string = format['%1 [$%2]', _name, _price];
	lbAdd [GEAR_itemslist_idc, _string];
	lbSetData [GEAR_itemslist_idc, _forEachIndex, _x select 0];
	lbSetPicture[GEAR_itemslist_idc, _forEachIndex, _img];

} forEach _items;

lbSetCurSel [GEAR_itemslist_idc, 0];