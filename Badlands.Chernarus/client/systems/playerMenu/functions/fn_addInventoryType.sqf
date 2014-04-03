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

private ['_itemType', '_itemName', '_itemModel', '_params', '_useEh', '_dropEh', '_index'];
_itemType  = [_this, 0, "", [""]] call BIS_fnc_param;
_itemName  = [_this, 1, "", [""]] call BIS_fnc_param;
_itemModel = [_this, 2, "", [""]] call BIS_fnc_param;
_params    = [_this, 3, [], [[]]] call BIS_fnc_param;
_useEh     = [_this, 4, {}, [{}]] call BIS_fnc_param;
_dropEh    = [_this, 5, false, [{}, false]] call BIS_fnc_param;
_addAct    = [_this, 6, true, [true]] call BIS_fnc_param;

_actionIndex = -1;

if ( _addAct && hasInterface ) then {
	_actionIndex = [
		format['Pick up %1', _itemName],
		compile format['(_this select 0) isKindOf "%1" && (_this select 0) getVariable["BL_invDroppedItem", false]', _itemModel],
		{
			[5, _this, {
				if ( !isNull (_this select 0) ) then {
					_type = (_this select 0) getVariable 'BL_invDroppedType';
					(_this select 0) call BL_fnc_deleteVehicle;
					_type call BL_fnc_addInventoryItem;
				};
			}] call BL_fnc_animDoWork;
		},
		1
	] call BL_fnc_addAction;
};

BL_playerInventoryHandlers = missionNamespace getVariable ['BL_playerInventoryHandlers', []];
BL_playerInventoryCodes = missionNamespace getVariable ['BL_playerInventoryCodes', []];

_index = count BL_playerInventoryHandlers;
BL_playerInventoryHandlers set [_index, [
	_itemType,
	_itemName,
	_itemModel,
	_params,
	_useEh,
	_dropEh,
	_actionIndex
]];

BL_playerInventoryCodes set [_index, _itemType];

_index