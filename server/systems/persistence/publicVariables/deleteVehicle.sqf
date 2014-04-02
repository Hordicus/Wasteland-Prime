"PVAR_deleteVehicle" addPublicVariableEventHandler {
	_requestedBy = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_veh         = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	_class       = typeOf _veh;
	_type        = _veh getVariable ['PERS_type', 'veh'];
	
	if ( !isPlayer _requestedBy ) exitwith{};
	
	_allowedClasses = [[] call BL_fnc_persistenceConfig, 'allowedClasses'] call CBA_fnc_hashGet;
	
	if ( _class in _allowedClasses && _type in ['basePart','beacon','veh']) then {
		deleteVehicle _veh;
		_veh call BL_fnc_deleteVehicleDB;
	
		PVAR_deleteVehicleResponse = true;
		(owner _requestedBy) publicVariableClient "PVAR_deleteVehicleResponse";
	};
};