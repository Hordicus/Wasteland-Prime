private ['_config'];
_config = [[], ""] call CBA_fnc_hashCreate;

[_config, 'objectLoad', 'uid'] call CBA_fnc_hashSet;
[_config, 'weaponsCrates', 'uid'] call CBA_fnc_hashSet;
[_config, 'radar', 'uid'] call CBA_fnc_hashSet;

_config