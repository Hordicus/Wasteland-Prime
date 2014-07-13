BL_PVAR_protect = missionNamespace getVariable ['BL_PVAR_protect', []];

{
	_x call BL_fnc_protect;
	nil
} count BL_PVAR_protect;

"BL_PVAR_protect" addPublicVariableEventHandler {
	(BL_PVAR_protect select (count BL_PVAR_protect)-1) call BL_fnc_protect;
};