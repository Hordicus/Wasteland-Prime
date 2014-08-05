if ( isServer ) then {
	(owner (_this select 0)) publicVariableClient (_this select 1);
}
else {
	BL_PVAR_publicVariableClientRelay = [_this select 0, missionNamespace getVariable (_this select 1), (_this select 1)];
	publicVariableServer "BL_PVAR_publicVariableClientRelay";
};