#include "functions\macro.sqf"
private ["_index", "_class", "_config", "_compatible_ammo", "_compatible_cows", "_compatible_muzzles", "_compatible_pointers", "_sold_ammo", "_sold_attachments", "_items", "_compatible_attachments"];
lbClear ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_items_attachments_ammo_idc);

_index  = lbCurSel ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_itemslist_idc);
_config = call GEAR_fnc_config;
_sold_ammo = [_config, "ammo"] call CBA_fnc_hashGet;
_sold_attachments = [_config, "attachments"] call CBA_fnc_hashGet;
_class  = lbData [GEAR_itemslist_idc, _index];

_compatible_ammo = getArray (configFile >> "CfgWeapons" >> _class >> "magazines");
_compatible_cows = getArray (configFile >> "CfgWeapons" >> _class >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
_compatible_muzzles = getArray (configFile >> "CfgWeapons" >> _class >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
_compatible_pointers = getArray (configFile >> "CfgWeapons" >> _class >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");

_compatible_attachments = _compatible_cows + _compatible_muzzles + _compatible_pointers;

_items = [];

if ( GEAR_activeSubNav == 'ammo' ) then {
	{
		_class = _x;
		{
			if (_class == _x select 0) then {
				_items set [count _items, _x];
			};
		} forEach _sold_ammo;
	} forEach _compatible_ammo;

}
else {
	if ( GEAR_activeSubNav == 'attachments' ) then {
		{
			_class = _x;
			{
				if (_class == _x select 0) then {
					_items set [count _items, _x];
				};
			} forEach _sold_attachments;
		} forEach _compatible_attachments;
	};
};

{
	_name = (_x select 0) call GEAR_fnc_ItemName;
	_img = (_x select 0) call GEAR_fnc_ItemImg;
	_price = _x select 1;

	_string = format['%1 [$%2]', _name, _price];
	lbAdd [GEAR_items_attachments_ammo_idc, _string];
	lbSetData [GEAR_items_attachments_ammo_idc, _forEachIndex, _x select 0];
	lbSetPicture[GEAR_items_attachments_ammo_idc, _forEachIndex, _img];
} forEach _items;
