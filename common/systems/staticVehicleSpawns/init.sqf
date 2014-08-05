if !( 'vehicleSpawns' call BL_fnc_shouldRun ) exitwith{};

[] spawn {
	private ['_config', '_spawns', '_veh'];
	_config = [] call BL_fnc_staticVehicleSpawnsConfig;
	_spawns = [_config, 'spawns'] call CBA_fnc_hashGet;
	
	{
		_veh = createVehicle [_x select 0, _x select 1, [], 0, "CAN_COLLIDE"];
		[_veh, 'static'] call BL_fnc_trackVehicle;
		
		_veh setDir (_x select 2);
		_veh setPosATL (_x select 1);
		
		[_veh] call (_x select 3);
		
		_veh setVariable ['staticSpawnIndex', _forEachIndex];
	} forEach _spawns;
};