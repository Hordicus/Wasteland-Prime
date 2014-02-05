#include "dialogs\gear_defines.sqf"
disableSerialization;

_dialog = findDisplay GEAR_dialog_idc;
_uniform_load = _dialog displayCtrl GEAR_uniform_load_idc;
_vest_load = _dialog displayCtrl GEAR_vest_load_idc;
_backpack_load = _dialog displayCtrl GEAR_backpack_load_idc;
_primary_bg = _dialog displayCtrl GEAR_primary_bg_idc;
_secondary_bg = _dialog displayCtrl GEAR_secondary_bg_idc;
_pistol_bg = _dialog displayCtrl GEAR_pistol_bg_idc;

_uniform_load progressSetPosition (random 1);
_vest_load progressSetPosition (random 1);
_backpack_load progressSetPosition (random 1);

_primary_icon = getText (configFile >> "CfgWeapons" >> (primaryWeapon player) >> "picture");
_secondary_icon = getText (configFile >> "CfgWeapons" >> (secondaryWeapon player) >> "picture");
_pistol_icon = getText (configFile >> "CfgWeapons" >> (handgunWeapon player) >> "picture");

// _primary_bg ctrlSetText _primary_icon;
// _secondary_bg ctrlSetText _secondary_icon;
// _pistol_bg ctrlSetText _pistol_icon;

if ( isNil "GEAR_showItems" ) then {
	GEAR_showItems = compileFinal preprocessFileLineNumbers "client\gear\showItems.sqf";
	GEAR_config    = compileFinal preprocessFileLineNumbers "client\gear\config.sqf";
	GEAR_itemName  = compileFinal preprocessFileLineNumbers "client\gear\itemName.sqf";
};

'guns' call GEAR_showItems;