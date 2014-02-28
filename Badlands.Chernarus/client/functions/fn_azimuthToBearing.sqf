/*
	Description:
	Translates azimuth (360) to bearing (N or North)
	
	Parameter(s):
	_direction
	_longForm (Optional) - When true use long form. e.g. North instead of N
	
	Returns:
	String - Bearing
*/

private ["_direction","_longForm","_short","_long","_index","_strings"];
_direction = [_this, 0, 0, [0]] call BIS_fnc_param;
_longForm  = [_this, 1, false, [false]] call BIS_fnc_param;

_short = [
	'N',
	'NE',
	'E',
	'SE',
	'S',
	'SW',
	'W',
	'NW',
	'N'
];

_long = [
	'North',
	'Northeast',
	'East',
	'Southeast',
	'South',
	'Southwest',
	'West',
	'Northwest',
	'North'
];

if ( _direction < 0 ) then {
	_direction = _direction + 360;
};

_index = round(_direction / 45);
_strings = if (_longForm) then { _long } else { _short };

_strings select _index