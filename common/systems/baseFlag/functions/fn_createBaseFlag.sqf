private ['_playerUID', '_location', '_object'];
_playerUID = [_this, 0, "", [""]] call BIS_fnc_param;
_location  = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_object    = [_this, 2, objNull, [objNull]] call BIS_fnc_param;

if ( isNull _object ) then {
	_location set [2, (_location select 2) - 3];
	_object = createVehicle ["Land_SatellitePhone_F", _location, [], 0, "CAN_COLLIDE"];
	_object setVectorUp [0,0,1];
	_object setPosATL _location;
	_object setVariable ['ownerUID', _playerUID];
	[_object, 'baseFlag'] call BL_fnc_trackVehicle;
	[_object] call BL_fnc_saveVehicle;
};

_object allowDamage false;
_object enableSimulationGlobal true;
_object removeAllEventHandlers 'Killed'; // Disables deleting from DB on killed... just in case.

_info = [
	9 call BL_fnc_randStr, // random code to use for radar updates
	_playerUID,
	_location,
	_object
];

BL_PVAR_baseFlags = missionNamespace getVariable ['BL_PVAR_baseFlags', []];
BL_PVAR_baseFlags set [count BL_PVAR_baseFlags, _info];

publicVariable "BL_PVAR_baseFlags";

[_location, 125, 'baseFlagRadar', [_info select 0, _info select 1]] call BL_fnc_registerLocWithRadar;
[_location, 75, 'baseFlagBlock', [_info select 0, _info select 1]] call BL_fnc_registerLocWithRadar;

_object