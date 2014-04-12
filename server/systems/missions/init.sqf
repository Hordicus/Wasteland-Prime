missionCount = 0;
runningMissionLocations = [] call CBA_fnc_hashCreate;

[] spawn {
	_config = call BL_fnc_missionsConfig;
	
	// Wait configured amount of time before first mission
	sleep ([_config, 'roundStartDelay'] call CBA_fnc_hashGet);
	
	// Spawn initial missions
	for "_i" from 1 to ([_config, 'count'] call CBA_fnc_hashGet) do {
		[] call BL_fnc_spawnMission;
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
	
	// Clean up tasks
	['missionDone', {
		_this spawn {
			_config = call BL_fnc_missionsConfig;
			sleep ([_config, 'taskCleanupDelay'] call CBA_fnc_hashGet);
			[_this] call BL_fnc_deleteTask;

			[runningMissionLocations, _this] call CBA_fnc_hashRem;
		};
	}] call CBA_fnc_addEventHandler;
};