#include "dialogs\gear_defines.sqf"
disableSerialization;

_dialog = findDisplay GEAR_dialog_idc;
_uniform_load = _dialog displayCtrl GEAR_uniform_load_idc;
_vest_load = _dialog displayCtrl GEAR_vest_load_idc;
_backpack_load = _dialog displayCtrl GEAR_backpack_load_idc;

_uniform_load progressSetPosition (random 1);
_vest_load progressSetPosition (random 1);
_backpack_load progressSetPosition (random 1);

GEAR_activeNav = 'guns';
GEAR_activeSubNav = 'ammo';

if ( isNil "GEAR_showItems" ) then {
	GEAR_showItems       = compileFinal preprocessFileLineNumbers "client\gear\showItems.sqf";
	GEAR_config          = compileFinal preprocessFileLineNumbers "client\gear\config.sqf";
	GEAR_itemName        = compileFinal preprocessFileLineNumbers "client\gear\itemName.sqf";
	GEAR_itemImg         = compileFinal preprocessFileLineNumbers "client\gear\itemImg.sqf";
	GEAR_showItemDetails = compileFinal preprocessFileLineNumbers "client\gear\showItemDetails.sqf";
	GEAR_getConfig       = compileFinal preprocessFileLineNumbers "client\gear\getConfig.sqf";
	GEAR_updateTabs      = compileFinal preprocessFileLineNumbers "client\gear\updateTabs.sqf";
	GEAR_allowedSlots    = compileFinal preprocessFileLineNumbers "client\gear\allowedSlots.sqf";
	GEAR_getType         = compileFinal preprocessFileLineNumbers "client\gear\getType.sqf";
	GEAR_getConfigRoot   = compileFinal preprocessFileLineNumbers "client\gear\getConfigRoot.sqf";
};

GEAR_activeNav call GEAR_showItems;
call GEAR_updateTabs;