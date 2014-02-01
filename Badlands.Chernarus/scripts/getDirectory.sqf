_a = [__FILE__, "\"] call CBA_fnc_split;
_a resize ( count _a ) - 1;
_a = [_a, "\"] call CBA_fnc_join;

hint str _a