[
'Mission Name',
'An example mission. A simple reference to base other missions off of.',

// Mission location. Array or code
BL_fnc_missionRandomField,

// Function to call to start the mission
{
	_missionCode = [_this, 0, "", [""]] call BIS_fnc_param;
	_location    = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	
	_missionReward = createVehicle ["O_APC_Tracked_02_AA_F", _location, [], 0, "CAN_COLLIDE"];
	[_missionReward, 'reward'] call BL_fnc_trackVehicle;
	_missionReward lock true; // Don't let anyone in until they complete the mission
	
	_grp = createGroup resistance;
	_grp createUnit ["I_Soldier_SL_F", _location, [], 0, "FORM"];
	
	_grp createUnit ["I_Soldier_F", _location, [], 0, "FORM"];
	_grp createUnit ["I_Soldier_F", _location, [], 0, "FORM"];
	_grp createUnit ["I_Soldier_F", _location, [], 0, "FORM"];
	_grp createUnit ["I_Soldier_F", _location, [], 0, "FORM"];
	_grp createUnit ["I_Soldier_F", _location, [], 0, "FORM"];
	
	_grp createUnit ["I_Soldier_GL_F", _location, [], 0, "FORM"];
	_grp createUnit ["I_Soldier_GL_F", _location, [], 0, "FORM"];
	
	_grp createUnit ["I_Soldier_LAT_F", _location, [], 0, "FORM"];
	_grp createUnit ["I_Soldier_LAT_F", _location, [], 0, "FORM"];
	
	_grp createUnit ["I_Soldier_M_F", _location, [], 0, "FORM"];
	_grp createUnit ["I_Soldier_M_F", _location, [], 0, "FORM"];
	
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