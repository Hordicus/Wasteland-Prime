if ( !hasInterface ) exitwith{};
BL_PVAR_storeAccessObjects = missionNamespace getVariable ['BL_PVAR_storeAccessObjects', []];

[[] call BL_fnc_storeConfig, {
	private ['_marker', '_markerLabel', '_radius', '_color'];
	_color = [_value, 3, "ColorBlack", [""]] call BIS_fnc_param;
	
	{
		_radius = [_x, 2, 0, [0]] call BIS_fnc_param;
		if ( _radius > 0 ) then {
			_marker = format['%1%2', _key, _forEachIndex];
			createMarkerLocal [_marker, _x select 0];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerColorLocal "ColorBlack";
			_marker setMarkerSizeLocal [100, 100];
			_marker setMarkerAlphaLocal 0.5;
			
		};

		_markerLabel = format['%1%2Label', _key, _forEachIndex];
		createMarkerLocal [_markerLabel, _x select 0];
		_markerLabel setMarkerShapeLocal "ICON";
		_markerLabel setMarkerTypeLocal "mil_dot_noshadow";
		_markerLabel setMarkerColorLocal _color;
		_markerLabel setMarkerAlphaLocal 0.5;
		_markerLabel setMarkerTextLocal (_value select 0);
	} forEach (_value select 2);
}] call CBA_fnc_hashEachPair;

BL_storeRadarState = [[], "EMPTY"] call CBA_fnc_hashCreate;
['storeRadar', {
	_players = _this select 0;
	_marker = _this select 1 select 0;
	_state = [_players] call BL_fnc_friendlyState;
	
	_marker setMarkerColorLocal (_state call BL_fnc_stateColor);
	
	if ( player in _players ) then {
		_last = [BL_storeRadarState, _marker] call CBA_fnc_hashGet;
		
		if ( _last in ["EMPTY", "FRIENDLY"] && _state in ["ENEMY", "MIXED"] ) then {
			hint "Warning! An enemy player has entered the area";
		};
	};
	
	[BL_storeRadarState, _marker, _state] call CBA_fnc_hashSet;
}] call CBA_fnc_addEventHandler;

[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};
	
	private ['_config', '_store'];
	_config = [] call BL_fnc_storeConfig;

	{
		_store = [_config, _x select 0] call CBA_fnc_hashGet;
		(_x select 1) addAction [format['<t color="#ff0000"><img image="client\systems\stores\icons\store.paa" /> %1</t>', _store select 0], _store select 1, [], 1.5, true, true];
		true
	} count BL_PVAR_storeAccessObjects;
};