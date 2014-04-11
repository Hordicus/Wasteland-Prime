"PVAR_loadPlayer" addPublicVariableEventHandler {
	if ( isNil "PERS_init_done" ) then {
		_this spawn {
			waitUntil { !isNil "PERS_init_done" };
			[_this select 1] call BL_fnc_loadPlayer;
		};
	}
	else {
		[_this select 1] call BL_fnc_loadPlayer;
	};
};