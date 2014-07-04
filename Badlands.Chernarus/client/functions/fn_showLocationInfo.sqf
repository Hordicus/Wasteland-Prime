private ['_nearestCity'];
_nearestCity = [getPosATL player] call BL_fnc_nearestCity;

[
	[_nearestCity select 1, getPosATL vehicle player] call BL_fnc_directionToString,
	format['of %1', _nearestCity select 0]
] spawn BIS_fnc_infoText;