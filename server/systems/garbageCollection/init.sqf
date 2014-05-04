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
		{
			_vehPos = getPosATL _x;
			// Anyone around?
			if ( count crew _x == 0 && { count ([_vehPos, _detectionRange] call BL_fnc_nearUnits) == 0 } && {count (_x getVariable ['LOG_contents', []]) == 0} && !([_x] call BL_fnc_isInBase)) then {
				// Is it in a town?
				_nearestCity = [_vehPos] call BL_fnc_nearestCity;
				if ( (_nearestCity select 1) distance _vehPos <= (_nearestCity select 2) ) then {
					// Vehicle is in town
					if ( !canMove _x || fuel _x < 0.1 ) then {
						deleteVehicle _x;
						[_x] call BL_fnc_deleteVehicleDB;
					};
				}
				else {
					// Not in town... probably (hopefully) abandoned
					deleteVehicle _x;
					[_x] call BL_fnc_deleteVehicleDB;
				};
			};			
		} forEach ((getPosATL mapCenter) nearEntities [_townCarClasses, 100000]);
		
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
				if (count crew _x == 0 && {time - _lastUsed >= (30 * 60)} && { count ([_vehPos, _detectionRange] call BL_fnc_nearUnits) == 0 } && {count (_x getVariable ['LOG_contents', []]) == 0} && !([_x] call BL_fnc_isInBase)) then {
					deleteVehicle _x;
					[_x] call BL_fnc_deleteVehicleDB;
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

				deleteVehicle _x;
				[_x] call BL_fnc_deleteVehicleDB;
			};

			if ( _x isKindOf "Man" ) then {
				if ( primaryWeapon _x == "" && secondaryWeapon _x == "" && {count ([getPosATL _x, _detectionRange] call BL_fnc_nearUnits) == 0} ) then {
					// No one in the area and nothing to come back for, delete
					deleteVehicle _x;
				}
				else {
					if ( primaryWeapon _x == "" && secondaryWeapon _x == "" ) then {
						// Nothing to loot, but players in the area. Hide body in one minute.
						_x spawn {
							sleep 60;
							hideBody _this;
							sleep 1;
							deleteVehicle _this;
						};
					}
					else {
						// Still guns on the body, hide in 5 min.
						_x spawn {
							sleep (60 * 5);
							hideBody _this;
							sleep 1;
							deleteVehicle _this;
						};
					};
				};
			};
			true
		} count allDead;
		
		sleep 60;
	};
};

[] spawn {
	waitUntil { !isNil "PERS_init_done" };
	while { true } do {
		sleep (60 * 5);
		
		{
			deleteVehicle _x;
		} count ((allMissionObjects "CraterLong"));
	};
};
