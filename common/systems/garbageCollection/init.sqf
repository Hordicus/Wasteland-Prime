if !( 'vehicleSpawns' call BL_fnc_shouldRun ) exitwith{};

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
			if ( count crew _x == 0 && count ([_vehPos, _detectionRange] call BL_fnc_nearUnits) == 0 && !([_x] call BL_fnc_isInBase)) then {
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
					if !( _x in BL_townVehiclesToRespawn ) then {
						BL_townVehiclesToRespawn set [count BL_townVehiclesToRespawn, _x];
					};
				};
			};
			true
		} count ((getPosATL mapCenter) nearEntities [_townCarClasses, 100000]);
		
		// Remove rare cars.
		// Conditions:
		//  Haven't been used in 30min
		//	AND no one within _detectionRange
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
				if (count crew _x == 0 && {time - _lastUsed >= (30 * 60)} && { count ([_vehPos, _detectionRange] call BL_fnc_nearUnits) == 0 } && !([_x] call BL_fnc_isInBase)) then {
					[_x] call BL_fnc_deleteVehicleDB;
					deleteVehicle _x;
				};
			};
			
			true
		} count ((getPosATL mapCenter) nearEntities [_rareCarClasses, 100000]);
		
		// Remove dead things
		{
			if ( _x isKindOf "LandVehicle" || _x isKindOf "Air" ) then {
				if ( _x getVariable ['PERS_type', 'veh'] == 'static' ) then {
					[_x] call BL_fnc_staticVehKilled;
				};					

				[_x] call BL_fnc_deleteVehicleDB;
				deleteVehicle _x;
			};

			if ( _x isKindOf "Man" ) then {
				_x enableSimulation false;
				
				if ( count ([getPosATL _x, 600] call BL_fnc_nearUnits) == 0 ) then {
					deleteVehicle _x;
				}
				else {
					if ( isNil {_x getVariable 'despawnScript'} ) then {
						_x setVariable ['despawnScript', _x spawn {
							sleep (60 * 2);
							deleteVehicle _this;
						}];
					};
				};
			};
			true
		} count allDead;
		
		// Clean up dropped weapons
		{
			if ( count ([getPosATL _x, 600] call BL_fnc_nearUnits) == 0 ) then {
				deleteVehicle _x;
			}
			else {
				if ( isNil {_x getVariable 'despawnScript'} ) then {
					_x setVariable ['despawnScript', _x spawn {
						sleep (60 * 2);
						deleteVehicle _this;
					}];
				};
			};
			
			true
		} count entities "WeaponHolderSimulated";
		
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
