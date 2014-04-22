#include "functions\macro.sqf"
disableSerialization;
uiNamespace setVariable ['adminPanel', _this select 0];

_dialog = _this select 0;
_paneOne = _dialog displayCtrl paneOneIDC;

{
	_index = _paneOne lbAdd (name _x);
	_paneOne lbSetData [_index, getPlayerUID _x];
	true
} count allUnits;