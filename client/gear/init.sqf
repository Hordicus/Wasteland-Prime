#include "dialogs\gear_defines.sqf"
disableSerialization;

_dialog = findDisplay GEAR_dialog_idc;

GEAR_activeNav = 'guns';
GEAR_activeSubNav = 'ammo';
GEAR_activeContainer = 'uniform';
GEAR_activeLoadout = [];

if ( isNil "GEAR_showItems" ) then {
	GEAR_showItems         = compileFinal preprocessFileLineNumbers "client\gear\showItems.sqf";
	GEAR_config            = compileFinal preprocessFileLineNumbers "client\gear\config.sqf";
	GEAR_itemName          = compileFinal preprocessFileLineNumbers "client\gear\itemName.sqf";
	GEAR_itemImg           = compileFinal preprocessFileLineNumbers "client\gear\itemImg.sqf";
	GEAR_showItemDetails   = compileFinal preprocessFileLineNumbers "client\gear\showItemDetails.sqf";
	GEAR_getConfig         = compileFinal preprocessFileLineNumbers "client\gear\getConfig.sqf";
	GEAR_updateTabs        = compileFinal preprocessFileLineNumbers "client\gear\updateTabs.sqf";
	GEAR_allowedSlots      = compileFinal preprocessFileLineNumbers "client\gear\allowedSlots.sqf";
	GEAR_getType           = compileFinal preprocessFileLineNumbers "client\gear\getType.sqf";
	GEAR_getConfigRoot     = compileFinal preprocessFileLineNumbers "client\gear\getConfigRoot.sqf";
	GEAR_updateDialogImgs  = compileFinal preprocessFileLineNumbers "client\gear\updateDialogImgs.sqf";
	GEAR_loadoutIndexToIDC = compileFinal preprocessFileLineNumbers "client\gear\loadoutIndexToIDC.sqf";
	GEAR_IDCToLoadoutIndex = compileFinal preprocessFileLineNumbers "client\gear\IDCToLoadoutIndex.sqf";
	GEAR_defaultImg        = compileFinal preprocessFileLineNumbers "client\gear\defaultImg.sqf";
	GEAR_selectContainer   = compileFinal preprocessFileLineNumbers "client\gear\selectContainer.sqf";
	GEAR_itemPrice         = compileFinal preprocessFileLineNumbers "client\gear\itemPrice.sqf";
	GEAR_getMass           = compileFinal preprocessFileLineNumbers "client\gear\getMass.sqf";
	GEAR_getMassCapacity   = compileFinal preprocessFileLineNumbers "client\gear\getMassCapacity.sqf";
	GEAR_getRowFromPos     = compileFinal preprocessFileLineNumbers "client\gear\getRowFromPos.sqf";
	GEAR_validAttachment   = compileFinal preprocessFileLineNumbers "client\gear\validAttachment.sqf";
};

GEAR_activeNav call GEAR_showItems;
call GEAR_updateTabs;
GEAR_activeContainer call GEAR_selectContainer;