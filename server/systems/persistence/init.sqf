PERS_trackedObjectsNetIDs = [];
PERS_trackedObjectsIDs = [];
PERS_typeData = [];

[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\createVehicle.sqf";
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
		{
			_netId = netId _x;
			_index = PERS_trackedObjectsNetIDs find _netId;
			if ( _index == -1 ) then {
				deleteVehicle _x;
			};
		} count ((getPosATL mapCenter) nearEntities [["LandVehicle","Air","ReammoBox_F"], 100000]);
	
		sleep 60;
	};
};

// Check all objects, delete anything that isn't tracked
[] spawn {
	private ["_netId","_index"];
	while { true } do {
		{
			_ignore = _x call {
				// Entities, tracked above.
				if ( _x isKindOf 'LandVehicle' ) exitwith {true};
				if ( _x isKindOf 'Air' ) exitwith {true};
				if ( _x isKindOf 'ReammoBox_F' ) exitwith {true};

				if ( _x isKindOf 'Man' ) exitwith {true};
				if ( _x isKindOf 'Logic' ) exitwith {true};
				false
			};
			
			if ( !_ignore ) then {
				_netId = netId _x;
				_index = PERS_trackedObjectsNetIDs find _netId;
				if ( _index == -1 ) then {
					diag_log format['Deleting untracked object: %1 (%2)', typeOf _x, _x];
					deleteVehicle _x;
				};
			};
		} count allMissionObjects "All";
	
		sleep (60 * 5);
	};
};

// Periodic saving loops
[] spawn {
	sleep 60;
	private ["_savePlayer","_player","_lastSave","_processed","_index","_dbID"];
	_savePlayer = {
		_player =  _this select 0;
		_lastSave = _player getVariable 'lastSave';
		if ( time - _lastSave >= 60 ) then {
			[_player] call BL_fnc_savePlayer;
		};
	};
	while { true } do {
		{
			_processed = _x getVariable ['persistenceEHAdded', false];

			if ( !_processed ) then {
				_x addEventHandler ['Put', _savePlayer];
				_x addEventHandler ['Take', _savePlayer];
				_x addEventHandler ['Killed', _savePlayer];
				_x addEventHandler ['Fired', _savePlayer];
				_x setVariable ['lastSave', time];
				_x setVariable ['persistenceEHAdded', true];
			};
			
			[_x] call _savePlayer;
			true
		} count playableUnits;
		
		{
			_index = PERS_trackedObjectsNetIDs find (netId _x);
			_dbID = PERS_trackedObjectsIDs select _index;

			if ( !isNil "_dbID" && (_x getVariable ['lastSaveState', '']) != (_x call BL_fnc_vehicleState)) then {
				[_x] call BL_fnc_saveVehicle;
			};
			true
		} count ((getPosATL mapCenter) nearEntities [["LandVehicle","Air","ReammoBox_F"], 100000]);
		
		sleep (60 * 5);
	};
};