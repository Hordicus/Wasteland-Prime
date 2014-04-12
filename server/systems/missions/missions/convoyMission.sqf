[
// Init. Result of this will be passed to all
// following functions as _this select 0.
{
	private ['_cities', '_city', '_spawnSpot', '_leadVehicle'];
	// Select a random city
	_cities = [] call BL_fnc_findCities;
	_city = [];
	
	while { count _city == 0 } do {
		_city = _cities select floor random count _cities;
		
		if ( count ([_city select 1, 1000] call BL_fnc_nearUnits) > 0 || count ([_city select 1, 1000] call BL_fnc_nearMissions) > 0) then {
			_city = [];
		};
	};
	
	_spawnSpot = (selectBestPlaces [_city select 1, 500, "meadow - houses", 1, 1]) select 0 select 0;
	
	_leadVehicle = createVehicle ["O_MRAP_02_hmg_F", _spawnSpot, [], 0, "CAN_COLLIDE"];
	createVehicleCrew _leadVehicle;
	[_leadVehicle, 'reward'] call BL_fnc_trackVehicle;
	
	_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
	
	_vehTwo = createVehicle ["O_MRAP_02_hmg_F", _spawnSpot, [], 0, "CAN_COLLIDE"];
	[_vehTwo, 'reward'] call BL_fnc_trackVehicle;
	createVehicleCrew _vehTwo;
	(crew _vehTwo) join (group _leadVehicle);

	_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
	
	_transport = createVehicle ["O_Truck_02_transport_F", _spawnSpot, [], 0, "CAN_COLLIDE"];
	[_transport, 'reward'] call BL_fnc_trackVehicle;
	createVehicleCrew _transport;
	(crew _transport) join (group _leadVehicle);
	
	((group _leadVehicle) createUnit ["O_Soldier_F", _spawnSpot, [], 0, "FORM"]) moveInCargo _transport;
	((group _leadVehicle) createUnit ["O_Soldier_F", _spawnSpot, [], 0, "FORM"]) moveInCargo _transport;
	((group _leadVehicle) createUnit ["O_Soldier_F", _spawnSpot, [], 0, "FORM"]) moveInCargo _transport;
	((group _leadVehicle) createUnit ["O_Soldier_F", _spawnSpot, [], 0, "FORM"]) moveInCargo _transport;
	((group _leadVehicle) createUnit ["O_Soldier_F", _spawnSpot, [], 0, "FORM"]) moveInCargo _transport;
	((group _leadVehicle) createUnit ["O_Soldier_F", _spawnSpot, [], 0, "FORM"]) moveInCargo _transport;
	((group _leadVehicle) createUnit ["O_Soldier_F", _spawnSpot, [], 0, "FORM"]) moveInCargo _transport;
	
	_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
	_repair = createVehicle ["O_Truck_03_repair_F", _spawnSpot, [], 0, "CAN_COLLIDE"];
	[_repair, 'reward'] call BL_fnc_trackVehicle;
	createVehicleCrew _repair;
	(crew _repair) join (group _leadVehicle);
	
	_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
	_vehThree = createVehicle ["O_MRAP_02_hmg_F", _spawnSpot, [], 0, "CAN_COLLIDE"];
	[_vehThree, 'reward'] call BL_fnc_trackVehicle;
	createVehicleCrew _vehThree;
	(crew _vehThree) join (group _leadVehicle);
	
	[_leadVehicle, _vehTwo, _transport, _repair, _vehThree]
},

'Troop Convoy',
'
A convoy was seen moving from this location.
Destroy or capture all marked vehicles to complete this mission.
Salvage what you can.
',

// Mission location.
{getPosATL (_this select 0 select 0)},

// Function to call to run the mission
{
	private ["_leadVehicle","_vehGroup","_cities","_currentCity","_lastCity","_nextCity","_possibleCities","_nextWaypoint","_wp"];
	_vehicles    = _this select 0;
	_leadVehicle = _this select 0 select 0;
	_missionCode = _this select 1;
	_vehGroup = group _leadVehicle;
	_cities = [] call BL_fnc_findCities;
	_visitedCities = [];
	
	_vehGroup setBehaviour 'AWARE';
	_vehGroup setFormation 'COLUMN';
	_vehGroup setCombatMode 'WHITE';
	_vehGroup allowFleeing 0;
	
	_checkCompletion = {
		private ['_task', '_vehicles', '_children', '_missionCode'];
		_missionCode = (_this select 0) getVariable 'missionCode';
		_vehicles = (_this select 0) getVariable 'vehicles';
		{
			_task = _x getVariable 'subTaskCode';
			
			if !( [_task select 0] call BIS_fnc_taskCompleted ) then {
				if ( !alive _x || ({ alive _x } count (crew _x)) == 0  ) then {
					[_task select 0, 'SUCCEEDED'] call BIS_fnc_taskSetState;
					(_task select 0) spawn {
						sleep 15;
						[_this] call BIS_fnc_deleteTask;
					};
				};
			};
		} forEach _vehicles;
		
		_children = [_missionCode] call BIS_fnc_taskChildren;
		if ( ({ [_x] call BIS_fnc_taskCompleted || !([_x] call BIS_fnc_taskExists)} count _children) == count _children ) then {
			[_missionCode, true] call BL_fnc_missionDone;
		};
	};
	
	// Add sub tasks for all vehicles
	{
		_displayName = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
		_subTaskCode = [format['%1Veh%2', _missionCode, _forEachIndex], _missionCode];
		[
			true,
			_subTaskCode,
			["", _displayName, _displayName],
			[_x, true],
			'CREATED',
			_forEachIndex,
			false
		] call BIS_fnc_taskCreate;
		
		_x setVariable ['subTaskCode', _subTaskCode];
		_x setVariable ['missionCode', _missionCode];
		_x addEventHandler ['Killed', _checkCompletion];
		_x addEventHandler ['GetOut', _checkCompletion];
		_x setVariable ['vehicles', _vehicles];
		_x setVariable ['rewardGetInEH', _x addEventHandler ['GetIn', {
			if ( isPlayer (_this select 2) ) then {
				[_this select 0] call BL_fnc_saveVehicle;
				(_this select 0) removeEventHandler ['GetIn', (_this select 0) getVariable 'rewardGetInEH'];
			};
		}]];
		
		_x addEventHandler ['HandleDamage', {
			if ( isNull (_this select 3) && (_this select 4) == "") then {
				0
			};
		}];
	} forEach (_this select 0);
	
	// Killed event for units in case they are shot out of vehicles.
	{
		_x setVariable ['missionCode', _missionCode];
		_x addEventHandler ['Killed', _checkCompletion];
		_x setVariable ['vehicles', _vehicles];
	} count ( units _vehGroup );
	
	// Find the next closest valid city.
	_nextCity = {
		private ['_possibleCities'];
		_possibleCities = [_cities, [], {
			if !( (_x select 0) in _visitedCities ) then {
				(_nextWaypoint select 1) distance (_x select 1)
			}
			else {
				100000
			};
		}, "ASCEND"] call BIS_fnc_sortBy;
		
		_possibleCities select 0
	};
	
	_startCity = ([getPosATL _leadVehicle] call BL_fnc_nearestCity);
	_nextWaypoint = _startCity;

	while { !([_missionCode] call BIS_fnc_taskCompleted) && [_missionCode] call BIS_fnc_taskExists } do {
		if ( currentWaypoint _vehGroup >= count waypoints _vehGroup ) then {
			_visitedCities set [count _visitedCities, _nextWaypoint select 0];
			_nextWaypoint = (call _nextCity);

			_wp = _vehGroup addWaypoint [_nextWaypoint select 1, 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointCompletionRadius 100;
			_vehGroup setCurrentWaypoint _wp;
		};
		
		sleep 60;
	};
	
	// Mission is over. Track and remove AI ASAP.
	_vehGroup allowFleeing 1;
	_vehGroup spawn {
		while { count units _this > 0 } do {
			sleep 60;
		
			{
				// No one within 200m and no one within 1000m with LOS.
				if !( count ([getPosATL _x, 200] call BL_fnc_nearUnits) == 0 && !([[getPosATL _x, 1000] call BL_fnc_nearUnits, _x] call BL_fnc_hasLOS) ) then {
					deleteVehicle _x;
				};
				true
			} count (units _this);
		};
	};
}];