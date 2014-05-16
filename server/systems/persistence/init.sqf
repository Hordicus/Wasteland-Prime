#include "\x\bl_server\addons\performance.sqf"
PERS_trackedObjectsNetIDs = [];
PERS_trackedObjectsIDs = [];
PERS_typeData = [];

[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\createVehicle.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\trackVehicle.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\deleteVehicle.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\loadPlayer.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\requestSave.sqf";

// Handlers that don't have their own system
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\typeHandlers\baseParts.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\typeHandlers\spawnBeacons.sqf";

private ["_count","_lastStep","_i","_vehicles","_result"];

_database   = [call BL_fnc_persistenceConfig, 'database'] call CBA_fnc_hashGet;

_result = "Arma2Net.Unmanaged" callExtension format['Arma2NETMySQLBigCommand ["%1", "%2"]', _database, "SELECT * FROM `vehicles`"];
_result = [] call compile preprocessFileLineNumbers _result;

_result = [_result] call BL_fnc_processQueryResult;

{
	[_x] call BL_fnc_loadVehicle;
	true
} count (_result select 0);

PERS_init_done = true;

// Delete entities that aren't in our system.
[] spawn {
	private ["_netId","_index"];
	while { true } do {
		PERF_START("untracked_entities");
		{
			_netId = netId _x;
			_index = PERS_trackedObjectsNetIDs find _netId;
			if ( _index == -1 && !(_x isKindOf "ParachuteBase") ) then {
				[_x] call BL_fnc_logUntrackedVehicle;
				deleteVehicle _x;
			};
		} count ((getPosATL mapCenter) nearEntities [["LandVehicle","Air","ReammoBox_F"], 100000]);
		PERF_STOP("untracked_entities", false);
		
		sleep 60;
	};
};

// Check all objects, delete anything that isn't tracked
[] spawn {
	private ["_netId","_index"];
	while { true } do {
		PERF_START("untracked_objects");
		{
			_ignore = _x call {
				// Entities, tracked above.
				if ( _x isKindOf 'LandVehicle' ) exitwith {true};
				if ( _x isKindOf 'Air' ) exitwith {true};
				if ( _x isKindOf 'ReammoBox_F' ) exitwith {true};
				if ( _x isKindOf 'CraterLong' ) exitwith {true};
				if ( _x isKindOf 'WeaponHolderSimulated' ) exitwith {true};
				if ( _x isKindOf 'GroundWeaponHolder' ) exitwith {true};
				if ( _x isKindOf 'MineBase' ) exitwith {true};
				if ( _x isKindOf 'Ruins' ) exitwith {true};

				if ( _x isKindOf 'Man' ) exitwith {true};
				if ( _x isKindOf 'Logic' ) exitwith {true};
				false
			};
			
			if ( !_ignore ) then {
				_netId = netId _x;
				_index = PERS_trackedObjectsNetIDs find _netId;
				if ( _index == -1 ) then {
					[_x] call BL_fnc_logUntrackedVehicle;
					deleteVehicle _x;
				};
			};
		} count allMissionObjects "All";
		PERF_STOP("untracked_objects", false);
		
		sleep (60 * 5);
	};
};