#include "functions\macro.sqf"
disableSerialization;
uiNamespace setVariable ['adminPanel', _this select 0];

_dialog = _this select 0;
_dialog call BLAdmin_fnc_hideCtrls;

_paneOne = _dialog displayCtrl paneOneIDC;

{
	if ( (_x select 2) ) then {
		_index = _paneOne lbAdd (_x select 0);
		_paneOne lbSetData [_index, (_x select 1)];
	};
	nil
} count BLAdmin_actions;

{
	_index = _paneOne lbAdd (name _x);
	_paneOne lbSetData [_index, getPlayerUID _x];
	true
} count playableUnits;