"createSpawnBeacon" addPublicVariableEventHandler {
	(_this select 1) call BL_fnc_createBeaconServer;
};

"destroySpawnBeacon" addPublicVariableEventHandler {
	_player = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_beacon = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	
	if ( !isPlayer _player ) exitwith{};
	
	// Remove from BL_spawnBeacons
	{
		if ( _x select 2 == _beacon ) exitwith{
			BL_spawnBeacons set [_forEachIndex, "REMOVE"];
			BL_spawnBeacons = BL_spawnBeacons - ["REMOVE"];
		};
	} forEach BL_spawnBeacons;
	
	publicVariable "BL_spawnBeacons";
	
	[_beacon] call BL_fnc_deleteVehicleDB;
	deleteVehicle _beacon;
};

[] spawn {
	// Altitude, available slots
	_minAlt = 100;
	_helicopters = [[], [objNull, 0, 0]] call CBA_fnc_hashCreate;

	// Monitor helicopters. Notify players when state changes.
	while { true } do {
		{
			_allPassengerSlots = getArray (configFile >> "CfgVehicles" >> (typeOf _x) >> "cargoAction");
			_crew = crew _x;
			_usedPassengerSlots = 0;
			
			{
				if ( "Cargo" in (assignedVehicleRole _x) ) then {
					_usedPassengerSlots = _usedPassengerSlots + 1;
				};
			} count _crew;
			
			_cargoRoom = (count _allPassengerSlots) - _usedPassengerSlots;
			_altitude = (getPosATL _x) select 2;
			_netId = netId _x;
			_lastCheck = [_helicopters, _netId] call CBA_fnc_hashGet;
			
			if (
			// Pilot change
			(
				(
					(isNull (_lastCheck select 0) && !isNull(driver _x)) ||
					(!isNull (_lastCheck select 0) && isNull(driver _x))
				) ||
				(
					(!isNull (_lastCheck select 0) && !isNull(driver _x)) &&
					((_lastCheck select 0) != driver _x)
				)
			) ||
			
			// Altitude change
			(_altitude >= _minAlt && _lastCheck select 1 < _minAlt ) ||
			(_altitude < _minAlt && _lastCheck select 1 >= _minAlt ) ||
			
			// Cargo room change
			( _cargoRoom < 1 && _lastCheck select 2 >= 1) ||
			( _cargoRoom >= 1 && _lastCheck select 2 < 1)
			) then {
				['airUpdate', [_netId, driver _x, _altitude, _cargoRoom]] call CBA_fnc_globalEvent;
			};
			
			[_helicopters, _netId, [driver _x, _altitude, _cargoRoom]] call CBA_fnc_hashSet;
			sleep 0.5;
		} count (entities 'Air');
	};
};