private['_loc','_eventName'];
_loc = [_this, 0, [0,0,0], [[]], [2, 3]] call BIS_fnc_param;
_eventName = [_this, 1, '', ['']] call BIS_fnc_param;

{
	if ( _loc distance (_x select 0) < 1 && _x select 2 == _eventName ) exitwith {
		radarLocations set [_forEachIndex, "REMOVE"];
		radarLocations = radarLocations - ["REMOVE"];
	};
} forEach radarLocations;


true