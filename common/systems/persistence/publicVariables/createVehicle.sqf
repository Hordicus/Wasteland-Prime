["PVAR_createVehicle", "PVAR_createVehicle", {
	_requestedBy = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_class       = [_this select 1, 1, "", [""]] call BIS_fnc_param;
	_position    = [_this select 1, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	_type        = [_this select 1, 3, "veh", [""]] call BIS_fnc_param;
	_special     = [_this select 1, 4, "CAN_COLLIDE", [""]] call BIS_fnc_param;
	_withCrew    = [_this select 1, 5, false, [false]] call BIS_fnc_param;
	
	if ( !isPlayer _requestedBy ) exitwith{};
	
	_allowedClasses = [[] call BL_fnc_persistenceConfig, 'allowedClasses'] call CBA_fnc_hashGet;
	
	if ( _class in _allowedClasses && _type in ['basePart','beacon','invItem','veh']) then {
		_veh = createVehicle [_class, _position, [], 0, _special];
		[_veh, _type] call BL_fnc_trackVehicle;
		
		if ( (_veh isKindOf "UAV_01_base_F" || _veh isKindOf  "UAV_02_base_F") && _withCrew ) then {
			createVehicleCrew _veh;
		};
		
		PVAR_createVehicleResponse = _veh;
		[_requestedBy, "PVAR_createVehicleResponse"] call BL_fnc_publicVariableClient;
	};
}] call BL_fnc_addPublicVariableEventHandler;