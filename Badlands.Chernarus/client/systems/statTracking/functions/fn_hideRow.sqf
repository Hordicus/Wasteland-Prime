#include "macro.sqf"
private ['_dialog', '_row'];
_dialog = [_this, 0, displayNull, [displayNull]] call BIS_fnc_param;
_row = [_this, 1, 0, [0]] call BIS_fnc_param;

[_dialog, _row, false] call BL_fnc_showRow;