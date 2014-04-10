[
// Init. Result of this will be passed to all
// following functions as _this select 0.
{
	_possible = [
		["I_APC_Wheeled_03_cannon_F", 1],
		["B_APC_Wheeled_01_cannon_F", 1],
		["O_MBT_02_cannon_F", 0.5],
		["I_APC_tracked_03_cannon_F", 1],
		["B_APC_Tracked_01_AA_F", 1]
	];
	
	([_possible] call BL_fnc_selectRandom) select 0
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
	_missionReward lock true; // Don't let anyone in until they complete the mission
	
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
		
	waitUntil {
		sleep 1;
		({alive _x} count units _grp) == 0
		|| !alive _missionReward
	};
	
	if ( alive _missionReward ) then {
		_missionReward lock false;
		_missionReward setVariable ['getInEH', _missionReward addEventHandler ['GetIn', {
			[_this select 0] call BL_fnc_saveVehicle;
			(_this select 0) removeEventHandler ['GetIn', (_this select 0) getVariable 'getInEH'];
		}]];
		
		[_missionCode, true] call BL_fnc_missionDone;
	}
	else {
		[_missionCode, false] call BL_fnc_missionDone;
		
		// Make units flee. Wait until they are out of sight and then delete them.
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
	};
}];