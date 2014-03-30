"PVAR_loadPlayer" addPublicVariableEventHandler {
	[_this select 1] call BL_fnc_loadPlayer;
};

"PVAR_requestSave" addPublicVariableEventHandler {
	_requestedBy = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_obj         = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	_returnDone  = [_this select 1, 2, false, [false]] call BIS_fnc_param;
	
	if ( !isPlayer _requestedBy ) exitwith{};
	
	[] call {
		if ( _obj isKindOf "Man" ) exitwith{
			[_obj] call BL_fnc_savePlayer;
		};
		
		if ( _obj isKindOf "LandVehicle" || _obj isKindOf "Air" ) exitwith{
			// No manual save of vehicles atm
		};
		
		if ( [_obj] call LOG_fnc_objectSize != -1 ) exitwith{
			if ( _obj getVariable ['objectLocked', false] ) then {
				[_obj] call BL_fnc_saveVehicle;
			}
			else {
				[_obj] call BL_fnc_deleteVehicle;
			};
		};
	};
	
	if ( _returnDone ) then {
		PVAR_requestSaveDone = true;
		(owner _requestedBy) publicVariableClient "PVAR_requestSaveDone";
	};
};

"PVAR_createVehicle" addPublicVariableEventHandler {
	_requestedBy = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_class       = [_this select 1, 1, "", [""]] call BIS_fnc_param;
	_position    = [_this select 1, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	
	if ( !isPlayer _requestedBy ) exitwith{};
	
	_allowedClasses = [[] call BL_fnc_persistenceConfig, 'allowedClasses'] call CBA_fnc_hashGet;
	
	if ( _class in _allowedClasses ) then {
		_veh = createVehicle [_class, _position, [], 0, "CAN_COLLIDE"];
		[_veh] call BL_fnc_trackVehicle;
		
		PVAR_createVehicleResponse = _veh;
		(owner _requestedBy) publicVariableClient "PVAR_createVehicleResponse";
	};
};

PERS_trackedObjectsNetIDs = [];
PERS_trackedObjectsIDs = [];
PERS_typeHandlers = [] call CBA_fnc_hashCreate;

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