private ['_amount', '_player', '_current'];
_amount = [_this, 0, 0, [0]] call BIS_fnc_param;
_player = [_this, 1, player, [objNull]] call BIS_fnc_param;

_current = _player getVariable ['money', 0];

if ( typeName _current != "SCALAR" ) then {
	_current = parseNumber _current;
};

if ( typeName _amount != "SCALAR" ) then {
	_amount = parseNumber _amount;
};

_player setVariable ['money', _current + _amount, true];

(_current + _amount)