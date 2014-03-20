/*
	Description:
	Gets item from path provided in the format
	"categoryIndex.itemIndex"
	
	Parameter(s):
	_itemPath
	
	Returns:
	Item from store config
*/

private ['_storeCfg', '_itemIndex'];
_storeCfg = uiNamespace getVariable 'storeCfg';
_itemIndex = [_this, '.'] call BIS_fnc_splitString;
(_storeCfg select 1) select (parseNumber (_itemIndex select 0)) select 1 select (parseNumber (_itemIndex select 1))