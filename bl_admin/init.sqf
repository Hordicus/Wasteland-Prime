BLAdmin_actions = [
	['Spectate player', 'spec'],
	['Freelook at player', 'freelook'],
	['Modify money', 'money'],
	['Clear inventory', 'clearInv'],
	['Slay', 'slay'],
	['Show group members', 'group']
];

[] spawn {
	PVAR_adminPermissions = player;
	publicVariableServer "PVAR_adminPermissions";
	
	PVAR_adminPermissionsRes = nil;
	waitUntil { !isNil "PVAR_adminPermissionsRes" };
	
	// Remove actions the user does not have access to
	{
		if !( (_x select 1) in PVAR_adminPermissionsRes ) then {
			BLAdmin_actions set [_forEachIndex, "REMOVE"];
		};
	} forEach BLAdmin_actions;
	
	BLAdmin_actions = BLAdmin_actions - ["REMOVE"];
};