/*
	Description:
	Calculates relative direction and translates
	it to a string.
	
	Parameter(s):
	_fromPos
	_toPos
	
	Returns:
	String
	
*/

_fromPos = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_toPos = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

_directionTo = [([_toPos, _fromPos] call BIS_fnc_dirTo), true] call BL_fnc_azimuthToBearing;
_distance = round(_fromPos distance _toPos);

format['%1m %2', _distance, _directionTo]