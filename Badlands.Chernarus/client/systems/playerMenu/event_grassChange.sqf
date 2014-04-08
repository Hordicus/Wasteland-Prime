#include "functions\macro.sqf"
private ['_index'];
_index = lbCurSel grassSettingIDC;
if ( _index >= 0 ) then {
	BL_grass = _index;
	[BL_grass] call BL_fnc_setGrass;
};