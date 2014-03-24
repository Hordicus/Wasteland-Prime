_config = [] call CBA_fnc_hashCreate;

[_config, "amount", 100] call CBA_fnc_hashSet;
[_config, "crates", [
	["Box_NATO_Wps_F", 1, [
		["arifle_TRG20_Holo_F", 10],
		["30Rnd_556x45_Stanag", 100]
	]],
	["Box_East_AmmoOrd_F", 0.2, [
		["arifle_Mk20_ACO_F", 10],
		["30Rnd_556x45_Stanag", 100]
	]]
]] call CBA_fnc_hashSet;

_config