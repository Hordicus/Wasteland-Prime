/* ----------------------------------------------------------------------------
Function: BL_fnc_flyingRespawnOptions

Description:
	Finds friendly units and checks if they are a pilot.
	Helicopters/planes must have altitude of 50m+

Parameters:

Returns:
	array of spawn options

---------------------------------------------------------------------------- */

#include "macro.sqf"
private ['_airVehicles', '_result'];
_spawnInVehicle = {
	_veh = _this select 0;
	player moveInCargo (objectFromNetId _veh);
	[] spawn {
		waitUntil { vehicle player != player };
		closeDialog respawnDialogIDD;
	};
	true
};

_airVehicles = [_this, 0, playerRespawn_air, [[]], [4]] call BIS_fnc_param;
_result = [];

[_airVehicles, {
	private ['_veh'];
	_veh = objectFromNetId _key;
	if ( !isNull _veh && ([[_value select 0]] call BL_fnc_friendlyState) == "FRIENDLY" ) then {
		private ['_info', '_errors', '_nearestCity', '_heliType'];
		_info = '';
		_errors = [];
		
		if ( _value select 2 <= 0 ) then {
			_errors set [count _errors, 'has no room'];
		};
		
		if ( _value select 1 < 100 ) then {
			_errors set [count _errors, 'is flying too low'];
		};
		
		if ( count _errors > 0 ) then {
			_info = format['The vehicle %1', [_errors, ' and '] call CBA_fnc_join];
		};
		
		if ( _info == '' ) then {
			_nearestCity = [(getPosATL _veh)] call BL_fnc_nearestCity;
			_heliType = getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
			
			_info = format['%1 %2 of %3', _heliType, [getPosATL _veh, (_nearestCity select 1)] call BL_fnc_directionToString, _nearestCity select 0];
		};
		
		_result set [count _result, [
			name (_value select 0),
			_info,
			_veh,
			count _errors > 0,
			[_key],
			_spawnInVehicle
		]];
	};
}] call CBA_fnc_hashEachPair;

_result