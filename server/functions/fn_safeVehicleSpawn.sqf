private ["_class","_position","_dir"];
_class = [_this, 0, "", [""]] call BIS_fnc_param;
_position = [_this, 1, [0,0,0], [[]], [3, 2]] call BIS_fnc_param;
_dir = [_this, 2, random 359, [0]] call BIS_fnc_param;

if ( count _position == 2 ) then {
	_position set [2, 0];
};

_veh = createVehicle [_class, _position, [], 0, "CAN_COLLIDE"];
[_veh, _position, _dir] call BL_fnc_safeVehicleSetPos;

_veh