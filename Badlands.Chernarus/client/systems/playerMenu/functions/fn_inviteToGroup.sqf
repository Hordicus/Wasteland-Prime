/*
	Description:
	Sends invite to player's group
	
	Parameter(s):
	_player_name - Name of player to invite
	
	Returns:
	None
*/

private ['_player_name', '_player'];
_player_name = [_this, 0, "", [""]] call BIS_fnc_param;
_player = [_player_name] call BL_fnc_playerByName;
['groupInvite', [_player, player]] call CBA_fnc_whereLocalEvent;
BL_groupSentInvites set [count BL_groupSentInvites, _player];