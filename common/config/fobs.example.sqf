private ['_config'];

_config = [] call CBA_fnc_hashCreate;

[_config, 'fobs', [
	// ["Name", [/* location */], [/* collection */]]
]] call CBA_fnc_hashSet;

_config