#include "dialogs\gear_defines.sqf"
disableSerialization;

_dialog = findDisplay GEAR_dialog_idc;
_uniform_load = _dialog displayCtrl GEAR_uniform_load_idc;
_vest_load = _dialog displayCtrl GEAR_vest_load_idc;
_backpack_load = _dialog displayCtrl GEAR_backpack_load_idc;

_uniform_load progressSetPosition (random 1);
_vest_load progressSetPosition (random 1);
_backpack_load progressSetPosition (random 1);