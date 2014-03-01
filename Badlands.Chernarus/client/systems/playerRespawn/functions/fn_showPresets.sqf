#include "macro.sqf"
GEAR_presets = profileNamespace getVariable ["GEAR_presets", [] call CBA_fnc_hashCreate];
GEAR_activeLoadout = profileNamespace getVariable ["GEAR_activeLoadout", []];

// lnbAddRow [respawnListPresetsIDC, ["", "Preset", "$1000"]];

[GEAR_presets, {
	lnbAddRow [respawnListPresetsIDC, ["", _key, "$1000"]];
}] call CBA_fnc_hashEachPair;