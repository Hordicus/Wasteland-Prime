/*
	Description:
	Registers the behaviour for when a user
	clicks use/drop on a given item.
	
	Parameter(s):
	_itemType - Item type name
	_itemName - What to show in player inv
	_params   - Array to pass to event handler
	_useEh    - Function to call when user clicks "Use"
	_dropEh   - Function to call when user clicks "Drop"
	
	Returns:
	Index used to remove handler
*/

private ['_itemType', '_params', '_useEh', '_dropEh', '_index'];
_itemType = [_this, 0, "", [""]] call BIS_fnc_param;
_itemName = [_this, 1, "", [""]] call BIS_fnc_param;
_params   = [_this, 2, [], [[]]] call BIS_fnc_param;
_useEh    = [_this, 3, {}, [{}]] call BIS_fnc_param;
_dropEh   = [_this, 4, {}, [{}]] call BIS_fnc_param;

_index = count BL_playerInventoryHandlers;
BL_playerInventoryHandlers set [_index, [
	_itemType,
	_itemName,
	_params,
	_useEh,
	_dropEh
]];

BL_playerInventoryCodes set [_index, _itemType];

_index