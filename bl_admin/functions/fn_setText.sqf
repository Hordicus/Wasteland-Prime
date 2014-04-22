#include "macro.sqf"

private ['_text', '_ctrl'];
_text     = [_this, 0, "", [""]] call BIS_fnc_param;

_ctrl = (uiNamespace getVariable 'adminPanel') displayCtrl infoTextIDC;
_ctrl ctrlShow true;

_ctrl ctrlSetStructuredText parseText _text;

_ctrlCfg = (missionConfigFile >> "adminPanel" >> "controls" >> "infoText");

_ctrl ctrlSetPosition [
	getNumber (_ctrlCfg >> "x"),
	getNumber (_ctrlCfg >> "y"),
	getNumber (_ctrlCfg >> "w"),
	ctrlTextHeight _ctrl
];

_ctrl ctrlCommit 0;

_ctrl