#include "dialogs\gear_defines.sqf"

private ["_type", "_config", "_items", "_name", "_price"];
_type = _this;
_config = call GEAR_config;
_items = [_config, _type] call CBA_fnc_hashGet;

lbClear GEAR_itemslist_idc;

{
	_name = (_x select 0) call GEAR_ItemName;
	_price = _x select 1;
	
	lbAdd [GEAR_itemslist_idc, _name];

} forEach _items;