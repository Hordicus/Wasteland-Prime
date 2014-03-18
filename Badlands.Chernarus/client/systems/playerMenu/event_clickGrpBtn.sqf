#include "functions\macro.sqf"

_idc = ctrlIDC (_this select 0);
_btns = [groupBtn1IDC, groupBtn2IDC, groupBtn3IDC, groupBtn4IDC];
_index = _btns find _idc;

if ( count BL_groupEventHandlers >= _index ) then {
	_eh = BL_groupEventHandlers select _index;
	
	(_eh select 1) call (_eh select 2);
};