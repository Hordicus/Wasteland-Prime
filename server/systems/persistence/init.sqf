PERS_trackedObjectsNetIDs = [];
PERS_trackedObjectsIDs = [];

[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\createVehicle.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\deleteVehicle.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\loadPlayer.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\publicVariables\requestSave.sqf";

// Handlers that don't have their own system
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\typeHandlers\baseParts.sqf";
[] call compile preprocessFileLineNumbers "\x\bl_server\addons\systems\persistence\typeHandlers\spawnBeacons.sqf";

[] spawn {
	private ["_count","_lastStep","_i","_vehicles"];
	["SELECT COUNT(*) FROM `vehicles`", [], [], {
		_count = _this select 0 select 0 select 0 select 0;
		_lastStep = ceil (_count/5)*5;
		
		// Load all vehicles, 5 at a time.
		for "_i" from 0 to _lastStep step 5 do {
			["SELECT * FROM `vehicles` LIMIT %1, 5", [_i], [_i == _lastStep], {
				_vehicles = _this select 0 select 0;
				{
					[_x] call BL_fnc_loadVehicle;
					true
				} count _vehicles;
				
				if ( _this select 1 select 0 ) then {
					PERS_init_done = true;
				};
			}] call BL_fnc_MySQLCommand;
		};
	}] call BL_fnc_MySQLCommand;
};

// Delete anything that isn't in our system.
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

// Periodic saving loops
[] spawn {
	private ["_savePlayer","_player","_lastSave","_processed","_lastSavePos","_index","_dbID"];
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
			_lastSave = _x getVariable 'lastSave';
			_lastSavePos = _x getVariable 'lastSavePos';

			_index = PERS_trackedObjectsNetIDs find (netId _x);
			_dbID = PERS_trackedObjectsIDs select _index;

			if ( !isNil "_dbID" && ((getPosATL _x) distance _lastSavePos) >= 10) then {
				[_x] call BL_fnc_saveVehicle;
			};
			true
		} count ((getPosATL mapCenter) nearEntities [["LandVehicle","Air","ReammoBox_F"], 100000]);
		
		sleep (60 * 5);
	};
};