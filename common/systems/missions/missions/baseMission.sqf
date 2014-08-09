[
// Init. Result of this will be passed to all
// following functions as _this select 0.
{
	[[], _this select 1] call (_this select 0);
},

"Base Mission",
{"Mission"},

// Mission location. Array or code
{
	_location = [];
	while { _location isEqualTo [] } do {
		_location = (call BL_fnc_missionRandomField) isFlatEmpty [15, 0, 1, 15, 0, false, objNull];
	};
	
	ASLtoATL _location
},

// Function to call to start the mission
{
	_initResult  = [_this, 0, "", [""]] call BIS_fnc_param;
	_missionCode = [_this, 1, "", [""]] call BIS_fnc_param;
	_location    = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	_location set [2, 0];
	
	_transport   = createGroup east;
	_building    = createGroup east;
	
	_conditions  = [
		false, // Base done
		false // Units landed
	];
	
	/* Attack heli loop */
	[_location, _missionCode] spawn {
		_location = _this select 0;
		_missionCode = _this select 1;
		
		_attackGroup = createGroup east;
		_attackGroup allowFleeing 0;
				
		while { !([_missionCode] call BL_fnc_taskCompleted) && [_missionCode] call BL_fnc_taskExists } do {
			_spawnPos = [_location, 3000 + random 2000, random 359] call BIS_fnc_relPos;
			
			while {{alive _x && _x != vehicle _x} count (units _attackGroup) < 2 } do {
				_veh = createVehicle ["B_Heli_Light_01_armed_F", _spawnPos, [], 100, "FLY"];
				_unit = _attackGroup createUnit ["O_Pilot_F", _spawnPos, [], 0, "FORM"];
				
				_unit moveInDriver _veh;
				_unit call BL_fnc_statTrackAIUnits;
				[_veh, 'reward'] call BL_fnc_trackVehicle;
			};
			
			if ( (currentWaypoint _attackGroup) > (count (waypoints _attackGroup)-1) ) then {
				{deleteWaypoint [_attackGroup, _forEachIndex]} forEach (waypoints _attackGroup);
				
				_wp = _attackGroup addWaypoint [_location, 0];
				_wp setWaypointBehaviour "COMBAT";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointType "SAD";
				
				_attackGroup setCurrentWaypoint [_attackGroup, 0];
			};
			
			sleep 30;
		};
	};
	
	/* Unit reinforcement loop */
	[_location, _missionCode, _building, _conditions] spawn {
		_location    = _this select 0;
		_missionCode = _this select 1;
		_building    = _this select 2;
		_conditions  = _this select 3;
		
		_unitTypes = [
			"O_Soldier_F",
			"O_sniper_F",
			"O_recon_F",
			"O_support_Mort_F",
			"O_Soldier_AA_F",
			"O_Soldier_AT_F",
			"O_Soldier_GL_F",
			"O_Soldier_LAT_F",
			"O_officer_F"
		];
		
		while { !([_missionCode] call BL_fnc_taskCompleted) && [_missionCode] call BL_fnc_taskExists } do {
			_neededUnits = 12 - ({alive _x} count units _building);
			_spawnPos = [_location, 3000 + random 2000, random 359] call BIS_fnc_relPos;

			// Transport needed units in groups of 6
			for "_i" from 1 to _neededUnits/6 do {
				_transport = createGroup east;
				_veh = createVehicle ["B_Heli_Light_01_F", _spawnPos, [], 100, "FLY"];
				_pilot = _transport createUnit ["O_Pilot_F", _spawnPos, [], 0, "FORM"];
				_pilot moveInDriver _veh;
				
				_pilot call BL_fnc_statTrackAIUnits;
				[_veh, 'reward'] call BL_fnc_trackVehicle;
				
				_group = createGroup east;
				while { {alive _x} count units _building < 14 && _veh emptyPositions "Cargo" > 0 } do {
					_unit = _building createUnit [
						_unitTypes select floor random count _unitTypes,
						[0,0,1000],
						[],
						0,
						"FORM"
					];
					
					_unit moveInCargo _veh;
					_unit assignAsCargo _veh;
					
					_unit call BL_fnc_statTrackAIUnits;
				};
				
				_group call BL_fnc_statTrackAIUnits;
				
				_transport setBehaviour "STEALTH";
				
				// Move to base location
				{deleteWaypoint [_transport, _forEachIndex]} forEach (waypoints _transport);
				_moveTo = _transport addWaypoint [_location, 0, 0];
				_moveTo setWaypointType "TR UNLOAD";				
				_transport setCurrentWaypoint [_transport, 0];
				
				[_veh, _transport, _location, _spawnPos, _conditions] spawn {
					_veh        = _this select 0;
					_transport  = _this select 1;
					_location   = _this select 2;
					_spawnPos   = _this select 3;
					_conditions = _this select 4;
					
					// Wait for heli to arrive
					waitUntil {sleep 1; _veh distance _location < 300 };
					
					// Unassign cargo. Will force heli to land.
					{
						if ( driver _veh != _x ) then {
							unassignVehicle _x;
						};
						
						nil
					} count (crew _veh);
					
					waitUntil { count crew _veh == 1 };
					_conditions set [1, true]; // Set condition to true. Used to tell when units have landed.
				
					// Move heli out of sight.
					_flyAway = _transport addWaypoint [_spawnPos, 0];
					_flyAway setWaypointType "MOVE";
					_transport setCurrentWaypoint _flyAway;
					
					// Clean up heli when it is out of sight.
					while { alive _veh } do {
						sleep 15;
						
						if ( count crew _veh == 1 ) then {
							if ( count ([getPosATL _veh, 500] call BL_fnc_nearUnits) == 0 ) then {
								{deleteVehicle _x} count ([_veh] + crew _veh);
							};
						};
					};
				};
			};
			
			sleep 60;
		};
	};
	
	/* Base building */
	[_location, _building, _conditions] spawn {
		_location   = _this select 0;
		_building   = _this select 1;
		_conditions = _this select 2;
	
		_baseParts = [["Land_BagFence_Round_F","13.310132","0.0799999","262.156464","265.567657"],["Land_BagFence_Round_F","13.765927","-0.0299301","92.484253","112.241272"],["Land_BagFence_Round_F","14.397835","0.0379925","101.633858","43.288235"],["Land_BagFence_Round_F","14.812669","0.0799999","269.77713","181.857269"],["B_static_AA_F","14.998459","0.00478935","263.611206","47.996418"],["B_static_AA_F","15.484487","0.074192","96.151436","260.949036"],["Land_CncWall4_F","15.878228","0.0799999","307.686768","129.627899"],["Land_CncWall4_F","16.506449","0.0799999","326.268555","129.644348"],["Land_CncBarrierMedium_F","16.582321","-0.442074","60.252609","39.820221"],["Land_CncBarrierMedium_F","16.717579","-0.520479","25.519642","39.856659"],["Land_CncWall4_F","16.992853","0.0799999","289.662689","129.977524"],["Land_CncWall4_F","17.243206","0.0188847","133.356873","310.771118"],["Land_CncBarrierMedium_F","17.321827","-0.522106","19.706434","220.713943"],["Land_CncBarrierMedium_F","17.326109","-0.451456","65.917786","39.856659"],["Land_CncWall4_F","17.582722","0.0799999","218.0251465","39.56118"],["Land_CncWall4_F","17.785265","0.00496292","116.240044","308.876251"],["Land_BarGate_F","18.0212803","0.0718327","41.845745","224.330124"],["Land_CncWall4_F","18.193279","0.0799999","234.686493","39.665592"],["Land_CncWall4_F","18.206913","0.00570107","150.0809326","310.211029"],["Land_CncWall4_F","18.546978","0.0799999","201.643982","40.226658"],["Land_BagBunker_Small_F","22.95796","0.0712528","27.91235","222.62883"],["Land_BagBunker_Small_F","23.0417633","0.0397549","56.292419","220.103104"],["Land_BagBunker_Large_F","23.0666237","0.0745296","340.555542","130.0645447"],["Land_BagBunker_Large_F","23.202923","0.0699997","10.135099","219.847565"],["B_HMG_01_high_F","23.347319","-0.0122623","28.89143","42.349098"],["Land_BagBunker_Large_F","23.576141","0.0794392","73.521263","219.820236"],["B_HMG_01_high_F","23.611885","-0.0119209","56.229752","41.695923"],["Land_BagBunker_Large_F","24.157696","0.128725","102.260246","310.0971375"],["Land_BagBunker_Large_F","24.275145","0.0799999","276.797089","129.325378"],["Land_BagBunker_Large_F","24.545815","0.0799999","248.800964","39.861214"],["Land_BagBunker_Large_F","25.0770245","0.059185","162.349686","310.248932"],["Land_BagBunker_Large_F","25.253431","0.0799999","189.403305","40.29081"]];
		_baseParts = [_baseParts, [], { parseNumber (_x select 1) }, "DESC"] call BIS_fnc_sortBy;
		_lastPart = diag_tickTime;
		_timePerPart = (1 * 60) / count _baseParts;
	
		{
			waitUntil { sleep 1; diag_tickTime - _lastPart >= _timePerPart && {_x distance _location < 50} count (units _building) > 0 };
			[_location, 0, [_x]] call BL_fnc_spawnCollection;
			_lastPart = diag_tickTime;
		} forEach _baseParts;
		
		_conditions set [0, true]; // Building done.
	};
	
	/* Builders loop. Reissue waypoints as needed. Force them to defend base location. */
	[_location, _missionCode, _building] spawn {
		_location    = _this select 0;
		_missionCode = _this select 1;
		_building    = _this select 2;
		
		while { !([_missionCode] call BL_fnc_taskCompleted) && [_missionCode] call BL_fnc_taskExists } do {
			if ( currentWaypoint _building >= (count waypoints _building) ) then {
				{deleteWaypoint [_building, _forEachIndex]} forEach (waypoints _building);
				_building setBehaviour "AWARE";
				_building setCombatMode "RED";
				
				_wp = _building addWaypoint [_location, 0];
				_wp setWaypointType "MOVE";
				_building setCurrentWaypoint _wp;
			};
		
			sleep 30;
		};
	};
	
	/* Kill all the players loop */
	[_location, _missionCode, _conditions] spawn {
		_location = _this select 0;
		_missionCode = _this select 1;
		_conditions = _this select 2;
	
		// Wait for base to be built
		waitUntil { _conditions select 0 };
		
		_veh = createVehicle [
			"B_Heli_Attack_01_F",
			[_location, 3000 + random 3000, random 359] call BIS_fnc_relPos,
			[],
			0,
			"FLY"
		];
		
		_group = createGroup east;
		(_group createUnit ["O_Pilot_F", [0,0,0], [], 0, "FORM"]) moveInDriver _veh;
		(_group createUnit ["O_helicrew_F", [0,0,0], [], 0, "FORM"]) moveInGunner _veh;

		[
			true,
			[format["%1%2", _missionCode, 1], _missionCode],
			["", "Opfor Blackfoot", "Opfor Blackfoot"],
			[objNull, true],
			'CREATED'
		] call BL_fnc_taskCreate;
		
		[_veh, 'reward'] call BL_fnc_trackVehicle;
		_group call BL_fnc_statTrackAIUnits;
		
		_wp = _group addWaypoint [_location, 0];
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointType "SAD";
		_group setCurrentWaypoint _wp;
		
		sleep (60 * 5);
		if !(!([_missionCode] call BL_fnc_taskCompleted) && [_missionCode] call BL_fnc_taskExists) exitwith{};
		
		_veh = createVehicle [
			"O_Plane_CAS_02_F",
			[_location, 3000 + random 3000, random 359] call BIS_fnc_relPos,
			[],
			0,
			"FLY"
		];
		
		_group = createGroup east;
		(_group createUnit ["O_Pilot_F", [0,0,0], [], 0, "FORM"]) moveInDriver _veh;
		
		[
			true,
			[format["%1%2", _missionCode, 2], _missionCode],
			["", "Opfor Neophron", "Opfor Neophron"],
			[objNull, true],
			'CREATED'
		] call BL_fnc_taskCreate;

		_wp = _group addWaypoint [_location, 0];
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointType "SAD";
		_group setCurrentWaypoint _wp;		

		[_veh, 'reward'] call BL_fnc_trackVehicle;
		_group call BL_fnc_statTrackAIUnits;
	};
	
	/* Completion loop */
	[_location, _building, _missionCode, _conditions] spawn {
		_location    = _this select 0;
		_building    = _this select 1;
		_missionCode = _this select 2;
		_conditions  = _this select 3;
		
		waitUntil {_conditions select 1};
		_flag = createVehicle ["Land_Communication_F", [
				_location select 0,
				_location select 1,
				(_location select 2)-3
			],
			[],
			0,
			"CAN_COLLIDE"
		];
		
		_flag setVectorUp [0, 0, 1];
		[_flag, 'baseFlag'] call BL_fnc_trackVehicle;
		
		_baseFlag = ["opfor", _location, _flag] call BL_fnc_createBaseFlag;
		
		// Wait for at least one to make it to build site
		waitUntil {
			sleep 1;
			{alive _x && _x distance _location < 300} count (units _building) > 0
		};
		
		waitUntil {
			sleep 1;
			{alive _x && _x distance _location < 300} count (units _building) == 0 ||
			isNull _baseFlag
		};
		
		[_missionCode] call BL_fnc_missionDone;
	};
}];