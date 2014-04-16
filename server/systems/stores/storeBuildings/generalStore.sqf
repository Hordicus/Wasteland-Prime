private ['_location', '_direction', '_keeper'];
_location = _this select 0;
_direction = _this select 1;

_keeper = createVehicle ['C_man_p_fugitive_F_asia', [_location, 3, _direction + 45 ] call BIS_fnc_relPos, [], 0, "CAN_COLLIDE"];
_keeper setDir _direction-180;
_keeper allowDamage false;
_keeper enableSimulationGlobal false;
[_keeper] call BL_fnc_trackVehicle;

_keeper