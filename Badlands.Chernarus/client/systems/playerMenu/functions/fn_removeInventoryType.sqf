/*
	Description:
	Removes the behaviour for when a user
	clicks use/drop on a given item.
	
	Parameter(s):
	_index - Number returned from BL_fnc_addInventoryType
	
	Returns:
	None
*/

private ['_index'];
_index = [_this, 0, -1, [0]] call BIS_fnc_param;

BL_playerInventoryHandlers set [_index, nil];
BL_playerInventoryCodes set [_index, nil];