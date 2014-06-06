private ['_config'];
_config = [[], []] call CBA_fnc_hashCreate;

[_config, "uid", [
	'spec', 'freelook', 'money', 'clearInv', 'slay', 'group' // Allowed actions
]] call CBA_fnc_hashSet;

_config