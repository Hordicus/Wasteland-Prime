private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

PVAR_adminLog = [player, format["%1 (%2) cleared %3's (%4) inventory", name player, getPlayerUID player, name _player, getPlayerUID _player]];
publicVariableServer "PVAR_adminLog";

removeAllWeapons _player;
removeAllItems _player;
removeBackpack _player;
removeVest _player;
removeUniform _player;
removeHeadgear _player;
removeGoggles _player;
removeAllAssignedItems _player;