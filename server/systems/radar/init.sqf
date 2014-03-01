#include "\x\cba\addons\main\script_macros_common.hpp"
private ['_locations', '_state'];
_dir = __FILE__ call BL_fnc_getDirectory;

BL_fnc_registerLocWithRadar = compileFinal preprocessFileLineNumbers (_dir + "\functions\fn_registerLocWithRadar.sqf");
radarLocations = [
	/*
	[
		[location],
		radius,
		"eventNameToTrigger",
		dataToPassToTrigger
	]
	
	*/
];

_state = [];

while { true } do {
	{
		_loc = _x select 0;
		_radius = _x select 1;
		
		_nearUnits = [_loc, _radius] call nearUnits;
		
		if ( isNil {_state select _forEachIndex} ) then {
			_state set [_forEachIndex, 0];
		};
		
		_last = _state select _forEachIndex;
		_count = count _nearUnits;
		
		if ( _last != _count ) then {
			[_x select 2, [_nearUnits, _x select 3]] call CBA_fnc_globalEvent;
		};
		
		_state set [ _forEachIndex, _count ];
	} forEach radarLocations;

	sleep .1;
};