private ["_veh","_position","_variables","_fuelCargo","_ammoCargo","_weapons","_magazines"];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_position = getPosATL _veh;
_variables = [];

_fuelCargo = getFuelCargo _veh;
_ammoCargo = getFuelCargo _veh;

if !( finite _fuelCargo ) then { _fuelCargo = 0; };
if !( finite _ammoCargo ) then { _ammoCargo = 0; };

_weapons = ([typeOf _veh] call BL_fnc_vehicleWeapons);

_magazines = [];
{
	_magazines set [_forEachIndex, [_x, _veh magazinesTurret _x]];
} forEach _weapons;

["INSERT INTO `vehicles` SET
`class` = '%1',
`object_code` = '%2',
`object_type` = '%3',
`pos_x` = %4,
`pos_y` = %5,
`pos_z` = %6,
`damage` = %7,
`fuel` = %8,
`weaponCargo` = '%9',
`magazineCargo` = '%10',
`itemCargo` = '%11',
`vectorDir` = '%12',
`vectorUp` = '%13',
`fuelCargo` = %14,
`ammoCargo` = %15,
`magazines` = '%16',
`variables` = '%17'
", [
typeOf _veh,
_position select 0,
_position select 1,
_position select 2,

damage _veh,
fuel _veh,
getWeaponCargo _veh,
getMagazineCargo _veh,
getItemCargo _veh,
vectorDir _veh,
vectorUp _veh,
_fuelCargo,
_ammoCargo,
_magazines,
_variables,
1
]] call BL_fnc_MySQLCommand;