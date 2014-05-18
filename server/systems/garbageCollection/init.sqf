#include "\x\bl_server\addons\performance.sqf"
[] spawn {
	waitUntil { !isNil "PERS_init_done" };
	sleep (60 * 5);
	
	_townCars = [] call BL_fnc_vehicleTownSpawnsConfig;
	_rareCars = [] call BL_fnc_rareVehiclesConfig;
	
	_townCarClasses = [];
	_rareCarClasses = [];
	
	{
		_townCarClasses set [_forEachIndex, _x select 0];
	} forEach ([_townCars, 'vehicles'] call CBA_fnc_hashGet);
	
	{
		_rareCarClasses set [_forEachIndex, _x select 0];
	} forEach ((([_rareCars, 'ground'] call CBA_fnc_hashGet) select 1) + (([_rareCars, 'air'] call CBA_fnc_hashGet) select 1));
	
	_detectionRange = 500;
	while { true } do {
		PERF_START("GC");
		PERF_START("GC_townCars");
		// Clean up town cars.
		// Find cars that are in towns
		_carsInTowns = [];
		{
			_carsInTowns = _carsInTowns + ((_x select 1) nearEntities [_townCarClasses, _x select 2]);
			nil
		} count ([] call BL_fnc_findCities);

		{
			_vehPos = getPosATL _x;
			// Anyone around?
			if ( count crew _x == 0 && count ([_vehPos, _detectionRange] call BL_fnc_nearUnits) == 0 && count (_x getVariable ['LOG_contents', []]) == 0 ) then {
				if ( _x in _carsInTowns ) then {
					if ( !canMove _x || fuel _x < 0.1 ) then {
						// Vehicle is in town
						if ( !canMove _x || fuel _x < 0.1 ) then {
							_x setDamage 0;
							
							if ( local _x ) then {
								_x setFuel 1;
								_x engineOn false;
							};
						};
					};
				}
				else {
					// Not in town... probably (hopefully) abandoned
					BL_townVehiclesToRespawn set [count BL_townVehiclesToRespawn, _x];
				};
			};
			true
		} count ((getPosATL mapCenter) nearEntities [_townCarClasses, 100000]);
		PERF_STOP("GC_townCars", true);
		
		// Remove rare cars.
		// Conditions:
		//  Haven't been used in 30min
		//	AND no one within _detectionRange
		PERF_START("GC_rareCars");
		{
			_vehPos = getPosATL _x;
			_lastUsed = _x getVariable ['GC_lastUsed', time];
			_vehTracked = _x getVariable ['GC_tracked', false];
			
			if ( !_vehTracked ) then {
				_x addEventHandler ['GetOut', {
					(_this select 0) setVariable ['GC_lastUsed', time];
				}];
				
				_x setVariable ['GC_lastUsed', time];
				_x setVariable ['GC_tracked', true];
			};

			// Make sure it didn't get converted to string
			_originalSpawn = _x getVariable ['originalSpawnPoint', getPosATL _x];
			{
				if ( typeName _x == "STRING" ) then {
					_originalSpawn set [_forEachIndex, parseNumber _x];
				};
			} forEach _originalSpawn;
			
			if ( (_vehPos distance _originalSpawn) > 10 ) then {
				if (count crew _x == 0 && {time - _lastUsed >= (30 * 60)} && { count ([_vehPos, _detectionRange] call BL_fnc_nearUnits) == 0 } && {count (_x getVariable ['LOG_contents', []]) == 0} && !([_x] call BL_fnc_isInBase)) then {
					deleteVehicle _x;
					[_x] call BL_fnc_deleteVehicleDB;
				};
			};
			
			true
		} count ((getPosATL mapCenter) nearEntities [_rareCarClasses, 100000]);
		PERF_STOP("GC_rareCars", true);
		
		// Remove dead things
		PERF_START("GC_dead");
		{
			if ( _x isKindOf "LandVehicle" || _x isKindOf "Air" ) then {
				if ( _x getVariable ['PERS_type', 'veh'] == 'static' ) then {
					[_x] call BL_fnc_staticVehKilled;
				};					

				deleteVehicle _x;
				[_x] call BL_fnc_deleteVehicleDB;
			};

			if ( _x isKindOf "Man" && isNil {_x getVariable 'despawnScript'}) then {
				_x setVariable ['despawnScript', _x spawn {
					sleep (60 * 5);
					hideBody _this;
					sleep 5;
					deleteVehicle _this;
				}];
			};
			true
		} count allDead;
		PERF_STOP("GC_dead", true);
		
		PERF_STOP("GC", true);
		sleep 60;
	};
};

[] spawn {
	waitUntil { !isNil "PERS_init_done" };
	while { true } do {
		sleep (60 * 5);
		
		{
			deleteVehicle _x;
		} count ((allMissionObjects "CraterLong") + (allMissionObjects "Ruins"));
		
		{
			if ( count units _x == 0 ) then {
				deleteGroup _x;
			};
			true
		} count allGroups;		
	};
};
