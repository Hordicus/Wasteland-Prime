_a = [_this, "\"] call CBA_fnc_split;
_a resize ( count _a ) - 1;
_a = [_a, "\"] call CBA_fnc_join;

// If there is no drive then we are in install folder.
if ( ([_a, ":"] call CBA_fnc_find) == -1 ) then {
	_a = "\" + _a;
};

_a