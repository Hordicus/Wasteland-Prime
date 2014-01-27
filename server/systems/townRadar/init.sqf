#include "\x\cba\addons\main\script_macros_common.hpp"
_cities = call compile preprocessFileLineNumbers 'common\functions\findCities.sqf';
_state = [];

// Set up default state
{
	_state set [ _forEachIndex, 0 ];
} forEach _cities;

while { true } do {
	{
		_name   = _x select 0;
		_pos    = _x select 1;
		_radius = _x select 2;
		
		_entities = _pos nearEntities [["Man", "Air", "Car"], _radius];
		_animals = _pos nearEntities ["Animal", _radius];
		_entities = _entities - _animals; // Why are Animals of type Man?
		
		_last = _state select _forEachIndex;
		_count = count _entities;
		
		if ( _last != _count ) then {
			["radarUpdate", [_name, _entities]] call CBA_fnc_globalEvent;
		};
		
		_state set [ _forEachIndex, _count ];
	} forEach _cities;

	sleep .1;
};