#include "macro.sqf"
disableSerialization;

_display = findDisplay respawnDialogIDD;

{
	_idc = _forEachIndex call GEAR_fnc_loadoutIndexToIDC;
	
	if ( _idc > -1 ) then {
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
		
		(_display displayCtrl _idc) ctrlSetText _img;
		(_display displayCtrl _idc) ctrlSetTooltip _tooltip;
	};
} forEach GEAR_activeLoadout;
