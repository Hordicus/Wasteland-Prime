// Remove all markers
{
	if ( !isNil "_x" ) then {
		deleteMarker _x;
	};
	true
} count BL_baseFlagMarkers;

BL_baseFlagMarkers = [];
{
	private ['_owner', '_markerName', '_color'];
	_owner = (_x select 1) call BL_fnc_playerByUID;

	if ( ([[_owner]] call BL_fnc_friendlyState) == "FRIENDLY" ) then {
		_color = [[([BL_baseFlagState, _x select 0] call CBA_fnc_hashGet) select 0] call BL_fnc_friendlyState] call BL_fnc_stateColor;
	
		_markerName = format["baseFlag%1", _x select 0];
		createMarkerLocal [_markerName, _x select 2];
		_markerName setMarkerShapeLocal "ELLIPSE";
		_markerName setMarkerColorLocal _color;
		_markerName setMarkerSizeLocal [100, 100];
		_markerName setMarkerAlphaLocal 0.5;
		
		BL_baseFlagMarkers set [_forEachIndex, _markerName];
	};
} forEach BL_PVAR_baseFlags;