"PVAR_loadPlayer" addPublicVariableEventHandler {
	waitUntil { !isNil "PERS_init_done" };
	[_this select 1] call BL_fnc_loadPlayer;
};