[
// Init. Result of this will be passed to all
// following functions as _this select 0.
{
	private ['_cities', '_city', '_spawnSpot', '_leadVehicle', '_vehicles', '_variations'];
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
	_group = createGroup east;
	_vehicles = [];
	
	_variations = [
		'repair',
		'ammo',
		'pmc',
		'bobcat'
	];
	
	(_variations select floor random count _variations) call {
		if ( _this == "repair" || _this == "ammo" ) exitwith {
			/*
			==================================
			Ammo and Repair truck convoys
			==================================
			*/
			private ['_vehClass', '_rewardClass'];
			_vehClass = {
				private ['_types'];
				_types = ["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"];
				(_types select floor random count _types)
			};
			
			_vehicles set [count _vehicles, [_group, call _vehClass, _spawnSpot] call BL_fnc_spawnMissionVehWithCrew];
					
			_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
			_vehicles set [count _vehicles, [_group, call _vehClass, _spawnSpot] call BL_fnc_spawnMissionVehWithCrew];
			
			_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
			_vehicles set [count _vehicles, [_group, "O_Truck_02_transport_F", _spawnSpot, [
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_F"
			]] call BL_fnc_spawnMissionVehWithCrew];

			_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
			_rewardClass = if ( _this == "repair" ) then {"O_Truck_03_repair_F"} else {"O_Truck_03_ammo_F"};
			_vehicles set [count _vehicles, [_group, _rewardClass, _spawnSpot] call BL_fnc_spawnMissionVehWithCrew];
			
			_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
			_vehicles set [count _vehicles, [_group, call _vehClass, _spawnSpot] call BL_fnc_spawnMissionVehWithCrew];
		};
	
		if ( _this == "pmc" ) exitwith {
			_vehicles set [count _vehicles, [_group, "B_G_Offroad_01_armed_F", _spawnSpot, [
				"O_G_officer_F",
				"O_G_Soldier_AR_F",
				"O_G_Soldier_exp_F"
			]] call BL_fnc_spawnMissionVehWithCrew];

			_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
			_vehicles set [count _vehicles, [_group, "C_SUV_01_F", _spawnSpot, [
				"O_G_medic_F",
				"O_G_Soldier_GL_F",
				"O_G_Soldier_exp_F",
				"O_G_engineer_F"
			]] call BL_fnc_spawnMissionVehWithCrew];
			
			_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
			_vehicles set [count _vehicles, [_group, "C_SUV_01_F", _spawnSpot, [
				"O_G_medic_F",
				"O_G_Soldier_GL_F",
				"O_G_Soldier_exp_F",
				"O_G_engineer_F"
			]] call BL_fnc_spawnMissionVehWithCrew];
			
			_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
			_vehicles set [count _vehicles, [_group, "B_G_Offroad_01_armed_F", _spawnSpot, [
				"O_G_officer_F",
				"O_G_Soldier_AR_F",
				"O_G_Soldier_exp_F"
			]] call BL_fnc_spawnMissionVehWithCrew];
			
			// Have AI drop money when killed
			{
				_x addEventHandler ["Killed", {
					private ['_loc'];
					_loc = getPosATL (_this select 0);
					_killer = _this select 1;
					
					if ( isPlayer _killer ) then {
						_killer setVariable ['money', (_killer getVariable ['money', 0]) + 1000, true];
						[format['$%1 bounty awarded', 1000], "BL_fnc_systemChat", owner _killer] spawn BIS_fnc_MP;
					}
					else {
						// Unknown killer, drop on ground
						_money = createVehicle [('moneyModel' call BL_fnc_config), _loc, [], 0, "CAN_COLLIDE"];
						[_money] call BL_fnc_trackVehicle;
						_money setVariable ['moneyAmount', 1000, true];
					};
				}];
				true
			} count (units _group);
			
		};
		
		if ( _this == 'bobcat' ) exitwith {
			_vehicles set [count _vehicles, [_group, "O_APC_Tracked_02_cannon_F", _spawnSpot] call BL_fnc_spawnMissionVehWithCrew];

			_spawnSpot = [_spawnSpot, -10, 0] call BIS_fnc_relPos;
			_vehicles set [count _vehicles, [_group, "B_APC_Tracked_01_CRV_F", _spawnSpot, [
				"O_Soldier_F"
			]] call BL_fnc_spawnMissionVehWithCrew];
		};
	};
	
	[_group] call BL_fnc_statTrackAIUnits;
	
	_vehicles
},

'Convoy',
{format['
A convoy was seen moving from %1.
Destroy or capture all marked vehicles to complete this mission.
Salvage what you can.', ([getPosATL (_this select 0 select 0)] call BL_fnc_nearestCity) select 0]
},

// Mission location.
{[objNull, true]},

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
			
			if !( [_task select 0] call BL_fnc_taskCompleted ) then {
				if ( !alive _x || ({ alive _x } count (crew _x)) == 0  ) then {
					[_task select 0, 'SUCCEEDED'] call BL_fnc_taskSetState;
					(_task select 0) spawn {
						sleep 15;
						[_this] call BL_fnc_deleteTask;
					};
				};
			};
		} forEach _vehicles;
		
		_children = [_missionCode] call BL_fnc_taskChildren;
		if ( ({ [_x] call BL_fnc_taskCompleted || !([_x] call BL_fnc_taskExists)} count _children) == count _children ) then {
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
		] call BL_fnc_taskCreate;
		
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

	while { !([_missionCode] call BL_fnc_taskCompleted) && [_missionCode] call BL_fnc_taskExists } do {
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