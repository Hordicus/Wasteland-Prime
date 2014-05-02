#include "macro.sqf"
private ['_player', '_score', '_scoreboard', '_total'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_score  = [_this, 1, 0, [0]] call BIS_fnc_param;

_scoreboard = _player call BL_fnc_playerScoreboard;
_total = _score + (_scoreboard select INDEX_SCORE);

_scoreboard set [INDEX_SCORE, _total];

_total