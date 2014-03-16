#include "functions\macro.sqf"

[] spawn {
	disableSerialization;
	waituntil{!isNull(findDisplay GEAR_dialog_idc)};
	_dialog = findDisplay GEAR_dialog_idc;

	GEAR_activeNav = 'guns';
	GEAR_activeSubNav = 'ammo';
	GEAR_activeContainer = 'uniform';

	GEAR_presets = profileNamespace getVariable ["GEAR_presets", [] call CBA_fnc_hashCreate];
	GEAR_activeLoadout = profileNamespace getVariable ["GEAR_activeLoadout", []];

	call GEAR_fnc_updateDialogImgs;
	GEAR_beforeChanges = GEAR_activeLoadout;
	'guns' call compile preprocessFileLineNumbers 'gear\event_showItems.sqf';
	call compile preprocessFileLineNumbers 'gear\event_updateTabs.sqf';
	GEAR_activeContainer call GEAR_fnc_selectContainer;
};