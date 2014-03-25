/*
	Description:
	Adds weapons to vehicle and returns
	what was added.
	
	Parameter(s):
	_veh - Vehicle to add to
	_cargoGroups - Groups of items to select from. See vehicleTownSpawns config.
	
	Returns:
	Array - [weapons, magazines, items] matches format of weapon/magazine/itemCargo commands
*/

private ["_veh","_cargoGroups","_cargo","_itemsAdded","_weaponsAdded","_count","_index","_magsAdded"];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_cargoGroups = [_this, 1, [], [[]]] call BIS_fnc_param;
_cargo = _cargoGroups select floor random count _cargoGroups;
_itemsAdded = [];

clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;

_weaponsAdded = [[], []];
{
	_count = (_x select 1) + floor random  (_x select 2);
	if ( _count > 0 ) then {
		_veh addWeaponCargoGlobal [_x select 0, _count];
		_index = count (_weaponsAdded select 0);
		(_weaponsAdded select 0) set [_index, _x select 0];
		(_weaponsAdded select 1) set [_index, _count];
	};
} forEach (_cargo select 0);

_magsAdded = [[], []];
{
	_count = (_x select 1) + floor random  (_x select 2);
	if ( _count > 0 ) then {
		_veh addMagazineCargoGlobal [_x select 0, _count];
		_index = count (_magsAdded select 0);
		(_magsAdded select 0) set [_index, _x select 0];
		(_magsAdded select 1) set [_index, _count];
	};
} forEach (_cargo select 1);

_itemsAdded = [[], []];
{
	_count = (_x select 1) + floor random  (_x select 2);
	if ( _count > 0 ) then {
		_veh addItemCargoGlobal [_x select 0, _count];
		_index = count (_itemsAdded select 0);
		(_itemsAdded select 0) set [_index, _x select 0];
		(_itemsAdded select 1) set [_index, _count];
	};
} forEach (_cargo select 2);

if ( count (_weaponsAdded select 0) == 0 ) then {
	_weaponsAdded = [];
};

if ( count (_magsAdded select 0) == 0 ) then {
	_magsAdded = [];
};

[_weaponsAdded, _magsAdded, _itemsAdded]