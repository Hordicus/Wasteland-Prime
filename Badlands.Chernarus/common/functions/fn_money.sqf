private ['_player', '_current'];
_player = [_this, 0, player, [objNull]] call BIS_fnc_param;
_current = _player getVariable ['money', 0];

if ( typeName _current != "SCALAR" ) then {
	_current = parseNumber _current;
};

_current