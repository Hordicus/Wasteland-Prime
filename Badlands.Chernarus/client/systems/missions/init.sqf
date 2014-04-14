[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};
	
	BL_PVAR_currentTasks = missionNamespace getVariable ['BL_PVAR_currentTasks', [] call CBA_fnc_hashCreate];
	
	"BL_PVAR_currentTasks" addPublicVariableEventHandler {
		[] call BL_fnc_setTaskVars;
	};
	
	// Handle JIP
	[] call BL_fnc_setTaskVars;
	[BL_PVAR_currentTasks, {
		if ( typeName _value != "STRING" ) then {
			[_value select 0 select 0, false, serverTime] call BIS_fnc_setTaskLocal;
		};
	}] call CBA_fnc_hashEachPair;
};