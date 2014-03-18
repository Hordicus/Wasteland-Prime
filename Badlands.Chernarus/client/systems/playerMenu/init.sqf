BL_groupInvites = [];
BL_groupSentInvites = [];

player addEventHandler ['respawn', {
	player addAction ['Player Menu', "createDialog 'playerMenuDialog';", [], -1];
}];

player addAction ['Player Menu', "createDialog 'playerMenuDialog';", [], -1];

['groupInvite', {
	BL_groupInvites set [count BL_groupInvites, _this select 1];
}] call CBA_fnc_addLocalEventHandler;

['groupCancelInvite', {
	BL_groupInvites set [BL_groupInvites find (_this select 1), nil];
}] call CBA_fnc_addLocalEventHandler;

['rejectInvite', {
	BL_groupSentInvites set [BL_groupSentInvites find (_this select 1), nil];
}] call CBA_fnc_addLocalEventHandler;