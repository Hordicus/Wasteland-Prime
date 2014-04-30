#include "script_macros_common.hpp"
PARAMS_2(_eventType,_handlerIndex);

private "_handlers";

_handlers = CBA_eventHandlersLocal getVariable _eventType;

if (isNil "_handlers") then {
	WARNING("Event type not registered: " + (str _eventType));
} else {
	if (count _handlers > _handlerIndex) then {
		if (isNil { _handlers select _handlerIndex } ) then {
			WARNING("Handler for event " + (str _eventType) + " index " + (str _handlerIndex) + " already removed.");
		} else {
			_handlers set [_handlerIndex, nil];
			TRACE_2("Removed",_eventType,_handlerIndex);
		};
	} else {
		WARNING("Handler for event " + (str _eventType) + " index " + (str _handlerIndex) + " never set.");
	};
};

nil; // Return.
