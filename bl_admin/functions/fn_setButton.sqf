#include "macro.sqf"

private ['_text', '_action', '_position', '_btn', '_paneThreeCfg', '_textCtrl'];
_text     = [_this, 0, "", [""]] call BIS_fnc_param;
_action   = [_this, 1, {}, [{}]] call BIS_fnc_param;
_position = [_this, 2, [0,0,0,0], [[]]] call BIS_fnc_param;

_btn = (uiNamespace getVariable 'adminPanel') displayCtrl buttonOneIDC;

_btn ctrlShow true;
_btn ctrlSetText _text;
_btn ctrlRemoveAllEventHandlers 'MouseButtonClick';
_btn ctrlAddEventHandler ['MouseButtonClick', _action];

_paneThreeCfg = (configFile >> "adminPanel" >> "controls" >> "paneThree");

if ( _position select 0 == 0 ) then {
	_position set [0, getNumber (_paneThreeCfg >> "x") + safezoneW * 0.01];
};

if ( _position select 1 == 0 ) then {
	if ( ctrlVisible infoTextIDC ) then {
		_position set [1, getNumber (_paneThreeCfg >> "y") + (ctrlTextHeight ((uiNamespace getVariable 'adminPanel') displayCtrl infoTextIDC)) + (safezoneH * 0.02)];
	}
	else {
		_position set [1, getNumber (_paneThreeCfg >> "y") + safezoneH * 0.01];
	};
};

if ( _position select 2 == 0 ) then {
	_position set [2, getNumber (_paneThreeCfg >> "w") - safezoneW * 0.02];
};

if ( _position select 3 == 0 ) then {
	_position set [3, safezoneH * 0.03];
};

_btn ctrlSetPosition _position;
_btn ctrlCommit 0;

_btn