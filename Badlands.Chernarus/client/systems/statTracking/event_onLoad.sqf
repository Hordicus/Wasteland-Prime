#include "functions\macro.sqf"
uiNamespace setVariable ['scoreboard', _this select 0];

[_this select 0, 0] call BL_fnc_showPlayers;

{
	if ( _x select 1 == playerSide && _x select 2 == name player ) exitwith {
		[_this select 0, 10, _forEachIndex+1, _x] call BL_fnc_setRow;
	};
} forEach ([] call BL_fnc_buildScoreboard);