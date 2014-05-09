#include "script_hashes.hpp"
#include "script_macros_common.hpp"
private ["_index", "_default", "_new"];
PARAMS_2(_hash,_key);

_index = (_hash select HASH_KEYS) find _key;
if (_index >= 0) then
{
	(_hash select HASH_VALUES) select _index; // Return.
} else {
	_default = _hash select HASH_DEFAULT_VALUE;
	if (isNil "_default") then {
		nil // Return
	} else {
		// Make a copy of the array instead!
		if (typeName _default == "ARRAY") then
		{
			_default = + _default;
		};
		_default // Return.
	};
};
