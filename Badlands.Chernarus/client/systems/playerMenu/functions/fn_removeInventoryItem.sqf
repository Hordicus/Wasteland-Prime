/*
	Description:
	Removes item from player's inventory.
	Basically a nicer way of modifying the
	BL_playerInv var.
	
	Parameter(s):
	_item - Item type to remove
	
	Returns:
	Array - Player inventory
*/

private ['_item', '_playerInv'];
_item = [_this, 0, "", [""]] call BIS_fnc_param;

_playerInv = player getVariable ['BL_playerInv', []];
_index = _playerInv find _item;

if ( _index > -1 ) then {
	_playerInv set [_index, -1];
	_playerInv = _playerInv - [-1];
	player setVariable ['BL_playerInv', _playerInv, true];
};

[] call BL_fnc_updatePlayerInv;

_playerInv