[] spawn {
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
			if ( count crew _x == 0 && { count ([_vehPos, _detectionRange] call BL_fnc_nearUnits) == 0 } ) then {
				// Is it in a town?
				_nearestCity = [_vehPos] call BL_fnc_nearestCity;
				if ( (_nearestCity select 1) distance _vehPos <= (_nearestCity select 2) ) then {
					// Vehicle is in town
					if ( !canMove _x || fuel _x < 0.1 ) then {
						deleteVehicle _x;
					};
				}
				else {
					// Not in town... probably (hopefully) abandoned
					deleteVehicle _x;
				};
			};			
		} forEach ((getPosATL mapCenter) nearEntities [_townCarClasses, 100000]);
		
		// Remove rare cars.
		// Conditions:
		// 	(They are immobile (missing tires, out of fuel)
		//  OR haven't been used in 30min)
		//	AND no one within _detectionRange
		{
			_vehPos = getPosATL _x;
			_lastUsed = _x getVariable ['GC_lastUsed', time];
			_vehTracked = _x getVariable ['GC_tracked', false];
			
			if ( !_vehTracked ) then {
				_x addEventHandler ['GetOut', {
					(_this select 0) setVariable ['GC_lastUsed', time];
				}];
				
				_x setVariable ['GC_tracked', true];
			};
			
			if ( (_vehPos distance (_x getVariable 'originalSpawnPoint')) > 10 ) then {
				if (count crew _x == 0 && {time - _lastUsed >= (30 * 60)} && { count ([_vehPos, _detectionRange] call BL_fnc_nearUnits) == 0 }) then {
					deleteVehicle _x;
				};
			};			
		} forEach ((getPosATL mapCenter) nearEntities [_rareCarClasses, 100000]);
		
		sleep 5;
	};
};