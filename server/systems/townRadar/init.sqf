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
		
		_units = [_pos, _radius] call nearUnits;
		
		_last = _state select _forEachIndex;
		_count = count _units;
		
		if ( _last != _count ) then {
			["radarUpdate", [_name, _units]] call CBA_fnc_globalEvent;
		};
		
		_state set [ _forEachIndex, _count ];
	} forEach _cities;

	sleep .1;
};