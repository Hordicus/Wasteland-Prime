#include "macro.sqf"
disableSerialization;

/*
[
	"General Store", // Title
	[
		// Categories
		// If only one Category then the category drop down will be hidden
		["General Store", [
			["Item One", "lbData"],
			["Item Two", "lbData"],
			["Item Three", "lbData"]
		]]
	],
	
	// Function to call when item is selected
	{
		_pane = _this select 0; // 'items' or 'cart'
		_itemText = _this select 1;
		_lbData = _this select 2;
	},
	
	// Function to call when cart is updated.
	{
	
	}
];
*/

private ['_title', '_items', '_onItemSel', '_cartChange'];
_title      = [_this, 0, "Store", [""]] call BIS_fnc_param;
_items      = [_this, 1, [], [[]]] call BIS_fnc_param;
_onItemSel  = [_this, 2, {}, [{}]] call BIS_fnc_param;
_cartChange = [_this, 3, {}, [{}]] call BIS_fnc_param;

private ['_dialog', '_titleCtrl', '_catCtrl', '_itemsCtrl'];
createDialog 'storeDialog';
_dialog = uiNamespace getVariable 'storeDialog';
_titleCtrl = _dialog displayCtrl storeTitleIDC;
_catCtrl   = _dialog displayCtrl storeCategoriesIDC;
_itemsCtrl = _dialog displayCtrl storeItemsIDC;

uiNamespace setVariable ['storeItems', _items];

_titleCtrl ctrlSetText _title;

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