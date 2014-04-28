private ['_veh', '_index', '_cfg'];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_index = _veh getVariable 'staticSpawnIndex';

_cfg = ([call BL_fnc_staticVehicleSpawnsConfig, 'spawns'] call CBA_fnc_hashGet) select _index;

[_cfg, _index] spawn {
	private ['_cfg', '_index'];
	_cfg = _this select 0;
	_index = _this select 1;
	
	// Wait respawn time
	sleep (_cfg select 4);
	
	_veh = [_cfg select 0, _cfg select 1, _cfg select 2] call BL_fnc_safeVehicleSpawn;
	[_veh, 'static'] call BL_fnc_trackVehicle;

	[_veh] call (_cfg select 3);
	
	_veh setVariable ['staticSpawnIndex', _index];
};