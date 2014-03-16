#include "macro.sqf"

private ['_cfg', '_allowedSlots'];
_cfg = _this call GEAR_fnc_getConfig;
_allowedSlots = getArray (_cfg >> 'allowedSlots');

if ( count _allowedSlots == 0 ) then {
	_allowedSlots = [GEAR_type_uniform, GEAR_type_vest, GEAR_type_backpack];
};

_allowedSlots