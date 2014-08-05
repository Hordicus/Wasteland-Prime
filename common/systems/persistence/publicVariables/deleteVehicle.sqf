["PVAR_deleteVehicle", "PVAR_deleteVehicle", {
	_requestedBy = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_veh         = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	_class       = typeOf _veh;
	_type        = _veh getVariable ['PERS_type', 'veh'];
	
	if ( !isPlayer _requestedBy ) exitwith{};
	
	_allowedClasses = [[] call BL_fnc_persistenceConfig, 'allowedClasses'] call CBA_fnc_hashGet;
	
	if ( _class in _allowedClasses && _type in ['basePart','beacon','invItem','veh']) then {
		deleteVehicle _veh;
		_veh call BL_fnc_deleteVehicleDB;
	
		PVAR_deleteVehicleResponse = true;
		[_requestedBy, "PVAR_deleteVehicleResponse"] call BL_fnc_publicVariableClient;
	};
}] call BL_fnc_addPublicVariableEventHandler;