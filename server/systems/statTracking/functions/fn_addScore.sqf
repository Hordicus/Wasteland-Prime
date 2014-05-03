#include "macro.sqf"
private ['_player', '_score', '_scoreboard', '_total'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_score  = [_this, 1, 0, [0, ""]] call BIS_fnc_param;
_code   = [_this, 2, "", [""]] call BIS_fnc_param;

if ( typeName _score == "STRING" ) then {
	_code = _score;
	_score = [call BL_fnc_statTrackingConfig, _code] call CBA_fnc_hashGet;
};

_scoreboard = _player call BL_fnc_playerScoreboard;
_total = _score + (_scoreboard select INDEX_SCORE);

_scoreboard set [INDEX_SCORE, _total];

BL_addScoreLog set [count BL_addScoreLog, [
	BL_sessionStart,
	_player getVariable 'uid',
	_score,
	_code
]];

if ( count BL_addScoreLog > 0 ) then {
	[] spawn {
		private ["_queue","_command","_values"];
		_queue = +BL_addScoreLog;
		BL_addScoreLog = [];

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