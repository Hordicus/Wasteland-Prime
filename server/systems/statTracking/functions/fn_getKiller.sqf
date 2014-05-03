private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

if !( _player isKindOf "Man" ) then {
	_player = effectiveCommander _player;
};

_player