private ["_veh","_position","_variables","_fuelCargo","_ammoCargo","_data"];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_position = getPosATL _veh;
_variables = [_veh getVariable 'PERS_type', 'save', [_veh]] call BL_fnc_persRunTypeHandler;
if ( isNil "_variables" ) then {
	_variables = "";
};

_fuelCargo = getFuelCargo _veh;
_ammoCargo = getFuelCargo _veh;

if !( finite _fuelCargo ) then { _fuelCargo = 0; };
if !( finite _ammoCargo ) then { _ammoCargo = 0; };

_data = [
	typeOf _veh,
	_position select 0,
	_position select 1,
	_position select 2,

	damage _veh,
	fuel _veh,
	getWeaponCargo _veh,
	getMagazineCargo _veh,
	getItemCargo _veh,
	getDir _veh,
	vectorUp _veh,
	_fuelCargo,
	_ammoCargo,
	magazines _veh,
	_variables,
	_veh getVariable ['LOG_contents', []]
];

_data