#include "dialogs\gear_defines.sqf"
disableSerialization;

_dialog = findDisplay GEAR_dialog_idc;
_button = _this select 0;
_on = _this select 1;
_bg_idc = (ctrlIDC _button) - 1;

hint format["On: %1", _on == 1];

_bg = _dialog displayCtrl _bg_idc;
if ( _on == 1 ) then {
	_bg ctrlSetTextColor [0,0,0,1];
}
else {
	_bg ctrlSetTextColor [1,1,1,1];
};