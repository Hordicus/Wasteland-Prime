[
// Init. Result of this will be passed to all
// following functions as _this select 0.
{
	_cities = [] call BL_fnc_findCities;
	_cities = [_cities, [], {
		count ([_x select 1, 3000] call BL_fnc_nearUnits)
	}, "DESCEND"] call BIS_fnc_sortBy;

	(_cities select 0)
},

"Hostile Takeover",
"Description",

// Mission location. Array or code
{
	(_this select 0 select 1)
},

// Function to call to start the mission
{
	_initResult  = _this select 0;
	_missionCode = _this select 1;
	_location    = _this select 2;

	_outerGroup = createGroup east;
	_innerGroup = createGroup east;
	_unitTypes = [
		"O_sniper_F",
		"O_Soldier_GL_F",
		"O_Soldier_F",
		"O_Soldier_LAT_F"
	];

	for "_i" from 0 to 19 do {
		_unitPos = [_location, random (_initResult select 2), random 359] call BIS_fnc_relPos;
		_unitPos set [2, 3000];
		
		_unit = _outerGroup createUnit [_unitTypes select floor random count _unitTypes, _unitPos, [], 0, "FORM"];
		[_unit, 3000, false, true] call COB_fnc_halo;
	};
	
	for "_i" from 0 to 9 do {
		_unitPos = [_location, 25, random 359] call BIS_fnc_relPos;
		_unitPos set [2, 3000];
		
		_unit = _innerGroup createUnit [_unitTypes select floor random count _unitTypes, _unitPos, [], 0, "FORM"];
		[_unit, 3000, false, true] call COB_fnc_halo;
	};

	_outerGroup allowFleeing 0;
	_outerGroup setCombatMode "RED";
	_outerGroup setBehaviour "COMBAT";
	
	_innerGroup allowFleeing 0;
	_innerGroup setCombatMode "RED";
	_innerGroup setBehaviour "COMBAT";
	
	_wp = _outerGroup addWaypoint [_location, 50];
	_wp setWaypointType "SAD";
	_outerGroup setCurrentWaypoint _wp;
		
	[_outerGroup] call BL_fnc_statTrackAIUnits;
	[_innerGroup] call BL_fnc_statTrackAIUnits;
	
	_soundSource = createVehicle ["FlagSmall_F", [_location select 0, _location select 1, 50], [], 0, "CAN_COLLIDE"];
	_soundSource enableSimulationGlobal false;
	_soundSource hideObjectGlobal true;
	[_soundSource] call BL_fnc_trackVehicle;
	
	_soundSource spawn {
		for "_i" from 0 to 9 do {
			[[_this, "air_raid"], "BL_fnc_say3D"] call BIS_fnc_MP;
			sleep 9;
		};
		
		deleteVehicle _this;
	};
	
	_rewardLoc = [];
	while { count _rewardLoc == 0 } do {
		_rewardLoc = [_location, random (_initResult select 2), random 359] call BIS_fnc_relPos;
		_rewardLoc = _rewardLoc findEmptyPosition [0, 15, "Land_Cargo40_military_green_F"];
	};
	
	_reward = createVehicle ["Land_Cargo40_military_green_F", _rewardLoc, [], 0, "CAN_COLLIDE"];
	[_reward, 'reward'] call BL_fnc_trackVehicle;
	[_reward, 6000, 150] call BL_fnc_cargoDrop;
	
	[_reward, _innerGroup, _outerGroup] spawn {
		waitUntil { isTouchingGround (_this select 0) || (getPosATL (_this select 0)) select 2 < 2 };
		waitUntil { { (getPosATL _x) select 2 > 1 } count (units (_this select 1)) == 0 };
		
		_wp = (_this select 1) addWaypoint [getPosATL (_this select 0), 5];
		_wp setWaypointType "HOLD";
		(_this select 1) setCurrentWaypoint _wp;
	};
	
	
	while { true } do {
		sleep 5;
	
		_unitsInArea = [_location, (_initResult select 2) + 100] call BL_fnc_nearUnits;
		
		{
			_outerGroup reveal [_x, 2];
			_innerGroup reveal [_x, 4];
			true
		} count _unitsInArea;
		
		// Keep innerGroup at 10 units as long as possible
		while { count units _innerGroup < 9 && count units _outerGroup > 0 } do {
			[(units _outerGroup) select ((count units _outerGroup)-1)] join _innerGroup;
		};
		
		if ( (count ([getPosATL _reward, 25] call BL_fnc_nearUnits) > 0 && {_reward distance _x <= 25 && alive _x} count ((units _outerGroup) + (units _innerGroup)) == 0) ) exitwith {
			[_missionCode] call BL_fnc_missionDone;
		};
	};
	
	[((units _outerGroup) + (units _innerGroup))] spawn {
		sleep (60 * 5);
		while { {alive _x} count (_this select 0) > 0} do {
			{
				// No one within 200m and no one within 1000m with LOS.
				if !( count ([getPosATL _x, 200] call BL_fnc_nearUnits) == 0 && !([[getPosATL _x, 1000] call BL_fnc_nearUnits, _x] call BL_fnc_hasLOS) ) then {
					deleteVehicle _x;
				};
			} count (_this select 0);
			
			sleep 60;
		};
	};
}];