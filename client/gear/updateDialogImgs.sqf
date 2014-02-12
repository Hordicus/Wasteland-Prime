#include "dialogs\gear_defines.sqf"

private ['_img', '_idc'];

{
	_idc = _forEachIndex call GEAR_loadoutIndexToIDC;
	_img = '';
	
	if ( isNil ("_x") ) then {
		_img = _idc call GEAR_defaultImg;
	}
	else { if ( typeName _x != "ARRAY" ) then {
		if ( _x == "" ) then {
			_img = _idc call GEAR_defaultImg;
		}
		else {
			_img = _x call GEAR_itemImg;
		};
	}};
	
	ctrlSetText [_idc, _img];
} forEach GEAR_activeLoadout;