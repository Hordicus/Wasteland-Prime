#include "functions\macro.sqf"
disableSerialization;
_dialog = uiNamespace getVariable 'adminPanel';

_paneTwo = _dialog displayCtrl paneTwoIDC;
lbClear _paneTwo;

BL_adminPlayer = [(_this select 0) lbData (_this select 1)] call BL_fnc_playerByUID;

{
	_index = _paneTwo lbAdd (_x select 0);
	_paneTwo lbSetData [_index, _x select 1];
	
	true
} count [
	['Spectate player', 'spec'],
	['Camera at player', 'freelook'],
	['Modify money', 'money'],
	['Clear inventory', 'clearInv'],
	['Modify inventory', 'modifyInv'],
	['Slay', 'slay'],
	['Show group members', 'group']
];