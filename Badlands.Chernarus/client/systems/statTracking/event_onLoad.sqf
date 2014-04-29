#include "functions\macro.sqf"
uiNamespace setVariable ['scoreboard', _this select 0];

[_this select 0, 0] call BL_fnc_showPlayers;