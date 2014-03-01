/*
	Description:
	Searches for player with the given
	UID and returns the player.
	
	Parameter(s):
	String - UID
	
	Returns:
	player
*/

private ['_searchFor', '_result'];
_searchFor = [_this, 0, '', ['']] call BIS_fnc_param;
_result = objNull;

{
	if ( getPlayerUID _x == _searchFor ) exitwith {
		_result = _x;
	};
	
} count playableUnits;

_result