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

radarState = [];

["PVAR_radarFriendlyCheck", 'radar', {
	_returnTo   = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_position   = [_this select 1, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	_radius     = [_this select 1, 2, 5, [5]] call BIS_fnc_param;
	_friendlyTo = [_this select 1, 3, objNull, [objNull]] call BIS_fnc_param;
	
	_nearUnits = [_position, _radius] call BL_fnc_nearUnits;
	
	PVAR_radarFriendlyCheck_result = [_nearUnits, _friendlyTo] call BL_fnc_friendlyState;
	
	[_returnTo, "PVAR_radarFriendlyCheck_result"] call BL_fnc_publicVariableClient;
}] call BL_fnc_addPublicVariableEventHandler;

["PVAR_radarRequestJIPUpdate", 'radar', {
	_player = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_events = [[], []];
	
	{
		private ["_loc","_radius","_nearUnits"];
		_loc = _x select 0;
		_radius = _x select 1;

		if ( count radarState >= _forEachIndex && {!isNil {radarState select _forEachIndex}} ) then {
			_nearUnits = radarState select _forEachIndex;
			if ( count _nearUnits > 0 ) then {
				_eventType = _x select 2;
				_eventData = [_nearUnits, _x select 3];
				
				_eventIndex = (_events select 0) find _eventType;
				if ( _eventIndex == -1 ) then {
					_eventIndex = count (_events select 0);
					(_events select 0) set [_eventIndex, _eventType];
					(_events select 1) set [_eventIndex, []];
				};
				
				(_events select 1 select _eventIndex) set [count (_events select 1 select _eventIndex), _eventData];
			};
		};
	} forEach radarLocations;
	
	PVAR_radarRequestJIPUpdateResponse = _events;
	[_player, "PVAR_radarRequestJIPUpdateResponse"] call BL_fnc_publicVariableClient;
}] call BL_fnc_addPublicVariableEventHandler;

[] spawn {
	radarState = [];
	_shouldRun = 'radar' call BL_fnc_shouldRun;
	while { true } do {
		if ( _shouldRun ) then {
			{
				private ["_loc","_radius","_nearUnits","_last","_count"];
				if ( typeName _x == "ARRAY" ) then {
					_loc = _x select 0;
					_radius = _x select 1;
					
					_nearUnits = [_loc, _radius] call BL_fnc_nearUnits;
					
					if ( count radarState < _forEachIndex || {isNil {radarState select _forEachIndex}} ) then {
						radarState set [_forEachIndex, []];
					};
					
					_last = count (radarState select _forEachIndex);
					_count = count _nearUnits;
					
					if ( _last != _count ) then {
						[_x select 2, [_nearUnits, _x select 3]] call CBA_fnc_globalEvent;
					};
					
					radarState set [ _forEachIndex, _nearUnits ];
				};
			} forEach radarLocations;

			sleep 5;
		}
		else {
			sleep 30;
			_shouldRun = 'radar' call BL_fnc_shouldRun;
		};
	};
};