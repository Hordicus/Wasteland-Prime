#include "script_macros_common.hpp"
PARAMS_2(_eventType,_handler);

private ["_handlers", "_handlerIndex"];

_handlers = CBA_eventHandlersLocal getVariable _eventType;

if (isNil "_handlers") then {
	// No handlers for this event already exist, so make a new event type.
	CBA_eventHandlersLocal setVariable [_eventType, [_handler]];
	_handlerIndex = 0;
} else {
	// Handlers already recorded, so add another one.
	_handlerIndex = count _handlers;
	PUSH(_handlers,_handler);
};

TRACE_2("Added",_eventType,_handlerIndex);

_handlerIndex; // Return.
