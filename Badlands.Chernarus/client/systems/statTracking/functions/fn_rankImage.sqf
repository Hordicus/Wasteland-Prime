private ['_rank'];
_rank = [_this, 0, 1, [0]] call BIS_fnc_param;

MISSION_ROOT + (([[] call BL_fnc_statTrackingConfig, 'ranks'] call CBA_fnc_hashGet) select _rank select 1)