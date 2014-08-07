private ['_scoreboard', '_noUnit', '_data'];
// [_rank, _side, _playerName, _bounty, _kills, _deaths, _score ],
_scoreboard = [];
_noUnit = name objNull;
{
	if ( isPlayer _x && name _x != _noUnit ) then {
		_data = BL_Logic getVariable [format['%1%2', side _x, name _x], [0,0,0,0,0]];
		
		_scoreboard set [_forEachIndex, [
			_data select 0,
			_x getVariable 'side',
			name _x,
			_data select 1,
			_data select 2,
			_data select 3,
			_data select 4
		]];
	};
} forEach (playableUnits + allDead);

_scoreboard = [
	_scoreboard,
	[],
	{ _x select 6 },
	"DESCEND"
] call BIS_fnc_sortBy;

_scoreboard