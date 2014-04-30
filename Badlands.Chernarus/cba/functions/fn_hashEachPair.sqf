#include "script_hashes.hpp"
#include "script_macros_common.hpp"
PARAMS_2(_hash,_code);

private ["_keys", "_values"];

_keys = _hash select HASH_KEYS;
_values = _hash select HASH_VALUES;

for "_i" from 0 to ((count _keys) - 1) do
{
	private ["_key", "_value"];

	_key = _keys select _i;
	_value = _values select _i;

	call _code;
};

nil; // Return.
