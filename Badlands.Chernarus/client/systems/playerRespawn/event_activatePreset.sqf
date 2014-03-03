#include "functions\macro.sqf"
disableSerialization;

_row = lnbCurSelRow respawnListPresetsIDC;
if ( _row == -1 ) exitwith{}; // No preset selected, do nothing

_presetName = lnbData[respawnListPresetsIDC, [_row, 1]];

GEAR_presets = profileNamespace getVariable ["GEAR_presets", [] call CBA_fnc_hashCreate];
GEAR_activeLoadout = + [GEAR_presets, _presetName] call CBA_fnc_hashGet; // + creates copy

profileNamespace setVariable ["GEAR_activeLoadout", GEAR_activeLoadout];
saveProfileNamespace;

[] call BL_fnc_showActiveLoadout;