"PVAR_adminPermissions" addPublicVariableEventHandler {
	_player = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	
	if ( !isPlayer _player ) exitwith {};
	
	_perms = [[] call BL_fnc_adminConfig, getPlayerUID _player] call CBA_fnc_hashGet;
	PVAR_adminPermissionsRes = _perms;
	
	(owner _player) publicVariableClient "PVAR_adminPermissionsRes";
};

"PVAR_adminLog" addPublicVariableEventHandler {
	_player = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_msg    = [_this select 1, 1, "", [""]] call BIS_fnc_param;
	
	if ( !isPlayer _player ) exitwith {};
	_perms = [[] call BL_fnc_adminConfig, getPlayerUID _player] call CBA_fnc_hashGet;

	if ( count _perms > 0 ) then {
		['admin', _msg] call BL_fnc_log;
	};
};

"PVAR_adminDelete" addPublicVariableEventHandler {
	_player = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_obj    = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	
	if ( !isPlayer _player ) exitwith {};
	_perms = [[] call BL_fnc_adminConfig, getPlayerUID _player] call CBA_fnc_hashGet;

	if ( "delete" in _perms ) then {
		[_obj] call BL_fnc_deleteVehicleDB;
		
		_nearestCity = [getPosATL _obj] call BL_fnc_nearestCity;
		_info = format['%1 of %2', [getPosATL _obj, _nearestCity select 1] call BL_fnc_directionToString, _nearestCity select 0];
		
		['admin', format['%1 (%2) deleted object %3 at %4 (%5)', name _player, getPlayerUID _player, typeOf _obj, getPosATL _obj, _info]] call BL_fnc_log;
		deleteVehicle _obj;
	};
};