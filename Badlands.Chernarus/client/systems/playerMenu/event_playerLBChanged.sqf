#include "functions\macro.sqf"

_ctrl = _this select 0;
BL_groupLastClicked = ctrlIDC _ctrl;
_actions = [];

if ( ctrlIDC _ctrl == allPlayersIDC ) then {
	_player = lbText [allPlayersIDC, lbCurSel allPlayersIDC];
	
	if ( _player in BL_groupSentInvites ) then {
		_actions set [count _actions, ["Cancel Invite", [_player], {
			_this call BL_fnc_cancelGroupInvite;
		}]];
	};
	
	if !( _player in BL_groupSentInvites || _player in BL_groupInvites ) then {
		_actions set [count _actions, ["Invite to Group", [_player], {
			_this call BL_fnc_sendGroupInvite;
		}]];
	};
	
	if ( _player in BL_groupInvites ) then {
		_actions set [count _actions, ["Accept Invite", [_player], {
			_this call BL_fnc_acceptGroupInvite;
		}]];
		
		_actions set [count _actions, ["Reject Invite", [_player], {
			_this call BL_fnc_rejectGroupInvite;
		}]];
	};
}
else {
	_player = lbText [groupPlayersIDC, lbCurSel groupPlayersIDC];
	if ( leader group player == player ) then {
		_actions set [count _actions, ["Promote to leader", [_player], {
			_this call BL_fnc_promoteToLeader;
		}]];
		_actions set [count _actions, ["Kick from group", [_player], {
			_this call BL_fnc_kickFromGroup;
		}]];
	};
};

[_actions] call BL_fnc_setGroupButtons;