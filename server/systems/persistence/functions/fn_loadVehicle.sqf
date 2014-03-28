private ["_data","_position","_veh","_weapons","_path"];
_data = [_this, 0, [], [[]]] call BIS_fnc_param;

// diag_log format["Loading Vehicle with data: %1", _data];

_position = [
	_data select 3,
	_data select 4,
	_data select 5
];

// _veh = createVehicle [_data select 1, _position, [], 0, "CAN_COLLIDE"];
_veh = [_data select 1, _position, _data select 11] call BL_fnc_safeVehicleSpawn;
[_veh, _data select 2, _data select 0] call BL_fnc_trackVehicle;

_veh setDamage (_data select 6);
_veh setFuel (_data select 7);

clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearItemCargoGlobal _veh;

{
	_veh addWeaponCargoGlobal [_x, _data select 8 select 1 select _forEachIndex];
} forEach (_data select 8 select 0);

{
	_veh addMagazineCargoGlobal [_x, _data select 9 select 1 select _forEachIndex];
} forEach (_data select 9 select 0);

{
	_veh addItemCargoGlobal [_x, _data select 10 select 1 select _forEachIndex];
} forEach (_data select 10 select 0);

_veh setVectorUp (_data select 12);

_veh setFuelCargo (_data select 13);
_veh setAmmoCargo (_data select 14);

_weapons = [typeOf _veh] call BL_fnc_vehicleWeapons;

{
	_path = _x select 1;
	{
		_veh removeMagazinesTurret [_x, _path];
	} forEach (_x select 2);
} forEach _weapons;

{
	_path = _x select 0;
	{
		_veh addMagazineTurret [_x, _path];
	} forEach (_x select 1);
} forEach (_data select 15);