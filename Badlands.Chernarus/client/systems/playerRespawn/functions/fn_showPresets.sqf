#include "macro.sqf"
GEAR_presets = profileNamespace getVariable ["GEAR_presets", [] call CBA_fnc_hashCreate];
GEAR_activeLoadout = profileNamespace getVariable ["GEAR_activeLoadout", []];

// lnbAddRow [respawnListPresetsIDC, ["", "Preset", "$1000"]];

_row = 0;
[GEAR_presets, {
	if ( typeName _value == "ARRAY" ) then {
		_price = _value call GEAR_fnc_loadoutTotal;
		lnbAddRow [respawnListPresetsIDC, ["", _key, format['$%1', _price]]];
		lnbSetData [respawnListPresetsIDC, [_row, 1], _key];
		
		_row = _row + 1;
	};
}] call CBA_fnc_hashEachPair;