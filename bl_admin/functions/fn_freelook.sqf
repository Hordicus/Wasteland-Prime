private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

PVAR_adminLog = [player, format['%1 (%2) started freelook camera at %3 (%4)', name player, getPlayerUID player, name _player, getPlayerUID _player]];
publicVariableServer "PVAR_adminLog";

[getPosATL _player] call BLAdmin_fnc_camera;