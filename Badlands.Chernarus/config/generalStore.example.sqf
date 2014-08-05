private ['_config'];
_config = [] call CBA_fnc_hashCreate;
[_config, 'items', [
    ["General Store", [
        ["Ground Beacon", 4000, "Description", {'groundBeacon' call BL_fnc_addInventoryItem;}],
    ]]
]] call CBA_fnc_hashSet;

[_config, 'resalePrices', [
	["hgun_ACPC2_F",25]
]] call CBA_fnc_hashSet;

_config