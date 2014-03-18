/*
	Description:
	Promotes _unit to group leader
	
	Parameter(s):
	_unit - Name of the player to promote
	_grp  - Group to remove _unit from. Default: Player's group
*/

private ['_unit', '_grp'];
_unit = [_this, 0, "", [""]] call BIS_fnc_param;
_grp  = [_this, 1, group player, [grpNull]] call BIS_fnc_param;

{	
	if ( name _x == _unit ) exitwith {
		_grp selectLeader _x;
	};
} forEach units _grp;