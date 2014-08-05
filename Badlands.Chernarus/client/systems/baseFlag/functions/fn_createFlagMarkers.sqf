// Remove dead markers
private ['_marker'];
{
	if ( !isNil "_x" ) then {
		_marker = _x;
		if ( {(_marker select 0) == (_x select 0)} count BL_PVAR_baseFlags == 0 ) then {
			deleteMarker (_x select 1);
		};
	};
	true
} count BL_baseFlagMarkers;

BL_baseFlagMarkers = [];
{
	private ['_owner', '_markerName', '_color'];
	_owner = (_x select 1) call BL_fnc_playerByUID;
	_markerName = format["baseFlag%1", _x select 0];

	if ( ([[_owner]] call BL_fnc_friendlyState) == "FRIENDLY" ) then {
		_color = [[([BL_baseFlagRadarState, _x select 0] call CBA_fnc_hashGet) select 0] call BL_fnc_friendlyState] call BL_fnc_stateColor;
	
		createMarkerLocal [_markerName, _x select 2];
		_markerName setMarkerShapeLocal "ELLIPSE";
		_markerName setMarkerColorLocal _color;
		_markerName setMarkerSizeLocal [125, 125];
		_markerName setMarkerAlphaLocal 0.5;
		
		BL_baseFlagMarkers set [_forEachIndex, [_x select 0, _markerName]];
	}
	else {
		deleteMarker _markerName;
	};
} forEach BL_PVAR_baseFlags;