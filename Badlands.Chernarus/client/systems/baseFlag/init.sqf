/*
BL_PVAR_baseFlags = [
	[
		UUID, // Used for radar updates
		ownerUID,
		position,
		object
	]
]
*/

BL_PVAR_baseFlags = missionNamespace getVariable ['BL_PVAR_baseFlags', []];
BL_baseFlagMarkers = [];
BL_baseFlagState = [[], "EMPTY"] call CBA_fnc_hashCreate;

['baseFlag', 'Base flag', "Land_Suitcase_F", [], {
	[15, "Deploying Base Flag %1", [], {
		PVAR_createBaseFlag = [player, getPosATL player];
		publicVariableServer "PVAR_createBaseFlag";
		'baseFlag' call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
}] call BL_fnc_addInventoryType;

["Repack Base Flag",
{(_this select 0) isKindOf "Land_Communication_F" && {{(_x select 3) == (_this select 0)} count BL_PVAR_baseFlags > 0}},
{
	[60, 'Repacking Base Flag %1', [_this select 0], {
		'baseFlag' call BL_fnc_addInventoryItem;
		PVAR_destroyBaseFlag = [player, _this select 0];
		publicVariableServer "PVAR_destroyBaseFlag";
	}] call BL_fnc_animDoWork;
}] call BL_fnc_addAction;

["Destroy Base Flag",
{(_this select 0) isKindOf "Land_Communication_F" && {{(_x select 3) == (_this select 0)} count BL_PVAR_baseFlags > 0}},
{
	[30, 'Destroying Base Flag %1', [_this select 0], {
		PVAR_destroyBaseFlag = [player, _this select 0];
		publicVariableServer "PVAR_destroyBaseFlag";
	}] call BL_fnc_animDoWork;
}] call BL_fnc_addAction;

[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};
	[] call BL_fnc_createFlagMarkers;
	
	"BL_PVAR_baseFlags" addPublicVariableEventHandler {
		[] call BL_fnc_createFlagMarkers;
	};
	
	['updateBaseFlags', {
		[] call BL_fnc_createFlagMarkers;
	}] call CBA_fnc_addEventHandler;

	['baseFlag', {
		_players = _this select 0;
		_code = _this select 1 select 0;
		_state = [_players] call BL_fnc_friendlyState;
		
		_color = _state call {
			if ( _this == "FRIENDLY" ) exitwith {"ColorGreen"};
			if ( _this == "ENEMY" ) exitwith {"ColorRed"};
			if ( _this == "MIXED" ) exitwith {"ColorOrange"};
			if ( _this == "EMPTY" ) exitwith {"ColorBlack"};
		};
		
		(format["baseFlag%1", _code]) setMarkerColorLocal _color;
		
		if ( player in _players ) then {
			_last = [BL_baseFlagState, _code] call CBA_fnc_hashGet;
			
			if ( _last in ["EMPTY", "FRIENDLY"] && _state in ["ENEMY", "MIXED"] ) then {
				hint "Warning! An enemy player has entered the area";
			};
		};
		
		[BL_baseFlagState, _code, _state] call CBA_fnc_hashSet;
	}] call CBA_fnc_addEventHandler;
};