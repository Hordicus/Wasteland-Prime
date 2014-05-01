#include "functions\macro.sqf"
BL_groupInvites = [];
BL_groupSentInvites = [];
BL_avgServerFps = 0;
BL_serverUpTime = 0;
BL_grass = profileNamespace getVariable ['BL_grass', 1]; // Default
BL_enableEnv = profileNamespace getVariable ['BL_enableEnv', 1];
BL_playerMenuKey = profileNamespace getVariable ['BL_playerMenuKey', 41 /* ~ */ ];
BL_playerMenuActionID = -1;

BL_playerInventoryHandlers = missionNamespace getVariable ['BL_playerInventoryHandlers', []];
BL_playerInventoryCodes = missionNamespace getVariable ['BL_playerInventoryCodes', []];

if ( !hasInterface ) exitwith{};

['groupInvite', {
	BL_groupInvites set [count BL_groupInvites, _this select 1];	
	[] call BL_fnc_updateGroupInfo;
	
	[format['%1 has invited you to join a group.', _this select 1], 5] call BL_fnc_actionText;
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

['Pick up money',
{(_this select 0) isKindOf ('moneyModel' call BL_fnc_config) && !BL_animDoWorkInProgress },
{
	[5, "Picking up money %1", _this, {
		_amount = (_this select 0) getVariable ['moneyAmount', 0];
		player setVariable ['money', _amount + (player getVariable ['money', 0]), true];
		(_this select 0) call BL_fnc_deleteVehicle;
	}] call BL_fnc_animDoWork;
}, 1] call BL_fnc_addAction;

[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};

	[BL_grass] call BL_fnc_setGrass;
	[BL_enableEnv] call BL_fnc_setEnvEnabled;
	
	(findDisplay 46) displayAddEventHandler ['KeyDown', {
		if ( _this select 1 == BL_playerMenuKey && isNull findDisplay playerMenuDialogIDD) then {
			createDialog 'playerMenuDialog';
			true
		};
	}];

	player addEventHandler ['respawn', {
		(_this select 1) removeAction BL_playerMenuActionID;
		BL_playerMenuActionID = player addAction ['Player Menu', "createDialog 'playerMenuDialog';", [], -1];
	}];

	BL_playerMenuActionID = player addAction ['Player Menu', "createDialog 'playerMenuDialog';", [], -1];
};