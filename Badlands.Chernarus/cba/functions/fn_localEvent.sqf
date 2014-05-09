#include "script_macros_common.hpp"
PARAMS_1(_eventType);
DEFAULT_PARAM(1,_params,nil);

private "_handlers";

// Run locally.
_handlers = CBA_eventHandlers getVariable _eventType;

if (!isNil "_handlers") then {
	{
		if (!isNil "_x") then {
			if (isNil "_params") then {
				call _x;
			} else {
				_params call _x;
			};
		};
	} forEach _handlers;
};

nil; // Return.
