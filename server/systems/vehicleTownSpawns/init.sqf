#include "\x\bl_server\addons\performance.sqf"
['townVeh', [
	// Save
	{},
	
	// Load
	{
		private ['_veh'];
		_veh = _this select 0;
		
		_veh setVariable ['originalCargo', [
			getWeaponCargo _veh,
			getMagazineCargo _veh,
			getItemCargo _veh
		]];
	}
]] call BL_fnc_persRegisterTypeHandler;

BL_townVehiclesToRespawn = [];

[] spawn {
	private ["_cities","_config","_vehicles","_classes","_lowestChance","_maxPerCity","_vehiclesPerMeter","_cargoGroups","_cityCenter","_cityRadius","_sqMeters","_playersInTown","_vehiclesInTown","_currentCount","_maxCount","_searchDistance","_chance","_possible","_class","_distance","_direction","_nearCars","_veh","_cargoAdded","_cargo","_originalCargo"];
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
		PERF_START("vehicleTownSpawns");
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
				
				
				_maxCount = _maxCount min _maxPerCity max _minPerCity;
				
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
						[[_veh, 'townVeh'] call BL_fnc_trackVehicle] call BL_fnc_saveVehicle;
					};
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
		// } forEach [(_cities select 0)];
		} forEach _cities;
		PERF_STOP("vehicleTownSpawns", true);

		sleep (60 * 5);
	};
};