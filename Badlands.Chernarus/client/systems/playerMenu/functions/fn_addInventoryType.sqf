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
		format['<t color="#00a3e0"><img image="client\systems\playerMenu\icons\pickup.paa" /> Pick up %1</t>', _itemName],
		compile format['(_this select 0) isKindOf "%1" && "%2" == ((_this select 0) getVariable["BL_invDroppedType", ""])', _itemModel, _itemType],
		{
			_item = BL_playerInventoryHandlers select (BL_playerInventoryCodes find ((_this select 0) getVariable 'BL_invDroppedType'));
			[5, (format['Picking up %1 ', _item select 1]) + '%1', [_this, _item], {
				if ( !isNull (_this select 0 select 0) ) then {
					(_this select 0 select 0) call BL_fnc_deleteVehicle;
					(_this select 1 select 0) call BL_fnc_addInventoryItem;
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