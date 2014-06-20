/*
	Description:
	Kicks player from group by name
	
	Parameter(s):
	_unit - Name of the player to kick
	_grp  - Group to remove _unit from. Default: Player's group
*/

private ['_unit', '_grp'];
_unit = [_this, 0, "", [""]] call BIS_fnc_param;
_grp  = [_this, 1, group player, [grpNull]] call BIS_fnc_param;

{	
	if ( name _x == _unit ) exitwith {
		[_x] join grpNull;
	};
} forEach units _grp;