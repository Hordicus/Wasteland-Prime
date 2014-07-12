private ['_config'];
_config = [] call CBA_fnc_hashCreate;

[_config, 'Air', {
	(_this select 0) removeWeapon "HellfireLauncher";
}] call CBA_fnc_hashSet;

_config