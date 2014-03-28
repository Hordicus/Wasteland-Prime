private ['_arr'];
_arr = _this select 0;

{
	if ( !isNil "_x" ) then {
		if ( typeName _x == "SCALAR" ) then {
			_arr set [_forEachIndex, _x call BL_fnc_floatToString];
		}
		else { if ( typeName _x == "ARRAY" ) then {
			_arr set [_forEachIndex, [_x] call BL_fnc_allFloatsToStrings];
		}};
	};
} forEach _arr;

_arr