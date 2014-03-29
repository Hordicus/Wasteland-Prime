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

"PVAR_radarFriendlyCheck" addPublicVariableEventHandler {
	_returnTo   = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_position   = [_this select 1, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	_radius     = [_this select 1, 2, 5, [5]] call BIS_fnc_param;
	_friendlyTo = [_this select 1, 3, objNull, [objNull]] call BIS_fnc_param;
	
	_nearUnits = [_position, _radius] call BL_fnc_nearUnits;
	
	PVAR_radarFriendlyCheck_result = [_nearUnits, _friendlyTo] call BL_fnc_friendlyState;
	
	(owner _returnTo) publicVariableClient "PVAR_radarFriendlyCheck_result";
};

[] spawn {
	private ['_state'];
	_state = [];
	while { true } do {
		{
			private ["_loc","_radius","_nearUnits","_last","_count"];
			_loc = _x select 0;
			_radius = _x select 1;
			
			_nearUnits = [_loc, _radius] call BL_fnc_nearUnits;
			
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
};