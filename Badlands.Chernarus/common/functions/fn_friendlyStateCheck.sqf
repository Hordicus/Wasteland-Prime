_this spawn {
	private ["_position","_radius","_friendlyTo","_cbArgs","_cb"];
	_position   = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	_radius     = [_this, 1, 5, [5]] call BIS_fnc_param;
	_friendlyTo = [_this, 2, objNull, [objNull]] call BIS_fnc_param;
	_cbArgs     = [_this, 3, [], [[]]] call BIS_fnc_param;
	_cb         = [_this, 4, {}, [{}]] call BIS_fnc_param;

	PVAR_radarFriendlyCheck = [
		player,
		_position,
		_radius,
		_friendlyTo
	];
	
	PVAR_radarFriendlyCheck_result = nil;
	publicVariableServer "PVAR_radarFriendlyCheck";
	
	waituntil { !isNil "PVAR_radarFriendlyCheck_result" };
	
	[PVAR_radarFriendlyCheck_result, _cbArgs] call _cb;
};