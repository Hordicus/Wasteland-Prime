#include "script_hashes.hpp"
#include "script_macros_common.hpp"
DEFAULT_PARAM(0,_array,[]);
DEFAULT_PARAM(1,_defaultValue,nil);
private ["_keys", "_values"];

_keys = [];
_values = [];

_keys resize (count _array);
_values resize (count _array);

for "_i" from 0 to ((count _array) - 1) do
{
	_keys set [_i, (_array select _i) select 0];
	_values set [_i, (_array select _i) select 1];
};

// Return.
[TYPE_HASH, _keys, _values,
	if (isNil "_defaultValue") then { nil } else { _defaultValue }];
