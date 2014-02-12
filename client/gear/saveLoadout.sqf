#include "dialogs\gear_defines.sqf"
private ['_cfg', '_onSave', '_close'];

_cfg = call GEAR_config;
_onSave = [_cfg, 'onSave'] call CBA_fnc_hashGet;
_close = true;

if ( isNil "_onSave" ) then {
	// Default behaviour
	// Give user loadout and close dialog
	[player, (GEAR_activeLoadout call GEAR_toLoadoutArray)] call GEAR_setLoadout;
}
else {
	// Allow cfg to override how saving is handled
	_close = call _onSave;
};

if ( _close ) then {
	closeDialog GEAR_dialog_idc;
};