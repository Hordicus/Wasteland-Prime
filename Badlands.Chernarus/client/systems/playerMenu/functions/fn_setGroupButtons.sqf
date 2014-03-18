#include "macro.sqf"
private ["_btnText","_display","_groupBtns","_i"];

_btnText = [_this, 0, [], [[]]] call BIS_fnc_param;
_display = [_this, 1, (findDisplay playerMenuDialogIDD), [displayNull]] call BIS_fnc_param;

_groupBtns = [
	_display displayCtrl groupBtn1IDC,
	_display displayCtrl groupBtn2IDC,
	_display displayCtrl groupBtn3IDC,
	_display displayCtrl groupBtn4IDC
];

BL_groupEventHandlers = _btnText;

for "_i" from 0 to count _groupBtns do {
	if ( _i < count _btnText ) then {
		(_groupBtns select _i) ctrlSetText (_btnText select _i select 0);
		(_groupBtns select _i) ctrlShow true;
	}
	else {
		(_groupBtns select _i) ctrlShow false;
	};
};