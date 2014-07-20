PERS_trackedObjectsNetIDs = [];
PERS_trackedObjectsIDs = [];
PERS_typeData = [];
MySQLQueue = missionNamespace getVariable ["MySQLQueue", []];
MySQLGroupQueue = missionNamespace getVariable ["MySQLGroupQueue", []];

[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\publicVariables\createVehicle.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\publicVariables\trackVehicle.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\publicVariables\deleteVehicle.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\publicVariables\loadPlayer.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\publicVariables\requestSave.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\publicVariables\setVelocity.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\publicVariables\setDirAndUp.sqf";

// Handlers that don't have their own system
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\typeHandlers\baseParts.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\typeHandlers\spawnBeacons.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\typeHandlers\townVeh.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\typeHandlers\rareVeh.sqf";

private ["_count","_lastStep","_i","_vehicles","_result"];
if ( isServer ) then {
	_database   = [call BL_fnc_persistenceConfig, 'database'] call CBA_fnc_hashGet;

	_result = "Arma2Net.Unmanaged" callExtension format['Arma2NETMySQLBigCommand ["%1", "%2"]', _database, "SELECT * FROM `vehicles`"];
	_result = [] call compile preprocessFileLineNumbers _result;

	_result = [_result] call BL_fnc_processQueryResult;
	
	PERS_init_count = count (_result select 0);
	publicVariable "PERS_init_count";
	
	PERS_init_currentCount = 0;
	PERS_start = diag_tickTime;
	
	(_result select 0) spawn {
		_threads = [];
		
		{
			_threads set [_forEachIndex, [_x] spawn BL_fnc_loadVehicle];
			PERS_init_currentCount = _forEachIndex;
			
			waitUntil { {!scriptDone _x} count _threads < 5 };
		} forEach _this;
	};
	
	[] spawn {
		while { PERS_init_currentCount < PERS_init_count-1 } do {
			sleep 1;
			publicVariable "PERS_init_currentCount";
		};
		
		PERS_init_done = true;
		publicVariable "PERS_init_done";
		
		diag_log format['Init object count: %1', PERS_init_count];
		diag_log format['Init time: %1', diag_tickTime - PERS_start];

		["SELECT `value` FROM `settings` WHERE `key` = 'reset'", [], [], {
			if ( count (_this select 0 select 0) > 0 && {(_this select 0 select 0 select 0 select 0) == 1}) then {
				{
					if ( _x getVariable ['PERS_type', 'veh'] in ['basePart', 'crate'] ) then {
						[_x] call BL_fnc_deleteVehicleDB;
						_x setVariable ['objectLocked', false, true];
					};
				} count allMissionObjects "All";
			};
		}] call BL_fnc_MySQLCommand;
	};
};

// Delete entities that aren't in our system.
// [] spawn {
	// while { true } do {
		// {
			// if ( (PERS_trackedObjectsNetIDs find (netId _x)) == -1 && !(_x isKindOf "ParachuteBase") ) then {
				// [_x] call BL_fnc_logUntrackedVehicle;
				// deleteVehicle _x;
			// };
		// } count ((getPosATL mapCenter) nearEntities [["LandVehicle","Air","ReammoBox_F"], 100000]);
	
		// sleep 60;
	// };
// };

// Check all objects, delete anything that isn't tracked
// [] spawn {
	// private ["_netId","_index"];
	// while { true } do {
		// {
			// if !(_x call {
				// Entities, tracked above.
				// if ( _x isKindOf 'LandVehicle' ) exitwith {true};
				// if ( _x isKindOf 'Air' ) exitwith {true};
				// if ( _x isKindOf 'ReammoBox_F' ) exitwith {true};
				// if ( _x isKindOf 'CraterLong' ) exitwith {true};
				// if ( _x isKindOf 'WeaponHolderSimulated' ) exitwith {true};
				// if ( _x isKindOf 'GroundWeaponHolder' ) exitwith {true};
				// if ( _x isKindOf 'MineBase' ) exitwith {true};
				// if ( _x isKindOf 'Ruins' ) exitwith {true};

				// if ( _x isKindOf 'Man' ) exitwith {true};
				// if ( _x isKindOf 'Logic' ) exitwith {true};
				// false
			// }) then {
				// if ( (PERS_trackedObjectsNetIDs find (netId _x)) == -1 ) then {
					// [_x] call BL_fnc_logUntrackedVehicle;
					// deleteVehicle _x;
				// };
			// };
		// } count allMissionObjects "All";
	
		// sleep (60 * 5);
	// };
// };