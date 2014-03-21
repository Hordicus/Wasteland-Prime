/*
	Description:
	Creates store dialog and sets it up.
	
	Parameter(s):
	_title - Store title shown at top of dialog.
	_categories - Categories and the items that belong to them
	_onItemSel - Function to call when a user selects an item.
		Can be used to show information about an item.
		Function will get 2 parameters.
		_pane - Where the item has been selected. 'items' or 'cart'
		_item - Item as defined in _categories
		_selectedItemInfoCtrl - Structured Text ctrl to update with information
	
	_onCartChange - Function to call when the cart is updated.
		Use this to update cartInfo.
		Function will get 2 parameters.
		_itemsInCart - Array of items that have been added to cart as defined in categories
		_cartInfoCtrl - Reference to the cart info area.
		_purchaseBtn - Reference to the purchase button.
		
	_onPurchase - Function to call when purchase button is clicked
		Use this to give the player the items in their cart.
		Function will get 1 parameter.
		_itemsInCart - Array of items that have been added to cart as defined in categories

	Example:
	[
		"General Store", // Title
		[
			// If only one Category then the category drop down will be hidden
			["General Store", [
				["Air Beacon", 5000],
				["Ground Beacon", 5000],
				["Repair kit", 500]
			]]
		],
		{
			_pane = _this select 0;
			_item = _this select 1;
			
			hint format['%1 selected', _item select 0];
		},
		
		{
			_items = _this select 0;
			_purchaseBtn = _this select 2;
			
			_total = 0;
			{
				_total = _total + (_x select 1);
			} forEach _items;
			
			hint format["Your total is %1", _total];
			
			if ( _total > playerMoney ) then {
				_purchaseBtn ctrlEnable false;
			}
			else {
				_purchaseBtn ctrlEnable true;
			};
		},
		
		{
			// Give player item
		}
	] call BL_Store_fnc_showStore;
	
	Returns:
	Nothing
*/

#include "macro.sqf"
disableSerialization;

private ['_title', '_items', '_onItemSel', '_onCartChange'];
_title        = [_this, 0, "Store", [""]] call BIS_fnc_param;
_items        = [_this, 1, [], [[]]] call BIS_fnc_param;
_onItemSel    = [_this, 2, {}, [{}]] call BIS_fnc_param;
_onCartChange = [_this, 3, {}, [{}]] call BIS_fnc_param;
_onPurchase   = [_this, 4, {}, [{}]] call BIS_fnc_param;

private ['_dialog', '_titleCtrl', '_catCtrl', '_itemsCtrl', '_addRemoveBtn'];
createDialog 'storeDialog';
_dialog = uiNamespace getVariable 'storeDialog';
_titleCtrl = _dialog displayCtrl storeTitleIDC;
_catCtrl   = _dialog displayCtrl storeCategoriesIDC;
_itemsCtrl = _dialog displayCtrl storeItemsIDC;
_addRemoveBtn = _dialog displayCtrl addRemoveBtnIDC;
_purchaseBtn = _dialog displayCtrl purchaseIDC;

uiNamespace setVariable ['storeCfg', [_title, _items, _onItemSel, _onCartChange, _onPurchase]];
uiNamespace setVariable ['storeLastPane', ""];

_titleCtrl ctrlSetText _title;
_addRemoveBtn ctrlShow false;
_purchaseBtn ctrlEnable false;

if ( count _items < 2 ) then {
	// One or zero item categories.
	// Hide category dropdown and reposition
	// item list.
	_catCtrl ctrlShow false;
	
	private ['_catH', '_itemsCfg'];
	_catH = getNumber (missionConfigFile >> "storeDialog" >> "controls" >> "storeCategories" >> "h");
	_itemsCfg = missionConfigFile >> "storeDialog" >> "controls" >> "storeItems";
	
	_itemsCtrl ctrlSetPosition [
		getNumber (_itemsCfg >> "x"),
		(getNumber (_itemsCfg >> "y")) - _catH,
		getNumber (_itemsCfg >> "w"),
		(getNumber (_itemsCfg >> "h")) + _catH
	];
	
	_itemsCtrl ctrlCommit 0;
}
else {
	// List categories. Default: All
	_catCtrl lbAdd SHOW_ALL_TEXT;
	_catCtrl lbSetCurSel 0;
	
	{
		_catCtrl lbAdd (_x select 0);
	} forEach _items;
};

[_items] call BL_Store_fnc_showItems;

// Trigger cart update. Should set cart info with any initial info.
[[], _dialog displayCtrl cartInfoIDC, _purchaseBtn] call _onCartChange;