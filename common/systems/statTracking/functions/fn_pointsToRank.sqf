private ['_points', '_rank'];
_points = [_this, 0, 0, [0]] call BIS_fnc_param;
_rank = 0;

{
	if ( (_x select 0) > _points ) exitwith{};
	
	_rank = _forEachIndex;
} forEach ([[] call BL_fnc_statTrackingConfig, 'ranks'] call CBA_fnc_hashGet);

_rank