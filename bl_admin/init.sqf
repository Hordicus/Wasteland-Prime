BLAdmin_actions = [];

[] spawn {
	_actions = [
		['Spectate player', 'spec', false],
		['Freelook at player', 'freelook', false],
		['Modify money', 'money', false],
		['Clear inventory', 'clearInv', false],
		['Slay', 'slay', false],
		['Show group members', 'group', false],
		['Delete Cam', 'delete', true],
		['Reveal items on Map', 'reveal', true],
		['Mark mission as failed', 'missions', true]
	];
	
	waitUntil {!isNull player && player == player};
	waitUntil {!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};
	
	PVAR_adminPermissions = player;
	publicVariableServer "PVAR_adminPermissions";
	
	PVAR_adminPermissionsRes = nil;
	waitUntil { !isNil "PVAR_adminPermissionsRes" };
	
	// Remove actions the user does not have access to
	{
		if ( (_x select 1) in PVAR_adminPermissionsRes ) then {
			BLAdmin_actions set [count BLAdmin_actions, _x];
		};
	} forEach _actions;
};