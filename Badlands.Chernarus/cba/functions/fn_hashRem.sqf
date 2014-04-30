#include "script_hashes.hpp"
#include "script_macros_common.hpp"
PARAMS_2(_hash,_key);

private ["_defaultValue"];

_defaultValue = _hash select HASH_DEFAULT_VALUE;
[_hash, _key, if (isNil "_defaultValue") then { nil } else { _defaultValue }] call CBA_fnc_hashSet;

_hash; // Return.
