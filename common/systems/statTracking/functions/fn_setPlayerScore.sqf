private ['_player', '_data'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_data   = [_this, 1, [], [[]], [5]] call BIS_fnc_param;

BL_Logic setVariable [
	format['%1%2', _player getVariable 'side', _player getVariable 'name'],
	_data,
	true
];