private ['_player', '_move', '_allowed'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_move   = [_this, 1, "", [""]] call BIS_fnc_param;

_allowed = [
	"AovrPercMrunSrasWrflDf"
];

if ( isPlayer _player && _move in _allowed ) then {
	_player switchMove _move;
};