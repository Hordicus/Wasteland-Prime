#include "functions\macro.sqf"

private ['_btn', '_type', '_info', '_params'];
_btn = _this;
_type = lbData [playerInventoryIDC, lbCurSel playerInventoryIDC];
_info = BL_playerInventoryHandlers select (
	BL_playerInventoryCodes find _type
);

_params = _info select 2;

if ( _btn == 'use' ) then {
	_params call (_info select 4);
}
else {
	_info call BL_fnc_dropInventoryItem;
};