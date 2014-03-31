['spawnBeacon', [
	// Save
	{[
		(_this select 0) getVariable 'beaconType',
		(_this select 0) getVariable 'objectOwner'
	]},
	
	// Load
	{
		[
			(_this select 1) select 0,
			(_this select 1) select 1,
			getPosATL (_this select 0),
			getDir (_this select 0),
			_this select 0
		] call BL_fnc_createBeaconServer;
		
		(_this select 0) setVariable ['beaconType', _this select 1 select 0];
		(_this select 0) setVariable ['objectOwner', _this select 1 select 1];
	}
]] call BL_fnc_persRegisterTypeHandler;