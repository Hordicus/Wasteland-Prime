/*
	Description:
	Accepts invite to a player's group
	
	Parameter(s):
	_player_name - Name of player to accept invite from
	
	Returns:
	Group
*/

private ['_player_name', '_player', '_grp'];
_player_name = [_this, 0, "", [""]] call BIS_fnc_param;
_player = [_player_name] call BL_fnc_playerByName;
_grp = grpNull;

// Use group _player returns grpNull when dead.
// The player will still be listed in units however.
{
	if ( _player in units _x ) exitwith {
		_grp = _x;
	};
} forEach allGroups;

BL_groupInvites set [BL_groupInvites find _player, nil];
[player] join _grp;

_grp