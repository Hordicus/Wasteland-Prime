private ['_location', '_direction', '_keeper', '_shop', '_loadingPad'];
_location = _this select 0;
_direction = _this select 1;

_keeper = createVehicle ['C_man_p_fugitive_F_asia', [_location, 3, _direction + 45 ] call BIS_fnc_relPos, [], 0, "CAN_COLLIDE"];
_keeper setDir _direction-180;

_shop = createVehicle ['Land_Slum_House02_F', _location, [], 0, "CAN_COLLIDE"];
_shop setDir _direction;
_shop setPosATL _location;

_loadingPad = createVehicle ['Land_JumpTarget_F', [_location, 8, _direction - 90] call BIS_fnc_relPos, [], 0, "CAN_COLLIDE"];

{
	_x allowDamage false;
	_x enableSimulationGlobal false;
} count [_shop, _keeper, _loadingPad];

[_keeper] call BL_fnc_trackVehicle;
[_shop] call BL_fnc_trackVehicle;
[_loadingPad] call BL_fnc_trackVehicle;

_keeper