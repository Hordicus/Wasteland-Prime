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

['rareVeh', [
	// Save
	{(_this select 0) getVariable ['originalSpawnPoint', getPosATL (_this select 0)]},
	
	// Load
	{
		(_this select 0) setVariable ['originalSpawnPoint', _this select 1];
	}
]] call BL_fnc_persRegisterTypeHandler;


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

// Handlers that don't have their own system
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\typeHandlers\baseParts.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_common\addons\systems\persistence\typeHandlers\spawnBeacons.sqf";

private ["_count","_lastStep","_i","_vehicles","_result"];
if ( isServer ) then {
	_database   = [call BL_fnc_persistenceConfig, 'database'] call CBA_fnc_hashGet;

	_result = "Arma2Net.Unmanaged" callExtension format['Arma2NETMySQLBigCommand ["%1", "%2"]', _database, "SELECT * FROM `vehicles`"];
	_result = [] call compile preprocessFileLineNumbers _result;

	_result = [_result] call BL_fnc_processQueryResult;

	(_result select 0) spawn {
		{
			[_x] call BL_fnc_loadVehicle;
			if ( _forEachIndex % 10 == 0 ) then { sleep 0.1 };
			true
		} forEach _this;

		PERS_init_done = true;
		publicVariable "PERS_init_done";
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