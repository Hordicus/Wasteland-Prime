#include "script_macros_common.hpp"
PARAMS_3(_params,_index,_defaultValue);

private "_value";

if (not isNil "_defaultValue") then
{
	_value = _defaultValue;
};

if (not isNil "_params") then
{
	if ((typeName _params) == "ARRAY") then
	{
		if ((count _params) > (_index)) then
		{
			if (not isNil { _params select (_index) }) then
			{
				_value = _params select (_index);
			};
		};
	};
};

// Return.
if (isNil "_value") then
{
	nil;
} else {
	_value;
};
