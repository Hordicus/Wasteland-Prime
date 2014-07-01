private ['_config'];
_config = [] call CBA_fnc_hashCreate;

[_config, 'spawns', [
	// [_class, _location, _direction, _init, _respawnTime],
]] call CBA_fnc_hashSet;

_config