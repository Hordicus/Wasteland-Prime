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
