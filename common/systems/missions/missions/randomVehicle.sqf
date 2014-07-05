[
// Init. Result of this will be passed to all
// following functions as _this select 0.
{
	private ['_possible'];
	_possible = [call BL_fnc_missionsConfig, 'randomVehicleRewards'] call CBA_fnc_hashGet;
	
	if ( isNil "_possible" ) then {
		_possible = [
			["I_APC_Wheeled_03_cannon_F", 1],
			["B_APC_Wheeled_01_cannon_F", 1],
			["O_MBT_02_cannon_F", 0.5],
			["I_APC_tracked_03_cannon_F", 1],
			["B_APC_Tracked_01_AA_F", 1]
		];
	};
	
	[([_possible] call BL_fnc_selectRandom) select 0, _this select 1] call (_this select 0);
},

{format['Secure %1', getText (configFile >> "CfgVehicles" >> (_this select 0) >> "displayName")]},
{
	format['A %1 has been spotted near %2. Secure it for you team.',
		getText (configFile >> "CfgVehicles" >> (_this select 0) >> "displayName"),
		([(_this select 1)] call BL_fnc_nearestCity) select 0
	]
},

// Mission location. Array or code
BL_fnc_missionRandomField,

// Function to call to start the mission
{
	_initResult  = [_this, 0, "", [""]] call BIS_fnc_param;
	_missionCode = [_this, 1, "", [""]] call BIS_fnc_param;
	_location    = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	
	_missionReward = createVehicle [_initResult, _location, [], 0, "CAN_COLLIDE"];
	[_missionReward, 'reward'] call BL_fnc_trackVehicle;
	[_missionReward] call BL_fnc_lockVehicle; // Don't let anyone in until they complete the mission
	
	_grp = createGroup east;
	_grp createUnit ["O_Soldier_SL_F", _location, [], 0, "FORM"];
	
	_grp createUnit ["O_Soldier_F", _location, [], 0, "FORM"];
	_grp createUnit ["O_Soldier_F", _location, [], 0, "FORM"];
	_grp createUnit ["O_Soldier_F", _location, [], 0, "FORM"];
	_grp createUnit ["O_Soldier_F", _location, [], 0, "FORM"];
	_grp createUnit ["O_Soldier_F", _location, [], 0, "FORM"];
	
	_grp createUnit ["O_Soldier_GL_F", _location, [], 0, "FORM"];
	_grp createUnit ["O_Soldier_GL_F", _location, [], 0, "FORM"];
	
	_grp createUnit ["O_Soldier_LAT_F", _location, [], 0, "FORM"];
	_grp createUnit ["O_Soldier_LAT_F", _location, [], 0, "FORM"];
	
	_grp createUnit ["O_Soldier_M_F", _location, [], 0, "FORM"];
	_grp createUnit ["O_Soldier_M_F", _location, [], 0, "FORM"];
	
	_grp allowFleeing 0;
	_grp setBehaviour "COMBAT";
	_grp setCombatMode "RED";
	
	[_grp] call BL_fnc_statTrackAIUnits;
	[_location, units _grp] call BL_fnc_aliveObjectCounter;
	
	[_missionReward] call BL_fnc_saveOnGetIn;
	[_grp, _missionCode, [_missionReward], {
		[_this select 0 select 0, false] call BL_fnc_lockVehicle;
	}] call BL_fnc_missionDoneWhenKilled;
	
	[_missionReward, _missionCode, [_grp], {
		_grp = _this select 0 select 0;
		_grp allowFleeing 1;
		
		_grp spawn {
			while { count units _this > 0 } do {
				sleep 60;
			
				{
					if !( [[getPosATL _x, 1000] call BL_fnc_nearUnits, _x] call BL_fnc_hasLOS ) then {
						deleteVehicle _x;
					};
					true
				} count (units _this);
			};
		};
	}] call BL_fnc_failOnKilled;
}];