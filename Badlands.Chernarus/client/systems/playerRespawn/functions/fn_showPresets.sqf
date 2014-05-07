#include "macro.sqf"
private ['_row', '_money', '_loadoutTotal', '_color'];
GEAR_presets = profileNamespace getVariable ["GEAR_presets", [] call CBA_fnc_hashCreate];
GEAR_activeLoadout = profileNamespace getVariable ["GEAR_activeLoadout", []];

_row = 0;
lbClear ((findDisplay respawnDialogIDD) displayCtrl respawnListPresetsIDC);
[GEAR_presets, {
	if ( typeName _value == "ARRAY" ) then {
		_price = (_value call GEAR_fnc_filterLoadout) call GEAR_fnc_loadoutTotal;
		lnbAddRow [respawnListPresetsIDC, ["", _key, format['$%1', _price]]];
		lnbSetData [respawnListPresetsIDC, [_row, 1], _key];
		
		_row = _row + 1;
	};
}] call CBA_fnc_hashEachPair;

_money = [] call BL_fnc_money;
_loadoutTotal = GEAR_activeLoadout call GEAR_fnc_loadoutTotal;
_color = "#FFFFFF";
if ( _loadoutTotal > _money ) then {
	_color = "#FF0000";
};

((findDisplay respawnDialogIDD) displayCtrl respawnTransactionDetailsIDC) ctrlSetStructuredText parseText format["
Cash: <t align='right'>$%1</t><br />
Loadout Cost: <t align='right'>$%2</t><br />
Total: <t align='right' color='%4'>$%3</t><br />
",
_money,
_loadoutTotal,
_money - _loadoutTotal,
_color
];