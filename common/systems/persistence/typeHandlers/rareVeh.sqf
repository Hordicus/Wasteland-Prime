['rareVeh', [
	// Save
	{(_this select 0) getVariable ['originalSpawnPoint', getPosATL (_this select 0)]},
	
	// Load
	{
		(_this select 0) setVariable ['originalSpawnPoint', _this select 1];
	}
]] call BL_fnc_persRegisterTypeHandler;