if ( isServer ) exitwith{};

radarLocations = missionNamespace getVariable ['radarLocations', [
	/*
	[
		[location],
		radius,
		"eventNameToTrigger",
		dataToPassToTrigger
	]
	
	*/
]];

radarState = [];

[] spawn {
	while { true } do {
		{
			private ["_loc","_radius","_nearUnits","_last","_count"];
			if ( typeName _x == "ARRAY" ) then {
				_loc = _x select 0;
				_radius = _x select 1;
				
				if ( _loc distance player < 1000 ) then {
					_nearUnits = [_loc, _radius] call BL_fnc_nearUnits;
					
					if ( count radarState < _forEachIndex || {isNil {radarState select _forEachIndex}} ) then {
						radarState set [_forEachIndex, []];
					};
					
					_last = count (radarState select _forEachIndex);
					_count = count _nearUnits;
					
					if ( _last != _count ) then {
						[_x select 2, [_nearUnits, _x select 3]] call CBA_fnc_localEvent;
					};
					
					radarState set [ _forEachIndex, _nearUnits ];
				};
			};
		} forEach radarLocations;
		sleep 0.1;
	};
};