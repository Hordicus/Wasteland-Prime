#include "macro.sqf"
disableSerialization;

_display = findDisplay respawnDialogIDD;
GEAR_activeLoadout = profileNamespace getVariable ["GEAR_activeLoadout", []];

{
	_idc = _forEachIndex call GEAR_fnc_loadoutIndexToIDC;
	_img = '';
	_tooltip = '';
	
	if ( isNil ("_x") ) then {
		_img = _idc call GEAR_fnc_defaultImg;
	}
	else { if ( typeName _x != "ARRAY" ) then {
		if ( _x == "" ) then {
			_img = _idc call GEAR_fnc_defaultImg;
		}
		else {
			_img = _x call GEAR_fnc_itemImg;
			_tooltip = getText ((_x call GEAR_fnc_getConfig) >> "displayName");
		};
	}};
	
	ctrlSetText [_idc, _img];
	(_display displayCtrl _idc) ctrlSetTooltip _tooltip;
} forEach GEAR_activeLoadout;
