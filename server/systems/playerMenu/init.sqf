private ['_mission_start'];
_mission_start = diag_tickTime;
while { true } do {
	['serverUpdate', [
		round diag_fps,
		diag_tickTime - _mission_start
	]] call CBA_fnc_globalEvent;
	sleep 10;
};