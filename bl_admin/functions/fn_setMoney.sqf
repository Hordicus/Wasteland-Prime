private ['_player', '_amount'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_amount = [_this, 1, 0, [0]] call BIS_fnc_param;

PVAR_adminLog = [player, format["%1 (%2) set %3's (%4) money to $%5", name player, getPlayerUID player, name _player, getPlayerUID _player, _amount]];
publicVariableServer "PVAR_adminLog";

_player setVariable ['money', _amount, true];