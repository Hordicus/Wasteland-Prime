#include "functions\macro.sqf"
uiNamespace setVariable ['scoreboard', _this select 0];

[_this select 0, 0] call BL_fnc_showPlayers;

// Find current player
{
	if ( _x select 1 == playerSide && _x select 2 == name player ) exitwith {
		[]
	};
	true
} forEach BL_scoreboard;

private ['_players'];
_players = [
	BL_scoreboard,
	[],
	{ _x select 6 },
	"DESCEND"
] call BIS_fnc_sortBy;

{
	if ( _x select 1 == playerSide && _x select 2 == name player ) exitwith {
		[_this select 0, 10, _forEachIndex+1, _x] call BL_fnc_setRow;
	};
} forEach _players;