private ["_veh","_type","_cbArgs","_cb"];
_veh    = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_type   = [_this, 1, "veh", [""]] call BIS_fnc_param;
_cbArgs = [_this, 2, [], [[]]] call BIS_fnc_param;
_cb     = [_this, 3, false, [{}, false]] call BIS_fnc_param;

[[_veh, _type], "BL_fnc_trackVehicle", _cbArgs, _cb] call BL_fnc_call;

_veh