private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

PVAR_adminLog = [player, format['%1 (%2) started freelook camera at %3 (%4)', name player, getPlayerUID player, name _player, getPlayerUID _player]];
publicVariableServer "PVAR_adminLog";

['Paste', [worldname,getPosATL _player,0,0.7,[0,0],0,0,daytime * 60,overcast,0]] call BIS_fnc_camera;