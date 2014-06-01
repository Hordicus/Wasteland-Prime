_this spawn {
	waitUntil { isPlayer (_this select 0) && !isNil "PERS_init_done" };
	
	diag_log format['initPlayerServer: %1', _this];
	['initPlayerServer', _this] call CBA_fnc_localEvent;
};