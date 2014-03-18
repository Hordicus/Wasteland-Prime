/*
	Description:
	Rejects invite to player's group
	
	Parameter(s):
	_player_name - Name of player to reject
	
	Returns:
	None
*/

private ['_player_name', '_player'];
_player_name = [_this, 0, "", [""]] call BIS_fnc_param;
_player = [_player_name] call BL_fnc_playerByName;

['rejectInvite', [_player, name player]] call CBA_fnc_whereLocalEvent;
BL_groupInvites set [BL_groupInvites find _player_name, nil];