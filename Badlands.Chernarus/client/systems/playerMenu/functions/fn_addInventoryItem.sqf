/*
	Description:
	Adds item to player's inventory.
	Basically a nicer way of modifying the
	BL_playerInv var.
	
	Parameter(s):
	_item - Item type to add
	
	Returns:
	Array - Player inventory
*/

private ['_item', '_playerInv'];
_item = [_this, 0, "", [""]] call BIS_fnc_param;

_playerInv = player getVariable ['BL_playerInv', []];
_playerInv set [count _playerInv, _item];
player setVariable ['BL_playerInv', _playerInv, true];

_playerInv