#include "dialogs\gear_defines.sqf"
disableSerialization;

_dialog = findDisplay GEAR_dialog_idc;

GEAR_activeNav = 'guns';
GEAR_activeSubNav = 'ammo';
GEAR_activeContainer = 'uniform';

if ( isNil "GEAR_showItems" ) then {
	GEAR_config            = compileFinal preprocessFileLineNumbers "client\gear\config.sqf";
	GEAR_itemName          = compileFinal preprocessFileLineNumbers "client\gear\fnc_itemName.sqf";
	GEAR_itemImg           = compileFinal preprocessFileLineNumbers "client\gear\fnc_itemImg.sqf";
	GEAR_getConfig         = compileFinal preprocessFileLineNumbers "client\gear\fnc_getConfig.sqf";
	GEAR_allowedSlots      = compileFinal preprocessFileLineNumbers "client\gear\fnc_allowedSlots.sqf";
	GEAR_getType           = compileFinal preprocessFileLineNumbers "client\gear\fnc_getType.sqf";
	GEAR_getConfigRoot     = compileFinal preprocessFileLineNumbers "client\gear\fnc_getConfigRoot.sqf";
	GEAR_updateDialogImgs  = compileFinal preprocessFileLineNumbers "client\gear\fnc_updateDialogImgs.sqf";
	GEAR_loadoutIndexToIDC = compileFinal preprocessFileLineNumbers "client\gear\fnc_loadoutIndexToIDC.sqf";
	GEAR_IDCToLoadoutIndex = compileFinal preprocessFileLineNumbers "client\gear\fnc_IDCToLoadoutIndex.sqf";
	GEAR_defaultImg        = compileFinal preprocessFileLineNumbers "client\gear\fnc_defaultImg.sqf";
	GEAR_selectContainer   = compileFinal preprocessFileLineNumbers "client\gear\fnc_selectContainer.sqf";
	GEAR_itemPrice         = compileFinal preprocessFileLineNumbers "client\gear\fnc_itemPrice.sqf";
	GEAR_getMass           = compileFinal preprocessFileLineNumbers "client\gear\fnc_getMass.sqf";
	GEAR_getMassCapacity   = compileFinal preprocessFileLineNumbers "client\gear\fnc_getMassCapacity.sqf";
	GEAR_getRowFromPos     = compileFinal preprocessFileLineNumbers "client\gear\fnc_getRowFromPos.sqf";
	GEAR_validAttachment   = compileFinal preprocessFileLineNumbers "client\gear\fnc_validAttachment.sqf";
	GEAR_getTotalMass      = compileFinal preprocessFileLineNumbers "client\gear\fnc_getTotalMass.sqf";
	GEAR_setLoadout        = compileFinal preprocessFileLineNumbers "client\gear\set_loadout.sqf"; // AUTHOR: aeroson
	GEAR_toLoadoutArray    = compileFinal preprocessFileLineNumbers "client\gear\fnc_toLoadoutArray.sqf";
	GEAR_loadoutTotal      = compileFinal preprocessFileLineNumbers "client\gear\fnc_loadoutTotal.sqf";
};

if ( isNil "GEAR_activeLoadout" ) then {
	GEAR_presets = profileNamespace getVariable ["GEAR_presets", [] call CBA_fnc_hashCreate];
	GEAR_activeLoadout = profileNamespace getVariable ["GEAR_activeLoadout", []];
};

call GEAR_updateDialogImgs;
GEAR_beforeChanges = GEAR_activeLoadout;

'guns' call compile preprocessFileLineNumbers 'client\gear\event_showItems.sqf';
call compile preprocessFileLineNumbers 'client\gear\event_updateTabs.sqf';
GEAR_activeContainer call GEAR_selectContainer;