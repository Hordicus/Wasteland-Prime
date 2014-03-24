[] spawn {
	private ["_cities","_config","_vehicles","_classes","_lowestChance","_maxPerCity","_vehiclesPerMeter","_cargoGroups","_cityCenter","_cityRadius","_sqMeters","_playersInTown","_vehiclesInTown","_currentCount","_maxCount","_searchDistance","_chance","_possible","_class","_distance","_direction","_nearCars","_veh","_cargoAdded","_cargo","_originalCargo"];
	_cities = call BL_fnc_findCities;
	_config = [] call BL_fnc_vehicleTownSpawns_config;
	_vehicles = [_config, "vehicles"] call CBA_fnc_hashGet;
	_classes = [];
	_lowestChance = 1;
	_maxPerCity = [_config, "maxPerCity"] call CBA_fnc_hashGet;
	_vehiclesPerMeter = [_config, "vehiclesPerMeter"] call CBA_fnc_hashGet;
	_cargoGroups = [_config, "vehicleCargo"] call CBA_fnc_hashGet;

	{
		_classes set [count _classes, _x select 0];
		if ( _x select 1 < _lowestChance ) then {
			_lowestChance = _x select 1;
		};
	} forEach _vehicles;

	while { true } do {
		{
			_cityCenter = _x select 1;
			_cityRadius = _x select 2;
			_sqMeters   = (PI * _cityRadius^2);
			_playersInTown = [_cityCenter, _cityRadius*2] call BL_fnc_nearUnits;
			
			if ( count _playersInTown == 0 ) then {
				_vehiclesInTown = _cityCenter nearEntities [_classes, _cityRadius*2];
				_currentCount = count _vehiclesInTown;
				_maxCount = round (_sqMeters / _vehiclesPerMeter);
				_searchDistance = 5;
				
				if ( _maxCount > _maxPerCity ) then {
					_maxCount = _maxPerCity;
				};
				
				// Bring vehicle count up to max count
				for "_i" from 1 to ( _maxCount - _currentCount ) do {
					_pos = [];
					
					// Random chance
					_chance = random 1 + _lowestChance;
					_possible = [];
					
					{
						if ( 1-(_x select 1) <= _chance ) then {
							_possible set [count _possible, _x];
						};
					} count _vehicles;
					
					// Now get a random vehicle that has a chance to spawn.
					_class = _possible select (floor random count _possible) select 0;
					
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
					
					_veh = [_class, _pos] call BL_fnc_safeVehicleSpawn;
					_cargoAdded = [_veh, _cargoGroups] call BL_fnc_addVehicleCargo;
					_veh setVariable ['originalCargo', _cargoAdded];
				};
				
				// Check cargo of existing vehicles
				{
					_cargo = ([getWeaponCargo _x]) + ([getMagazineCargo _x]) + ([getItemCargo _x]);
					_originalCargo = _x getVariable ['originalCargo', []];
					if ( str _cargo != str _originalCargo ) then { // 29.89 times faster than BIS_fnc_arrayCompare
						_cargoAdded = [_x, _cargoGroups] call BL_fnc_addVehicleCargo;
						_x setVariable ['originalCargo', _cargoAdded];
					};
				} forEach _vehiclesInTown;
			};	
		} forEach _cities;

		sleep 60;
	};
};