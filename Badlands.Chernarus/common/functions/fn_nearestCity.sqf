private ['_loc', '_nearestDistance', '_nearestCity', '_dist'];
_loc = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_nearestDistance = -1;
_nearestCity = [];

{
	_dist = _loc distance (_x select 1);
	if ( _dist < _nearestDistance || _nearestDistance == -1 ) then {
		_nearestDistance = _dist;
		_nearestCity = _x;
	};
} forEach ([] call BL_fnc_findCities);

_nearestCity