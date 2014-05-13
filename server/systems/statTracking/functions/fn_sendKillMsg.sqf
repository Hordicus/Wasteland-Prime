private ['_player', '_killer', '_msg'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_killer = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
_bounty = [_this, 2, -1, [0]] call BIS_fnc_param;

if ( isPlayer _player ) then {
	_msg = format['%1 was killed', _player getVariable 'name'];

	if ( isPlayer _killer && _killer != _player ) then {
		_msg = _msg + format[' by %1 [$%1]', _killer getVariable 'name', _bounty];
	};

	[[_msg], 'BL_fnc_showKillMsg'] call BIS_fnc_MP;
}
else {
	if ( _bounty != -1 && isPlayer _killer ) then {
		[format['$%1 bounty awarded', _bounty], "BL_fnc_showKillMsg", owner _killer] call BIS_fnc_MP;
	};
};