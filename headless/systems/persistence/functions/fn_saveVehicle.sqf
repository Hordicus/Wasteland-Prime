private ["_veh", "_cbArgs", "_cb"];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_cbArgs = [_this, 0, [], [[]]] call BIS_fnc_param;
_cb     = [_this, 2, false, [{}, false]] call BIS_fnc_param;

[[_veh], "BL_fnc_saveVehicle", _cbArgs, _cb] call BL_fnc_call;

_veh