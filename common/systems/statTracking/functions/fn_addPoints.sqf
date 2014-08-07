#include "macro.sqf"
private ['_player', '_points', '_scoreboard', '_total'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_points = [_this, 1, 0, [0, ""]] call BIS_fnc_param;
_code   = [_this, 2, "", [""]] call BIS_fnc_param;

if ( typeName _points == "STRING" ) then {
	_code = _points;
	_points = [call BL_fnc_statTrackingConfig, _code] call CBA_fnc_hashGet;
};

_scoreboard = _player call BL_fnc_getPlayerScore;
_total = _points + (_scoreboard select INDEX_SCORE);

_scoreboard set [INDEX_SCORE, _total];

// Overall points (for rank)
_allTimePoints = [BL_totalPoints, _player getVariable 'uid'] call CBA_fnc_hashGet;
[BL_totalPoints, _player getVariable 'uid', _allTimePoints + _points] call CBA_fnc_hashSet;

_scoreboard set [INDEX_RANK, [_allTimePoints + _points] call BL_fnc_pointsToRank];

[_player, _scoreboard] call BL_fnc_setPlayerScore;

BL_addPointsLog set [count BL_addPointsLog, [
	BL_sessionStart,
	_player getVariable 'uid',
	_points,
	_code
]];

if ( count BL_addPointsLog > BL_addPointsLogMaxSize ) then {
	[] spawn {
		private ["_queue","_command","_values"];
		_queue = +BL_addPointsLog;
		BL_addPointsLog = [];

		_command = "INSERT INTO `player_points` (`session`, `player_uid`, `points`, `code`) VALUES ";
		_values = [];
	
		{
			_values set [_forEachIndex, format(["('%1', '%2', '%3', '%4')"] + ([_x] call BL_fnc_noEmptyArrayValues))];
		} forEach _queue;
		
		_command = _command + ([_values, ','] call CBA_fnc_join);
		[_command] call BL_fnc_MySQLCommand;
	};
};

_total