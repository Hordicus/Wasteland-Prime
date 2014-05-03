private ['_player', '_killer', '_msg'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_killer = [_this, 1, objNull, [objNull]] call BIS_fnc_param;

_msg = format['%1 was killed', _player getVariable 'name'];

if ( isPlayer _killer && _killer != _player ) then {
	_msg = _msg + format[' by %1', _killer getVariable 'name'];
};

[[_msg], 'BL_fnc_showKillMsg'] call BIS_fnc_MP;