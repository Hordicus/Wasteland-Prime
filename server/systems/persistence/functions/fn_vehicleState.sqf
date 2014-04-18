private ["_veh","_netId","_index","_dbID","_isNew","_type","_position","_variables","_fuelCargo","_ammoCargo","_data","_query"];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

if ( isNull _veh ) exitwith {};

_data = [
	getPosATL _veh,
	damage _veh,
	fuel _veh,
	getWeaponCargo _veh,
	getMagazineCargo _veh,
	getItemCargo _veh,
	magazines _veh
];

str _data