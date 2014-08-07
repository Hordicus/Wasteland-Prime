private ['_scoreboard', '_page', '_players'];
_scoreboard = [_this, 0, displayNull, [displayNull]] call BIS_fnc_param;
_page = [_this, 1, 0, [0]] call  BIS_fnc_param;

_players = [] call BL_fnc_buildScoreboard;

_offset = 10 * _page;

for "_i" from _offset to _offset+9 do {
	if ( _i < count _players ) then {
		[_scoreboard, _i, _i+1, _players select _i] call BL_fnc_setRow;
	}
	else {
		[_scoreboard, _i] call BL_fnc_setRow;
	};
};