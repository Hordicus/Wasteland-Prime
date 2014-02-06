#include "dialogs\gear_defines.sqf"
private ["_list", "_index", "_class", "_config", "_compatible_ammo", "_compatible_cows", "_compatible_muzzles", "_compatible_pointers", "_sold_ammo", "_ammo"];
lbClear ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_items_attachments_ammo_idc);

_list   = _this select 0;
_index  = _this select 1;
_config = call GEAR_config;
_sold_ammo = [_config, "ammo"] call CBA_fnc_hashGet;
_class  = _list lbData _index;

_compatible_ammo = getArray (configFile >> "CfgWeapons" >> _class >> "magazines");
_compatible_cows = getArray (configFile >> "CfgWeapons" >> _class >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
_compatible_muzzles = getArray (configFile >> "CfgWeapons" >> _class >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
_compatible_pointers = getArray (configFile >> "CfgWeapons" >> _class >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");

_ammo = [];

{
	_class = _x;
	{
		if (_class == _x select 0) then {
			_ammo set [count _ammo, _x];
		};
	} forEach _sold_ammo;
} forEach _compatible_ammo;

{
	_name = (_x select 0) call GEAR_ItemName;
	_img = (_x select 0) call GEAR_ItemImg;
	_price = _x select 1;

	_string = format['%1 [$%2]', _name, _price];
	lbAdd [GEAR_items_attachments_ammo_idc, _string];
	lbSetData [GEAR_items_attachments_ammo_idc, _forEachIndex, _x select 0];
	lbSetPicture[GEAR_items_attachments_ammo_idc, _forEachIndex, _img];
} forEach _ammo;