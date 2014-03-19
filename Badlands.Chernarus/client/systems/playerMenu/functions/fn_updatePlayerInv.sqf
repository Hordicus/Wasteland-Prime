#include "macro.sqf"
disableSerialization;

_display = [_this, 0, (findDisplay playerMenuDialogIDD), [displayNull]] call BIS_fnc_param;
_playerInv = (_display displayCtrl playerInventoryIDC);
lbClear _playerInv;

{
	_itemName = BL_playerInventoryHandlers select (
		BL_playerInventoryCodes find _x
	) select 1;

	_index = _playerInv lbAdd _itemName;
	_playerInv lbSetData [_index, _x];
} forEach (player getVariable ['BL_playerInv', []]);