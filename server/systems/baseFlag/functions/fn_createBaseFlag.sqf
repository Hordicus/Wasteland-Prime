private ['_playerUID', '_location', '_object'];
_playerUID = [_this, 0, "", [""]] call BIS_fnc_param;
_location  = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_object    = [_this, 2, objNull, [objNull]] call BIS_fnc_param;

if ( isNull _object ) then {
	_object = createVehicle ["Land_Communication_F", _location, [], 0, "CAN_COLLIDE"];
	_object setVariable ['ownerUID', _playerUID];
	[_object, 'baseFlag'] call BL_fnc_trackVehicle;
	[_object] call BL_fnc_saveVehicle;
};

_info = [
	9 call BL_fnc_randStr, // random code to use for radar updates
	_playerUID,
	_location,
	_object
];

BL_PVAR_baseFlags = missionNamespace getVariable ['BL_PVAR_baseFlags', []];
BL_PVAR_baseFlags set [count BL_PVAR_baseFlags, _info];

publicVariable "BL_PVAR_baseFlags";

[_location, 100, 'baseFlag', [_info select 0, _info select 1]] call BL_fnc_registerLocWithRadar;

_object