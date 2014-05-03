#include "macro.sqf"
private ['_dialog', '_row', '_rank', '_player'];
_dialog = [_this, 0, displayNull, [displayNull]] call BIS_fnc_param;
_row    = [_this, 1, 0, [0]] call BIS_fnc_param;
_rank   = [_this, 2, 0, [0]] call BIS_fnc_param;
_player = [_this, 3, [], [[]], [7, 0]] call BIS_fnc_param;

[_dialog, _row] call BL_fnc_showRow;

if (count _player == 0 ) then {
	(_dialog displayCtrl (IDC(_row, 0))) ctrlSetText "";
	(_dialog displayCtrl (IDC(_row, 2))) ctrlSetText "";
	(_dialog displayCtrl (IDC(_row, 3))) ctrlSetText "";
	(_dialog displayCtrl (IDC(_row, 4))) ctrlSetText "";
	(_dialog displayCtrl (IDC(_row, 5))) ctrlSetText "";
	(_dialog displayCtrl (IDC(_row, 6))) ctrlSetText "";
	(_dialog displayCtrl (IDC(_row, 7))) ctrlSetText "";
}
else {
	(_dialog displayCtrl (IDC(_row, 0))) ctrlSetText str _rank;
	(_dialog displayCtrl (IDC(_row, 2))) ctrlSetText ((_player select 0) call BL_fnc_rankImage);

	(_dialog displayCtrl (IDC(_row, 3))) ctrlSetTextColor ([_player select 1] call BIS_fnc_sideColor);
	(_dialog displayCtrl (IDC(_row, 3))) ctrlSetText (_player select 2);

	(_dialog displayCtrl (IDC(_row, 4))) ctrlSetText format['$%1', (_player select 3)];
	(_dialog displayCtrl (IDC(_row, 5))) ctrlSetText str (_player select 4);
	(_dialog displayCtrl (IDC(_row, 6))) ctrlSetText str (_player select 5);
	(_dialog displayCtrl (IDC(_row, 7))) ctrlSetText str (_player select 6);
};