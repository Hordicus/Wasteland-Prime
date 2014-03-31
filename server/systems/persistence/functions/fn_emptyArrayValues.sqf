private ['_array'];
_array = [_this, 0, [], [[]]] call BIS_fnc_param;

{
	if ( typeName _x == "STRING" && {_x == "NEMPTY"} ) then {
		_array set [_forEachIndex, ""];
	}
	else {
		if ( typeName _x == "ARRAY" ) then {
			[_x] call BL_fnc_emptyArrayValues;
		};
	};
} forEach _array;

_array