BL_groupInvites = [];
BL_groupSentInvites = [];
BL_avgServerFps = 0;
BL_serverUpTime = 0;

BL_playerInventoryHandlers = [];
BL_playerInventoryCodes = [];

['groupInvite', {
	BL_groupInvites set [count BL_groupInvites, _this select 1];	
	[] call BL_fnc_updateGroupInfo;
	
	(_this select 1) spawn {
		titleText [format['%1 has invited you to join a group.', _this], "PLAIN", 0];
		sleep 5;
		titleFadeOut 2;
	};
}] call CBA_fnc_addLocalEventHandler;

['groupCancelInvite', {
	BL_groupInvites set [BL_groupInvites find (_this select 1), nil];
	[] call BL_fnc_updateGroupInfo;
}] call CBA_fnc_addLocalEventHandler;

['rejectInvite', {
	BL_groupSentInvites set [BL_groupSentInvites find (_this select 1), nil];
	[] call BL_fnc_updateGroupInfo;
}] call CBA_fnc_addLocalEventHandler;

['serverUpdate', {
	BL_avgServerFps = (_this select 0);
	BL_serverUpTime = (_this select 1);
}] call CBA_fnc_addEventHandler;

[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};

	player addEventHandler ['respawn', {
		player addAction ['Player Menu', "createDialog 'playerMenuDialog';", [], -1];
	}];

	player addAction ['Player Menu', "createDialog 'playerMenuDialog';", [], -1];
};