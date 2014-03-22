/*
	Description:
	Finds the first LOG container in an area
	
	Parameter(s):
	_position
	_radius
	
	Returns:
	First container found or objNull
*/

private ['_position', '_radius', '_container'];
_position = [_this, 0, [0,0,0], [[]], [3]] call BIS_fnc_param;
_radius = [_this, 1, 5, [0]] call BIS_fnc_param;
_container = objNull;

{
	if ( _x call LOG_fnc_containerSize > 0 ) exitwith {
		_container = _x;
	};
} forEach (nearestObjects [_position, ["All"], _radius]);

_container