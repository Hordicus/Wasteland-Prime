#include "script_macros_common.hpp"
PARAMS_1(_array);
DEFAULT_PARAM(1,_separator,"");

private ["_joined", "_element"];

if (count _array > 0) then {
	_element = _array select 0;
	_joined = if (IS_STRING(_element)) then { _element } else { str _element };

	for "_i" from 1 to ((count _array) - 1) do {
		_element = _array select _i;
		_element = if (IS_STRING(_element)) then { _element } else { str _element };
		_joined = _joined + _separator + _element;
	};
} else {
	_joined = "";
};

_joined; // Return.
