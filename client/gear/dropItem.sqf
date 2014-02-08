#include "dialogs\gear_defines.sqf"
disableSerialization;

_target = ctrlIDC (_this select 0);
_dropped = _this select 4;

switch (_target) do {
	case (GEAR_select_uniform_idc): {
		hint 'Dropped on uniform';
	};
};