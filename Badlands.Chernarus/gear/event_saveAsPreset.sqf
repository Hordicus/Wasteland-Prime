#include "functions\macro.sqf"
private ['_name', '_loadout'];
_name = ctrlText (GEAR_preset_name_idc);
[GEAR_presets, _name, GEAR_activeLoadout] call CBA_fnc_hashSet;
profileNamespace setVariable ["GEAR_presets", GEAR_presets];
saveProfileNamespace;

closeDialog 0;