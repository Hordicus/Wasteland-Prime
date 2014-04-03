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
private ['_friendlies', '_airVehicles', '_result'];
_spawnInVehicle = {
	_veh = _this select 0;
	player moveInCargo _veh;
	closeDialog respawnDialogIDD;
};

_friendlies = playableUnits call BL_fnc_filterFriendly;
_airVehicles = [];
_result = [];
{
	_veh = vehicle _x;
	
	// In vehicle, is driver, vehicle is of type air
	if ( _veh != _x && driver _veh == _x && _veh isKindOf 'Air') then {
		_allPassengerSlots = getArray (configFile >> "CfgVehicles" >> (typeOf _veh) >> "cargoAction");
		_crew = crew _veh;
		_usedPassengerSlots = 0;
		
		{
			if ( "Cargo" in (assignedVehicleRole _x) ) then {
				_usedPassengerSlots = _usedPassengerSlots + 1;
			};
		} count _crew;
		
		_hasRoom = count _allPassengerSlots > _usedPassengerSlots;
		_highEnough = ((getPosATL _veh) select 2 >= 100);
		_locked = (locked _veh) == 2;
		_info = '';
		_errors = [];
		
		if ( !_hasRoom ) then {
			_errors set [count _errors, 'has no room'];
		};
		
		if ( !_highEnough ) then {
			_errors set [count _errors, 'is flying too low'];
		};
		
		if ( _locked ) then {
			_errors set [count _errors, 'is locked'];
		};
		
		if ( count _errors > 0 ) then {
			_info = format['The vehicle %1', [_errors, ' and '] call CBA_fnc_join];
		};
		
		if ( _info == '' ) then {
			_nearestCity = (getPosATL _veh) call BL_fnc_nearestCity;
			_heliType = getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
			
			_info = format['%1 %2 of %3', _heliType, [getPosATL _veh, (_nearestCity select 1)] call BL_fnc_directionToString, _nearestCity select 0];
		};
		
		_result set [count _result, [
			name driver _veh,
			_info,
			round(_veh distance playerRespawn_lastDeath),
			count _errors > 0,
			[_veh],
			_spawnInVehicle
		]];
	};
} count _friendlies;

_result