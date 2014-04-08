#include "functions\macro.sqf"
(_this select 0) ctrlSetText 'Press key';
(_this select 0) ctrlAddEventHandler ['KeyDown', {
	BL_playerMenuKey = _this select 1;
	(_this select 0) ctrlSetText format['Player Menu Key: %1', [BL_playerMenuKey] call BIS_fnc_keyCode];
	(_this select 0) ctrlRemoveAllEventHandlers 'KeyDown';
}];