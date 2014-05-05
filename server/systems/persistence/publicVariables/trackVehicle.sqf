"PVAR_trackVehicle" addPublicVariableEventHandler {
	_requestedBy = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_veh         = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	_type        = [_this select 1, 2, "veh", [""]] call BIS_fnc_param;

	if ( !isPlayer _requestedBy || !(owner _requestedBy == owner _veh) ) exitwith{};
	
	_allowedClasses = [[] call BL_fnc_persistenceConfig, 'allowedClientVehicles'] call CBA_fnc_hashGet;
	
	if ( (typeOf _veh) in _allowedClasses && _type in ['veh']) then {
		[_veh, _type] call BL_fnc_trackVehicle;
	};
};