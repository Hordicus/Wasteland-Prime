#include "functions\macro.sqf"

_ctrl = _this select 0;
_actions = [];

if ( ctrlIDC _ctrl == allPlayersIDC ) then {
	_player = lbText [allPlayersIDC, lbCurSel allPlayersIDC];
	
	if ( _player in BL_groupSentInvites ) then {
		_actions set [count _actions, ["Cancel Invite", [_player], {
			_this call BL_fnc_cancelGroupInvite;
			[] call BL_fnc_updateGroupInfo;

			// Will trigger this script again
			lbSetCurSel [allPlayersIDC, lbCurSel allPlayersIDC];			
		}]];
	};
	
	if !( _player in BL_groupSentInvites || _player in BL_groupInvites ) then {
		_actions set [count _actions, ["Invite to Group", [_player], {
			_this call BL_fnc_sendGroupInvite;
			[] call BL_fnc_updateGroupInfo;

			// Will trigger this script again
			lbSetCurSel [allPlayersIDC, lbCurSel allPlayersIDC];			
		}]];
	};
	
	if ( _player in BL_groupInvites ) then {
		_actions set [count _actions, ["Accept Invite", [_player], {
			_this call BL_fnc_acceptGroupInvite;
			[] call BL_fnc_updateGroupInfo;

			// Will trigger this script again
			lbSetCurSel [allPlayersIDC, lbCurSel allPlayersIDC];			
		}]];
		
		_actions set [count _actions, ["Reject Invite", [_player], {
			_this call BL_fnc_rejectGroupInvite;
			[] call BL_fnc_updateGroupInfo;

			// Will trigger this script again
			lbSetCurSel [allPlayersIDC, lbCurSel allPlayersIDC];			
		}]];
	};
}
else {
	_player = lbText [groupPlayersIDC, lbCurSel groupPlayersIDC];
	if ( leader group player == player ) then {
		_actions set [count _actions, ["Promote to leader", [_player], {
			_this call BL_fnc_promoteToLeader;
			[] call BL_fnc_updateGroupInfo;

			// Will trigger this script again
			lbSetCurSel [groupPlayersIDC, lbCurSel groupPlayersIDC];			
		}]];
		_actions set [count _actions, ["Kick from group", [_player], {
			_this call BL_fnc_kickFromGroup;
			[] call BL_fnc_updateGroupInfo;
			
			// Will trigger this script again
			lbSetCurSel [groupPlayersIDC, lbCurSel groupPlayersIDC];
		}]];
	};
};

[_actions] call BL_fnc_setGroupButtons;