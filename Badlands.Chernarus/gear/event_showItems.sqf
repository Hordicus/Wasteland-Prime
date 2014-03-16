#include "functions\macro.sqf"

private ["_type", "_config", "_items", "_name", "_price", "_string", "_img", "_i"];
_type = _this;
lbClear ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_itemslist_idc);

if ( _type == 'presets' ) then {
	[GEAR_presets, {
		if ( typeName _value == "ARRAY" ) then { // hashRem sets value to "UNDEF"
			_price = _value call GEAR_fnc_loadoutTotal;
			
			_string = format['%1 [$%2]', _key, _price];
			_index = lbAdd [GEAR_itemslist_idc, _string];
			lbSetData [GEAR_itemslist_idc, _index, _key];
		};
	}] call CBA_fnc_hashEachPair;
}
else {
	_config = call GEAR_fnc_config;
	_items = [_config, _type] call CBA_fnc_hashGet;

	{
		_name = (_x select 0) call GEAR_fnc_itemName;
		_img = (_x select 0) call GEAR_fnc_itemImg;
		_price = _x select 1;
		
		_string = format['%1 [$%2]', _name, _price];
		lbAdd [GEAR_itemslist_idc, _string];
		lbSetData [GEAR_itemslist_idc, _forEachIndex, _x select 0];
		lbSetPicture[GEAR_itemslist_idc, _forEachIndex, _img];

	} forEach _items;
};

lbSetCurSel [GEAR_itemslist_idc, 0];