#include "script_macros_common.hpp"
// Initialisation required by CBA events.
CBA_eventHandlers = "Logic" createVehicleLocal [0, 0];
CBA_eventHandlersLocal = "Logic" createVehicleLocal [0, 0];
CBA_EVENTS_DONE = false;

// TODO: Verify if this code is okay; there can be no player object ready at PreInit, thus it's not very useful
if (isServer || alive player) then {
	// We want all events, as soon as they start arriving.
	"CBA_e" addPublicVariableEventHandler { (_this select 1) call CBA_fnc_localEvent };
	"CBA_l" addPublicVariableEventHandler { (_this select 1) call CBA_fnc_remoteLocalEvent };
} else {
	// Ignore the last event that was sent out before we joined.
	[] spawn {
		waitUntil { alive player };
		"CBA_e" addPublicVariableEventHandler { (_this select 1) call CBA_fnc_localEvent };
		"CBA_l" addPublicVariableEventHandler { (_this select 1) call CBA_fnc_remoteLocalEvent };
	};
};