private ['_code','_success'];
_code = [_this, 0, "", [""]] call BIS_fnc_param;
_success = [_this, 1, true, [true]] call BIS_fnc_param;

if ( !([_code] call BIS_fnc_taskCompleted) && [_code] call BIS_fnc_taskExists ) then {
	if ( _success ) then {
		[_code, "SUCCEEDED"] call BIS_fnc_taskSetState;
	}
	else {
		[_code, "FAILED"] call BIS_fnc_taskSetState;
	};

	['missionDone', _code] call CBA_fnc_localEvent;
};