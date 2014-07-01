missionCount = 0;
runningMissionLocations = [] call CBA_fnc_hashCreate;
runningMissions = [] call CBA_fnc_hashCreate;
BL_particleSources = missionNamespace getVariable ["BL_particleSources", [[], []] call CBA_fnc_hashCreate];

// JIP for particle sources
["initPlayerServer", {
	_player = _this select 0;
	[BL_particleSources, {
		[_value, "BL_fnc_particleSourceCreate", _player] call BIS_fnc_MP;
	}] call CBA_fnc_hashEachPair;
}] call CBA_fnc_addEventHandler;

[] spawn {
	_config = call BL_fnc_missionsConfig;

	if ( !isNil "BL_PVAR_currentTasks" ) then {
		// End all missions first
		[BL_PVAR_currentTasks, {
			[_value select 0 select 0] call BL_fnc_deleteTask;
		}] call CBA_fnc_hashEachPair;
		
		{
			_x setDamage 1;
			deleteVehicle _x;
			nil
		} count (allUnits - playableUnits);
	}
	else {
		// Wait configured amount of time before first mission
		sleep ([_config, 'roundStartDelay'] call CBA_fnc_hashGet);
	};	
	
	// Spawn initial missions
	for "_i" from 1 to ([_config, 'count'] call CBA_fnc_hashGet) do {
		[] call BL_fnc_spawnMission;
		sleep 30;
	};
	
	// Spawn new mission after a mission completes
	['missionDone', {
		_this spawn {
			_config = call BL_fnc_missionsConfig;
			sleep ([_config, 'delay'] call CBA_fnc_hashGet);
		
			// Spawn new mission
			[] call BL_fnc_spawnMission;
		};
	}] call CBA_fnc_addEventHandler;
};