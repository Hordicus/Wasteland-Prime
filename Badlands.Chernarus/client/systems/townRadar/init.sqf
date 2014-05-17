if ( !hasInterface ) exitwith{};
_cities = call BL_fnc_findCities;

{
	_name = format['marker_%1', _x select 0];
	_radius = _x select 2;

	createMarkerLocal [_name, _x select 1];
	_name setMarkerShapeLocal "ELLIPSE";
	_name setMarkerColorLocal "ColorBlack";
	_name setMarkerSizeLocal [_radius, _radius];
	_name setMarkerAlphaLocal 0.5;
} forEach _cities;

stateHistory = [[], [[], "EMPTY"]] call CBA_fnc_hashCreate;

["radarUpdate", {
	private ["_town", "_players", "_color", "_last", "_state"];
	diag_log format["Got radarUpdate: %1", _this];
	
	_players = _this select 0;
	_town = _this select 1 select 0;
	_state = [_players] call BL_fnc_friendlyState;

	// Set the town marker to the appropriate color
	(format["marker_%1", _town]) setMarkerColorLocal (_state call BL_fnc_stateColor);
	
	// Alerts for when player is in area
	if ( player in _players ) then {
		_last = ([stateHistory, _town] call CBA_fnc_hashGet) select 1;
		
		if ( _last in ["EMPTY", "FRIENDLY"] && _state in ["ENEMY", "MIXED"] ) then {
			hint "Warning! An enemy player has entered the area";
		};
	};
	
	[stateHistory, _town, [_players, _state]] call CBA_fnc_hashSet;
}] call CBA_fnc_addEventHandler;

['groupChange', {
	// Update state of town radar
	[stateHistory, {
		_state = [_value select 0] call BL_fnc_friendlyState;
		_value set [1, _state];
		(format["marker_%1", _key]) setMarkerColorLocal (_state call BL_fnc_stateColor);
	}] call CBA_fnc_hashEachPair;
}] call CBA_fnc_addEventHandler;