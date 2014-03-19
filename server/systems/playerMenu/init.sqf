while { true } do {
	['fpsUpdate', [round diag_fps]] call CBA_fnc_globalEvent;
	sleep 10;
};