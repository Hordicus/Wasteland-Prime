#include "dialogs\gear_defines.sqf"

private ['_img', '_idc', '_tooltip', '_loadout_info'];

{
	_idc = _forEachIndex call GEAR_loadoutIndexToIDC;
	_img = '';
	_tooltip = '';
	
	if ( isNil ("_x") ) then {
		_img = _idc call GEAR_defaultImg;
	}
	else { if ( typeName _x != "ARRAY" ) then {
		if ( _x == "" ) then {
			_img = _idc call GEAR_defaultImg;
		}
		else {
			_img = _x call GEAR_itemImg;
			_tooltip = getText ((_x call GEAR_getConfig) >> "displayName");
		};
	}};
	
	ctrlSetText [_idc, _img];
	((findDisplay GEAR_dialog_idc) displayCtrl _idc) ctrlSetTooltip _tooltip;
} forEach GEAR_activeLoadout;

_loadout_info = parseText format['Total: $%1', GEAR_activeLoadout call GEAR_loadoutTotal];

((findDisplay GEAR_dialog_idc) displayCtrl GEAR_purchase_info_idc) ctrlSetStructuredText _loadout_info;