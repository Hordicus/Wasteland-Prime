private['_loc', '_radius', '_eventName', '_data'];

_loc = [_this, 0, [0,0,0], [[]], [2, 3]] call BIS_fnc_param;
_radius = [_this, 1, 100, [0]] call BIS_fnc_param;
_eventName = [_this, 2, '', ['']] call BIS_fnc_param;
_data = [_this, 3, [], [[]]] call BIS_fnc_param;

radarLocations set [count radarLocations, [
	_loc,
	_radius,
	_eventName,
	_data
]];

true