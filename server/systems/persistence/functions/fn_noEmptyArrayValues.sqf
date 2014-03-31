private ['_array'];
_array = [_this, 0, [], [[]]] call BIS_fnc_param;

{
	if ( !isNil "_x" ) then {
		if ( typeName _x == "STRING" && {_x == ""} ) then {
			_array set [_forEachIndex, "NEMPTY"];
		}
		else {
			if ( typeName _x == "ARRAY" ) then {
				[_x] call BL_fnc_noEmptyArrayValues;
			};
		};
	};
} forEach _array;

_array