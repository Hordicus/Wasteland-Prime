waitUntil { !isNil "PVAR_playerLoaded" };
waitUntil { simulationEnabled player };
while { true } do {
	sleep (60 * 3);
	PVAR_requestSave = [player, player, false, [player, ['repetitive']] call BL_fnc_getLoadout];
	publicVariableServer "PVAR_requestSave";
};