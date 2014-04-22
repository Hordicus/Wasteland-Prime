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