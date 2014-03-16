#include "functions\macro.sqf"
private ['_color1', '_color2', '_buttons', '_button_names', '_active_buttons'];
_color1 = [0,0,0,1];
_color2  = [1,1,1,1];
_buttons = [GEAR_select_guns_idc, GEAR_select_launchers_idc, GEAR_select_items_idc, GEAR_select_wearables_idc, GEAR_select_ammo_idc, GEAR_select_attachments_idc, GEAR_select_presets_idc];
_button_names = ['guns', 'launchers', 'items', 'wearables', 'ammo', 'attachments', 'presets'];
_active_buttons = [
	_buttons select (_button_names find GEAR_activeNav),
	_buttons select (_button_names find GEAR_activeSubNav)
];

{
	if ( _x in _active_buttons ) then {
		((findDisplay GEAR_dialog_idc) displayCtrl _x) ctrlEnable false;
		((findDisplay GEAR_dialog_idc) displayCtrl (_x-1)) ctrlSetTextColor _color1;
	}
	else {
		((findDisplay GEAR_dialog_idc) displayCtrl _x) ctrlEnable true;
		((findDisplay GEAR_dialog_idc) displayCtrl (_x-1)) ctrlSetTextColor _color2;
	};
} count _buttons;