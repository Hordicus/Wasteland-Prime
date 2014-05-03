private ['_config'];
_config = [] call CBA_fnc_hashCreate;

[_config, 'playerKillScore', 5] call CBA_fnc_hashSet;
[_config, 'aiKillScore', 3] call CBA_fnc_hashSet;
[_config, 'deathScore', -1] call CBA_fnc_hashSet;

_config