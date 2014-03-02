#include "common.hpp"
#include "functions\macro.sqf"

class GEAR_common {
	text = "";
	idc  = -1;
	colorBackground[] = {0,0,0,0.5};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.8};
	colorSelect[] = {1,1,1,1};
	soundSelect[] = {"", 0.1, 1};
	border = "#(argb,8,8,3)color(1,1,1,0)";
	font = FontM;
	sizeEx = 0.023;
};

class GEAR_button : GEAR_common {
	type = CT_BUTTON;
	style = 0;
	
	default = false;
	colorFocused[] = {0,0,0,0.5};
	colorBackgroundActive[] = {1,1,1,1};
	
	// colorBackground[] = {1,0,0,0.5};
	colorBackgroundDisabled[] = {1,1,1,1};
	action = "";
	sizeEx = 0.025;
	
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	borderSize = 0;
	
	soundEnter[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
	
	// Is there a better way?
	onMouseEnter = "(_this select 0) ctrlSetTextColor [0,0,0,1];";
	onMouseExit  = "(_this select 0) ctrlSetTextColor [1,1,1,1];";
};

class geard {

	idd = GEAR_dialog_idc;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "_this call compile preprocessFileLineNumbers 'gear\event_onLoad.sqf'";
	
	class GEAR_list : GEAR_common {
		type = CT_LISTBOX;
		style = ST_BACKGROUND;
		wholeHeight = 0.45;
		rowHeight = 0.045;
		maxHistoryDelay = 1;
		colorSelect[] = {0,0,0,1};
		colorSelect2[] = {0,0,0,1};
		
		class ListScrollBar {
			color[] = {1, 1, 1, 1};
			colorActive[] = {1, 1, 1, 1};
			colorDisabled[] = {1, 1, 1, 1};
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		};
	};

	class GEAR_load : GEAR_common {
		type = CT_PROGRESS;
		style = 0;
		colorFrame[] = {1,1,1,0.5};
		colorBar[] = {1,1,1,1};
		texture = "#(argb,8,8,3)color(1,1,1,1)";
	};
	
	class GEAR_button_bg : GEAR_common {
		type = CT_STATIC;
		style = ST_PICTURE + ST_KEEP_ASPECT_RATIO + ST_VCENTER; // ST_PICTURE
		colorBackground[] = {0,0,0,0.5};
		colorText[] = {1,1,1,1};
	};
	
	class GEAR_Item : GEAR_common {
		type = CT_ACTIVETEXT;
		style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
		onLBDrop = "_this call compile preprocessFileLineNumbers 'gear\event_dropItem.sqf'";
		onMouseButtonClick = "_this call compile preprocessFileLineNumbers 'gear\event_clickItem.sqf'";
		
		colorBackground[] = {0,0,0,0.5};
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		
		soundEnter[] = { "", 0, 1 };
		soundPush[] = { "", 0, 1 };
		soundClick[] = { "", 0, 1 };
		soundEscape[] = { "", 0, 1 };
	};
	
	class controlsBackground {
		class GEAR_background : GEAR_common {
			type = CT_STATIC;
			style = ST_POS;
			
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH;
		};
		
		class GEAR_select_guns : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_guns_idc;
			onMouseButtonClick = "'guns' call compile preprocessFileLineNumbers 'gear\event_showItems.sqf'; GEAR_activeNav = 'guns'; call compile preprocessFileLineNumbers 'gear\event_updateTabs.sqf';";
			onMouseEnter = "[_this select 0, 1, 'guns'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
			onMouseExit  = "[_this select 0, 0, 'guns'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
		};
		
		class GEAR_select_launchers : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_launchers_idc;
			onMouseButtonClick = "'launchers' call compile preprocessFileLineNumbers 'gear\event_showItems.sqf'; GEAR_activeNav = 'launchers'; call compile preprocessFileLineNumbers 'gear\event_updateTabs.sqf';";
			onMouseEnter = "[_this select 0, 1, 'launchers'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
			onMouseExit  = "[_this select 0, 0, 'launchers'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
		};
		
		class GEAR_select_items : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 2 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_items_idc;
			onMouseButtonClick = "'items' call compile preprocessFileLineNumbers 'gear\event_showItems.sqf'; GEAR_activeNav = 'items'; call compile preprocessFileLineNumbers 'gear\event_updateTabs.sqf';";
			onMouseEnter = "[_this select 0, 1, 'items'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
			onMouseExit  = "[_this select 0, 0, 'items'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";			
		};
		
		class GEAR_select_wearables : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 3 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_wearables_idc;
			onMouseButtonClick = "'wearables' call compile preprocessFileLineNumbers 'gear\event_showItems.sqf'; GEAR_activeNav = 'wearables'; call compile preprocessFileLineNumbers 'gear\event_updateTabs.sqf';";
			onMouseEnter = "[_this select 0, 1, 'wearables'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
			onMouseExit  = "[_this select 0, 0, 'wearables'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";			
		};
		
		class GEAR_select_presets : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 4 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_presets_idc;
			onMouseButtonClick = "'presets' call compile preprocessFileLineNumbers 'gear\event_showItems.sqf'; GEAR_activeNav = 'presets'; call compile preprocessFileLineNumbers 'gear\event_updateTabs.sqf';";
			onMouseEnter = "[_this select 0, 1, 'presets'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
			onMouseExit  = "[_this select 0, 0, 'presets'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";			
		};
		
		class GEAR_select_ammo : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_ammo_idc;
			onMouseButtonClick = "GEAR_activeSubNav = 'ammo'; call call compile preprocessFileLineNumbers 'gear\event_showItemDetails.sqf'; call compile preprocessFileLineNumbers 'gear\event_updateTabs.sqf';";
			onMouseEnter = "[_this select 0, 1, 'ammo'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
			onMouseExit  = "[_this select 0, 0, 'ammo'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
		};
		
		class GEAR_select_attachments : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_attachments_idc;
			onMouseButtonClick = "GEAR_activeSubNav = 'attachments'; call call compile preprocessFileLineNumbers 'gear\event_showItemDetails.sqf'; call compile preprocessFileLineNumbers 'gear\event_updateTabs.sqf';";
			onMouseEnter = "[_this select 0, 1, 'attachments'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
			onMouseExit  = "[_this select 0, 0, 'attachments'] call compile preprocessFileLineNumbers 'gear\event_rolloverChangeBg.sqf'";
		};
	};

	class controls {
		
		// Left column
		class GEAR_select_guns_bg : GEAR_button_bg {
			idc = GEAR_select_guns_bg_idc;
			text = "gear\icons\guns.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_launchers_bg : GEAR_button_bg {
			idc = GEAR_select_launchers_bg_idc;
			text = "gear\icons\launchers.paa";

			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_items_bg : GEAR_button_bg {
			idc = GEAR_select_items_bg_idc;
			text = "gear\icons\gear.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 2 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
				
		class GEAR_select_wearables_bg : GEAR_button_bg {
			idc = GEAR_select_wearables_bg_idc;
			text = "gear\icons\wearables.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 3 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_presets_bg : GEAR_button_bg {
			idc = GEAR_select_presets_bg_idc;
			text = "gear\icons\presets.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 4 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_itemslist : GEAR_list {
			idc = GEAR_itemslist_idc;
			canDrag = 1;

			x = safezoneX + (safezoneW * 0.05) + (safezoneW * 0.02);
			y = safezoneY + ( safezoneH * 0.01 );
			w = safezoneW * 0.26;
			h = safezoneH * 0.5;
			onLBSelChanged = "call call compile preprocessFileLineNumbers 'gear\event_showItemDetails.sqf'";
			onLBDblClick = "_this call compile preprocessFileLineNumbers 'gear\event_dblClick.sqf';";
			onMouseButtonClick = "_this call compile preprocessFileLineNumbers 'gear\event_clickItem.sqf'";
		};
		
		class GEAR_select_ammo_bg : GEAR_button_bg {
			idc = GEAR_select_ammo_bg_idc;
			text = "gear\icons\ammo.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_attachments_bg : GEAR_button_bg {
			idc = GEAR_select_attachments_bg_idc;
			text = "gear\icons\attachments.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
				
		class GEAR_items_attachments_ammo : GEAR_list {
			idc = GEAR_items_attachments_ammo_idc;
			onLBDblClick = "_this call compile preprocessFileLineNumbers 'gear\event_dblClick.sqf';";
			canDrag = 1;

			x = safezoneX + (safezoneW * 0.05) + (safezoneW * 0.02);
			y = safezoneY + ( safezoneH * 0.01 * 2 ) + (safezoneH * 0.5);
			w = safezoneW * 0.26;
			h = safezoneH * 0.47;
		};
		
		// Uniform
		class GEAR_select_uniform_bg : GEAR_Item {
			idc = GEAR_select_uniform_bg_idc;
			type = CT_STATIC;
			style = 0;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 0);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_uniform : GEAR_select_uniform_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_uniform_icon;
			idc = GEAR_select_uniform_idc;
		};
		
		// Uniform load
		class GEAR_uniform_load : GEAR_load {
			idc = GEAR_uniform_load_idc;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 0);
			y = safezoneY + safezoneH * ( 0.01 + 0.08 );
			w = safezoneW * 0.08;
			h = safezoneH * 0.01;
		};
		
		// Vest
		class GEAR_select_vest_bg : GEAR_Item {
			idc = GEAR_select_vest_bg_idc;
			type = CT_STATIC;
			style = 0;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 1);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_vest : GEAR_select_vest_bg {
			text = GEAR_vest_icon;
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			idc = GEAR_select_vest_idc;
		};
		
		// Vest load
		class GEAR_vest_load : GEAR_load {
			idc = GEAR_vest_load_idc;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 1);
			y = safezoneY + safezoneH * ( 0.01 + 0.08 );
			w = safezoneW * 0.08;
			h = safezoneH * 0.01;
		};
		
		// Backpack
		class GEAR_select_backpack_bg : GEAR_Item {
			idc = GEAR_select_backpack_bg_idc;
			type = CT_STATIC;
			style = 0;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 2);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};

		class GEAR_select_backpack : GEAR_select_backpack_bg {
			text = GEAR_backpack_icon;
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			idc = GEAR_select_backpack_idc;
		};
		
		// Backpack load
		class GEAR_backpack_load : GEAR_load {
			idc = GEAR_backpack_load_idc;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 2);
			y = safezoneY + safezoneH * ( 0.01 + 0.08 );
			w = safezoneW * 0.08;
			h = safezoneH * 0.01;
		};
		
		class GEAR_selected_inv : GEAR_list {
			idc = GEAR_selected_inv_idc;
			onLBDrop = "_this call compile preprocessFileLineNumbers 'gear\event_dropItem.sqf'";
			onMouseButtonClick = "_this call compile preprocessFileLineNumbers 'gear\event_clickItem.sqf'";

			x = safezoneX + (safezoneW * 0.35) + (safezoneW * 0.1 * 0);
			y = safezoneY + ( safezoneH * 0.12 );
			w = safezoneW * 0.26;
			h = safezoneH * 0.81;
		};
		
		// Helmet
		class GEAR_select_helmet_bg : GEAR_Item {
			idc = GEAR_select_helmet_bg_idc;
			type = CT_STATIC;
			style = 0;
			
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 3);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_helmet : GEAR_select_helmet_bg {
			text = GEAR_helmet_icon;
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			idc = GEAR_select_helmet_idc;
		};
		
		// Glasses
		class GEAR_select_glasses_bg : GEAR_Item {
			idc = GEAR_select_glasses_bg_idc;
			type = CT_STATIC;
			style = 0;

			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 4);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_glasses : GEAR_select_glasses_bg {
			text = GEAR_glasses_icon;
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			idc = GEAR_select_glasses_idc;
		};
		
		// NVGs
		class GEAR_select_nvg_bg : GEAR_Item {
			idc = GEAR_select_nvg_bg_idc;
			type = CT_STATIC;
			style = 0;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 5);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_nvg : GEAR_select_nvg_bg {
			text = GEAR_nvg_icon;
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			idc = GEAR_select_nvg_idc;
		};
		
		// Binoculars
		class GEAR_select_binocular_bg : GEAR_Item {
			idc = GEAR_select_binocular_bg_idc;
			type = CT_STATIC;
			style = 0;
			
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 6);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_binocular : GEAR_select_binocular_bg {
			text = GEAR_binocular_icon;
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			idc = GEAR_select_binocular_idc;
		};
		
		// Primary Weapon
		class GEAR_primary_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + ( safezoneH * 0.12 );
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 3);
			w = safezoneW * 0.35;
			h = safezoneH * 0.12;
			idc = GEAR_primary_bg_idc;
		};
		
		class GEAR_primary : GEAR_primary_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_primary_icon;
			idc = GEAR_primary_idc;
		};

		class GEAR_primary_muzzle_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + ( safezoneH * 0.12 ) + ( safezoneH * 0.12 + 0.005 ) * 1;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_primary_muzzle_bg_idc;
		};
		
		class GEAR_primary_muzzle : GEAR_primary_muzzle_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_muzzle_icon;
			idc = GEAR_primary_muzzle_idc;
		};
		
		class GEAR_primary_acc_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + ( safezoneH * 0.12 ) + ( safezoneH * 0.12 + 0.005 ) * 1;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*1);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_primary_acc_bg_idc;
		};
		
		class GEAR_primary_acc : GEAR_primary_acc_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_acc_icon;
			idc = GEAR_primary_acc_idc;
		};
		
		class GEAR_primary_optic_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + ( safezoneH * 0.12 ) + ( safezoneH * 0.12 + 0.005 ) * 1;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*2);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_primary_optic_bg_idc;
		};
		
		class GEAR_primary_optic : GEAR_primary_optic_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_optic_icon;
			idc = GEAR_primary_optic_idc;
		};
		
		class GEAR_primary_mag_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + ( safezoneH * 0.12 ) + ( safezoneH * 0.12 + 0.005 ) * 1;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*3);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_primary_mag_bg_idc;
		};
		
		class GEAR_primary_mag : GEAR_primary_mag_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_mag_icon;
			idc = GEAR_primary_mag_idc;
		};

		// Secondary
		class GEAR_secondary_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.3;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 3);
			w = safezoneW * 0.35;
			h = safezoneH * 0.12;
			idc = GEAR_secondary_bg_idc;			
		};
		
		class GEAR_secondary : GEAR_secondary_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_secondary_icon;
			idc = GEAR_secondary_idc;
		};

		class GEAR_secondary_muzzle_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.425;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_secondary_muzzle_bg_idc;
		};
		
		class GEAR_secondary_muzzle : GEAR_secondary_muzzle_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_muzzle_icon;
			idc = GEAR_secondary_muzzle_idc;
		};
		
		class GEAR_secondary_acc_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.425;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*1);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_secondary_acc_bg_idc;
		};
		
		class GEAR_secondary_acc : GEAR_secondary_acc_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_acc_icon;
			idc = GEAR_secondary_acc_idc;
		};
		
		class GEAR_secondary_optic_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.425;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*2);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_secondary_optic_bg_idc;
		};
		
		class GEAR_secondary_optic : GEAR_secondary_optic_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_optic_icon;
			idc = GEAR_secondary_optic_idc;
		};
		
		class GEAR_secondary_mag_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.425;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*3);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_secondary_mag_bg_idc;
		};
		
		class GEAR_secondary_mag : GEAR_secondary_mag_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_mag_icon;
			idc = GEAR_secondary_mag_idc;
		};
		
		// Pistol
		class GEAR_pistol_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.48;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 3);
			w = safezoneW * 0.35;
			h = safezoneH * 0.12;
			idc = GEAR_pistol_bg_idc;
		};
		
		class GEAR_pistol : GEAR_pistol_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_pistol_icon;
			idc = GEAR_pistol_idc;
		};

		class GEAR_pistol_muzzle_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.605;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_pistol_muzzle_bg_idc;
		};
		
		class GEAR_pistol_muzzle : GEAR_pistol_muzzle_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_muzzle_icon;
			idc = GEAR_pistol_muzzle_idc;
		};
		
		class GEAR_pistol_acc_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.605;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*1);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_pistol_acc_bg_idc;
		};
		
		class GEAR_pistol_acc : GEAR_pistol_acc_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_acc_icon;
			idc = GEAR_pistol_acc;
		};
		
		class GEAR_pistol_optic_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.605;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*2);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_pistol_optic_bg_idc;
		};
		
		class GEAR_pistol_optic : GEAR_pistol_optic_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_optic_icon;
			idc = GEAR_pistol_optic_idc;
		};
		
		class GEAR_pistol_mag_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.605;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*3);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_pistol_mag_bg_idc;
		};
		
		class GEAR_pistol_mag : GEAR_pistol_mag_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_mag_icon;
			idc = GEAR_pistol_mag_idc;
		};		
		
		// Items (GPS/map/etc)
		class GEAR_item_map_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_map_bg_idc;
		};
		
		class GEAR_item_map : GEAR_item_map_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_map_icon;
			idc = GEAR_item_map_idc;
		};
		
		class GEAR_item_gps_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35 + (0.048 + 0.005) * 1);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_gps_bg_idc;
		};
		
		class GEAR_item_gps : GEAR_item_gps_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_gps_icon;
			idc = GEAR_item_gps_idc;
		};
		
		class GEAR_item_radio_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35 + (0.048 + 0.005) * 2);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_radio_bg_idc;
		};
		
		class GEAR_item_radio : GEAR_item_radio_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_radio_icon;
			idc = GEAR_item_radio_idc;
		};
		
		class GEAR_item_compass_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35 + (0.048 + 0.005) * 3);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_compass_bg_idc;
		};
		
		class GEAR_item_compass : GEAR_item_compass_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_compass_icon;
			idc = GEAR_item_compass_idc;
		};

		class GEAR_item_watch_bg : GEAR_Item {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35 + (0.048 + 0.005) * 4);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_watch_bg_idc;
		};
		
		class GEAR_item_watch : GEAR_item_watch_bg {
			type = CT_ACTIVETEXT;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			text = GEAR_watch_icon;
			idc = GEAR_item_watch_idc;
		};
		
		class GEAR_purchase_info : GEAR_common {
			y = safezoneY + safezoneH * 0.66;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0);
			w = safezoneW * 0.35;
			h = safezoneH * 0.33;

			type = CT_STRUCTURED_TEXT;
			style = 0;
			idc = GEAR_purchase_info_idc;
			size = 0.03;
		};
		
		class GEAR_save_loadout : GEAR_button {
			y = safezoneY + safezoneH * 0.905;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0 + 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;

			idc = GEAR_save_loadout_idc;
			text = "SAVE LOADOUT";
			action = "call compile preprocessFileLineNumbers 'gear\event_saveLoadout.sqf'";
		};
		
		class GEAR_save_as_preset : GEAR_button {
			y = safezoneY + safezoneH * 0.94;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0 + 0.01);
			w = safezoneW * 0.1;
			h = safezoneH * 0.03;

			idc = GEAR_save_preset_idc;
			text = "SAVE AS PRESET";
			action = "createDialog 'gear_name_presetd';";
		};
	};
};

class gear_name_presetd {
	idd = -1;
	class controlsBackground {
		class background : GEAR_common {
			colorBackground[] = {0,0,0,1};
			type = CT_FRAME;
			style = 0;
			
			y = safeZoneY + safezoneH * (0.5 - 0.12/2);
			x = safeZoneX + safezoneW * (0.5 - 0.3/2);
			h = safezoneH * 0.12;
			w = safezoneW * 0.3;
		};
	};
	
	class controls {
		class GEAR_preset_name_label : GEAR_common {
			type = CT_STATIC;
			style = 0;
			y = safeZoneY + safezoneH * (0.5 - 0.12/2 + 0.01);
			x = safeZoneX + safezoneW * (0.5 - 0.3/2 + 0.01);
			w = safezoneW * 0.2;
			h = safezoneH * 0.02;
			
			text = "Preset Name:";
		};

		class GEAR_preset_name : GEAR_common {
			type = CT_EDIT;
			style = 0;
			colorSelection[] = {0,0,0,1};
			autocomplete = "";
			idc = GEAR_preset_name_idc;
			
			y = safeZoneY + safezoneH * (0.5 - 0.12/2 + 0.035);
			x = safeZoneX + safezoneW * (0.5 - 0.3/2 + 0.01);
			w = safezoneW * 0.28;
			h = safezoneH * 0.02;
		};

		class GEAR_preset_name_help : GEAR_common {
			type = CT_STRUCTURED_TEXT;
			style = 0;
			
			y = safeZoneY + safezoneH * (0.5 - 0.12/2 + 0.035 + 0.03);
			x = safeZoneX + safezoneW * (0.5 - 0.3/2 + 0.01);
			w = safezoneW * 0.28;
			h = safezoneH * 0.03;
			
			size = 0.023;
			text = "Use the name of an existing preset to overwrite it.<br />Using a new name will add another preset.";
		};
		
		class GEAR_preset_save : GEAR_button {
			colorBackground[] = {0,0,0,1};
			y = safeZoneY + safezoneH * (0.5 - 0.12/2 + 0.12 + 0.005);
			x = safeZoneX + safezoneW * (0.5 - 0.3/2);
			h = safezoneH * 0.03;
			w = safezoneW * 0.1;
			
			text = "SAVE";
			action = "_this call compile preprocessFileLineNumbers 'gear\event_saveAsPreset.sqf'";
		};
		
		class GEAR_preset_cancel : GEAR_preset_save {
			x = safeZoneX + safezoneW * (0.5 - 0.3/2 + 0.005 + 0.1);
			text = "CANCEL";
			action = "closeDialog 0";
		};
	};
};