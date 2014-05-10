private ['_rank', '_img'];
_rank = [_this, 0, 1, [0]] call BIS_fnc_param;

_img = ([[] call BL_fnc_statTrackingConfig, 'ranks'] call CBA_fnc_hashGet) select _rank select 1;

if ( _img != "" ) then {
	MISSION_ROOT + _img
}
else {
	""
};