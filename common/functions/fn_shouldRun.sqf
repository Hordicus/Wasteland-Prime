private ['_system', '_runsOn', '_shouldRun', '_uid'];
_system = [_this, 0, "", [""]] call BIS_fnc_param;
_uid = getPlayerUID player;

if ( !isServer && _uid == "" ) then {
	_uid = [call BL_fnc_systemsConfig, profileName] call CBA_fnc_hashGet;
};

_runsOn = [call BL_fnc_systemsConfig, _system] call CBA_fnc_hashGet;
_shouldRun = _runsOn call {
	if ( _this == "" && isServer ) exitwith { true };
	if ( _this != "" && (_uid == _this) ) exitwith { true };
	if ( _this != "" && isServer && !isNil "PERS_init_done" ) exitwith {
		{ _this == (_x select 1) } count BL_HCs == 0
	};
	
	false
};

_shouldRun