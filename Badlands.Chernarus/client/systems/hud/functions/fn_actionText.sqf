/*
	Description:
	Show text in the center of screen. Structured
	text supported.
	
	Parameter(s):
	_text - Text to show. Will be run through parseText and wrapped in
		text tags to center text.
	_hideAfter - How long to show the item for. If -1 it will stay until
		manually hidden, or overwritten.
	
	Returns:
	actionText rsc
*/
#include "macro.sqf"
disableSerialization;

private ['_text', '_hideAfter', '_hud', '_actionText'];
_text      = [_this, 0, "", [""]] call BIS_fnc_param;
_hideAfter = [_this, 1, -1, [0]] call BIS_fnc_param;

_hud = uiNamespace getVariable 'HUD';
_actionText = _hud displayCtrl HUDactionTextIDC;

_text = parseText format['<t align="center" shadow="2">%1</t>', _text];

_actionText ctrlSetStructuredText _text;
_actionText ctrlSetFade 0;
_actionText ctrlCommit 0.5;

if ( _hideAfter > -1 ) then {
	[_hideAfter, str _text, _actionText] spawn {
		sleep (_this select 0);
		if ( (ctrlText (_this select 2)) == (_this select 1) ) then {
			(_this select 2) ctrlSetFade 1;
			(_this select 2) ctrlCommit 1;
		};
	};
};

_actionText