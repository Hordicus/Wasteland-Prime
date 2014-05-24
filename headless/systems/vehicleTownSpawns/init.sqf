BL_townVehiclesToRespawn = [];

[] spawn {
	private ["_cities","_config","_vehicles","_classes","_lowestChance","_maxPerCity","_minPerCity","_vehiclesPerMeter","_cargoGroups","_cityCenter","_cityRadius","_vehiclesInTown","_currentCount","_searchDistance","_maxCount","_class","_veh","_distance","_direction","_nearCars","_cargoAdded","_cargo","_originalCargo"];

	_cities = call BL_fnc_findCities;
	_config = [] call BL_fnc_vehicleTownSpawnsConfig;
	_vehicles = [_config, "vehicles"] call CBA_fnc_hashGet;
	_classes = [];
	_lowestChance = 1;
	_maxPerCity = [_config, "maxPerCity"] call CBA_fnc_hashGet;
	_minPerCity = [_config, "minPerCity"] call CBA_fnc_hashGet;
	_vehiclesPerMeter = [_config, "vehiclesPerMeter"] call CBA_fnc_hashGet;
	_cargoGroups = [_config, "vehicleCargo"] call CBA_fnc_hashGet;

	{
		_classes set [count _classes, _x select 0];
		if ( _x select 1 < _lowestChance ) then {
			_lowestChance = _x select 1;
		};
	} forEach _vehicles;

	waitUntil { !isNil "PERS_init_done" };
	while { true } do {
		{
			_cityCenter = _x select 1;
			_cityRadius = _x select 2;
			_vehiclesInTown = _cityCenter nearEntities [_classes, _cityRadius];
			_currentCount = count _vehiclesInTown;
			_searchDistance = 5;
			
			_maxCount = (round ((PI * _cityRadius^2) / _vehiclesPerMeter)) min _maxPerCity max _minPerCity;
			
			// Bring vehicle count up to max count
			for "_i" from 1 to ( _maxCount - _currentCount ) do {
				_pos = [];
				_class = "";
				_veh = objNull;
				
				if ( count BL_townVehiclesToRespawn > 0 ) then {
					_veh = BL_townVehiclesToRespawn select 0;
					BL_townVehiclesToRespawn = BL_townVehiclesToRespawn - [_veh];
					_class = typeOf _veh;
				}
				else {
					_class = ([_vehicles, 1, _lowestChance] call BL_fnc_selectRandom) select 0;
				};
				
				// Keep trying until we find a good spot.
				// Good spot = emptyPosition and no car within 20m
				while { count _pos == 0 } do {
					_distance = random _cityRadius - _searchDistance;
					_direction = random 360;
					
					_pos = [_cityCenter, _distance, _direction] call BIS_fnc_relPos;
					_nearCars = _pos nearEntities ["Car", 20];
					
					if ( count _nearCars == 0 ) then {
						_pos = _pos findEmptyPosition [0, _searchDistance, _class];
					}
					else {
						_pos = [];
					};
				};

			
				if ( !isNull _veh ) then {
					[_veh, _pos] call BL_fnc_safeVehicleSetPos;
					
					if ( local _veh ) then {
						_veh setFuel 1;
						_veh engineOn false;
					};
				}
				else {
					_veh = [_class, _pos] call BL_fnc_safeVehicleSpawn;
					_cargoAdded = [_veh, _cargoGroups] call BL_fnc_addVehicleCargo;
					_veh setVariable ['originalCargo', _cargoAdded];
					// [[_veh, 'townVeh'] call BL_fnc_trackVehicle] call BL_fnc_saveVehicle;
				};
			};
			
			// Check cargo of existing vehicles
			{
				_cargo = ([getWeaponCargo _x]) + ([getMagazineCargo _x]) + ([getItemCargo _x]);
				_originalCargo = _x getVariable ['originalCargo', []];
				if ( !(_cargo isEqualTo _originalCargo) ) then {
					_cargoAdded = [_x, _cargoGroups] call BL_fnc_addVehicleCargo;
					_x setVariable ['originalCargo', _cargoAdded];
				};
				true
			} count _vehiclesInTown;
			true
		} count _cities;

		sleep (60 * 5);
	};
};