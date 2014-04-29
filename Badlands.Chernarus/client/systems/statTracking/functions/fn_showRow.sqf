#include "macro.sqf"
private ['_dialog', '_row', '_show'];
_dialog = [_this, 0, displayNull, [displayNull]] call BIS_fnc_param;
_row    = [_this, 1, 0, [0]] call BIS_fnc_param;
_show   = [_this, 2, true, [true]] call BIS_fnc_param;

(_dialog displayCtrl (IDC(_row, 0))) ctrlShow _show;
(_dialog displayCtrl (IDC(_row, 1))) ctrlShow _show;
(_dialog displayCtrl (IDC(_row, 2))) ctrlShow _show;
(_dialog displayCtrl (IDC(_row, 3))) ctrlShow _show;
(_dialog displayCtrl (IDC(_row, 4))) ctrlShow _show;
(_dialog displayCtrl (IDC(_row, 5))) ctrlShow _show;
(_dialog displayCtrl (IDC(_row, 6))) ctrlShow _show;
(_dialog displayCtrl (IDC(_row, 7))) ctrlShow _show;