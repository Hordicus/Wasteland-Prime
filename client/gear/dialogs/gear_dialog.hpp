#include "common.hpp"
#include "gear_defines.sqf"

class geard {

	idd = GEAR_dialog_idc;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "execVM 'client\gear\init.sqf'";
	
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
	
	class GEAR_list : GEAR_common {
		type = CT_LISTBOX;
		style = ST_BACKGROUND;
		wholeHeight = 0.45;
		rowHeight = 0.045;
		maxHistoryDelay = 1;

		class ListScrollBar {
			color[] = {1, 1, 1, 1};
			colorActive[] = {1, 1, 1, 1};
			colorDisabled[] = {1, 1, 1, 1};
			thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
			arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
			arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
			border = "\ca\ui\data\ui_border_scroll_ca.paa";
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
		// style = ST_PICTURE; // ST_PICTURE
		colorBackground[] = {0,0,0,0.5};
		colorText[] = {1,1,1,1};
	};
	
	class GEAR_button : GEAR_common {
		type = CT_BUTTON;
		style = 0;
		
		default = false;
		colorFocused[] = {0,0,0,0.5};
		colorBackgroundActive[] = {1,1,1,1};
		
		colorBackgroundDisabled[] = {0,0,0,0.5};
		action = "";
		
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
		
		onMouseEnter = "[_this select 0, 1] execVM 'client\gear\rolloverChangeBg.sqf'";
		onMouseExit = "[_this select 0, 0] execVM 'client\gear\rolloverChangeBg.sqf'";
	};
	
	class GEAR_picture_btn : GEAR_common {
		type = CT_STATIC;
		style = 0; // ST_PICTURE
		colorBackground[] = {0,0,0,0.5};
		colorText[] = {1,1,1,1};
	};
	
	class GEAR_inv_slot : GEAR_picture_btn {
	
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
		};
		
		class GEAR_select_launchers : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_launchers_idc;
		};
		
		class GEAR_select_items : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 2 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_items_idc;
		};
		
		class GEAR_select_wearables : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 3 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_wearables_idc;
		};
		
		class GEAR_select_ammo : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_ammo_idc;
		};
		
		class GEAR_select_attachments : GEAR_button {
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;

			idc = GEAR_select_attachments_idc;
		};
	};

	class controls {
		
		// Left column
		class GEAR_select_guns_bg : GEAR_button_bg {
			idc = GEAR_select_guns_bg_idc;
			text = "D:\Docs\Arma 3 - Other Profiles\DJRanger\MPMissions\test.Chernarus\client\gear\icons\guns.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_launchers_bg : GEAR_button_bg {
			idc = GEAR_select_launchers_bg_idc;
			text = "D:\Docs\Arma 3 - Other Profiles\DJRanger\MPMissions\test.Chernarus\client\gear\icons\launchers.paa";

			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_items_bg : GEAR_button_bg {
			idc = GEAR_select_items_bg_idc;
			text = "D:\Docs\Arma 3 - Other Profiles\DJRanger\MPMissions\test.Chernarus\client\gear\icons\gear.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 2 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
				
		class GEAR_select_wearables_bg : GEAR_button_bg {
			idc = GEAR_select_wearables_bg_idc;
			text = "D:\Docs\Arma 3 - Other Profiles\DJRanger\MPMissions\test.Chernarus\client\gear\icons\wearables.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 3 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_itemslist : GEAR_list {
			idc = GEAR_itemslist_idc;

			x = safezoneX + (safezoneW * 0.05) + (safezoneW * 0.02);
			y = safezoneY + ( safezoneH * 0.01 );
			w = safezoneW * 0.26;
			h = safezoneH * 0.5;
		};
		
		class GEAR_select_ammo_bg : GEAR_button_bg {
			idc = GEAR_select_ammo_bg_idc;
			text = "D:\Docs\Arma 3 - Other Profiles\DJRanger\MPMissions\test.Chernarus\client\gear\icons\ammo.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_attachments_bg : GEAR_button_bg {
			idc = GEAR_select_attachments_bg_idc;
			text = "D:\Docs\Arma 3 - Other Profiles\DJRanger\MPMissions\test.Chernarus\client\gear\icons\attachments.paa";
			
			x = safezoneX + ( safezoneW * 0.02 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
				
		class GEAR_items_attachments_ammo : GEAR_list {
			idc = GEAR_items_attachments_ammo_idc;

			x = safezoneX + (safezoneW * 0.05) + (safezoneW * 0.02);
			y = safezoneY + ( safezoneH * 0.01 * 2 ) + (safezoneH * 0.5);
			w = safezoneW * 0.26;
			h = safezoneH * 0.47;
		};
		
		// Uniform
		class GEAR_select_uniform_bg : GEAR_button_bg {
			idc = GEAR_select_uniform_bg_idc;
			text = GEAR_uniform_icon;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 0);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_uniform : GEAR_select_uniform_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
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
		class GEAR_select_vest_bg : GEAR_button_bg {
			idc = GEAR_select_vest_bg_idc;
			text = GEAR_vest_icon;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 1);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_vest : GEAR_select_vest_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
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
		class GEAR_select_backpack_bg : GEAR_button_bg {
			idc = GEAR_select_backpack_bg_idc;
			text = GEAR_backpack_icon;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 2);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};

		class GEAR_select_backpack : GEAR_select_backpack_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
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

			x = safezoneX + (safezoneW * 0.35) + (safezoneW * 0.1 * 0);
			y = safezoneY + ( safezoneH * 0.12 );
			w = safezoneW * 0.26;
			h = safezoneH * 0.81;
		};
		
		// Helmet
		class GEAR_select_helmet_bg : GEAR_button_bg {
			idc = GEAR_select_helmet_bg_idc;
			text = GEAR_helmet_icon;
			
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 3);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_helmet : GEAR_select_helmet_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_select_helmet_idc;
		};
		
		// Glasses
		class GEAR_select_glasses_bg : GEAR_button_bg {
			idc = GEAR_select_glasses_bg_idc;
			text = GEAR_glasses_icon;
			
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 4);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_glasses : GEAR_select_glasses_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_select_glasses_idc;
		};
		
		// NVGs
		class GEAR_select_nvg_bg : GEAR_button_bg {
			idc = GEAR_select_nvg_bg_idc;
			text = GEAR_nvg_icon;
			
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 5);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_nvg : GEAR_select_nvg_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_select_nvg_idc;
		};
		
		// Binoculars
		class GEAR_select_binocular_bg : GEAR_button_bg {
			idc = GEAR_select_binocular_bg_idc;
			text = GEAR_binocular_icon;
			
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 6);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		class GEAR_select_binocular : GEAR_select_binocular_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_select_binocular_idc;
		};
		
		// Primary Weapon
		class GEAR_primary_bg : GEAR_button_bg {
			text = GEAR_primary_icon;
			y = safezoneY + ( safezoneH * 0.12 );
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 3);
			w = safezoneW * 0.35;
			h = safezoneH * 0.12;
			idc = GEAR_primary_idc;
		};
		
		class GEAR_primary : GEAR_primary_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};

		class GEAR_primary_muzzle_bg : GEAR_button_bg {
			text = GEAR_muzzle_icon;
			y = safezoneY + ( safezoneH * 0.12 ) + ( safezoneH * 0.12 + 0.005 ) * 1;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_primary_muzzle_bg_idc;
		};
		
		class GEAR_primary_muzzle : GEAR_primary_muzzle_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_primary_muzzle_idc;
		};
		
		class GEAR_primary_acc_bg : GEAR_button_bg {
			text = GEAR_acc_icon;
			y = safezoneY + ( safezoneH * 0.12 ) + ( safezoneH * 0.12 + 0.005 ) * 1;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*1);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_primary_acc_bg_idc;
		};
		
		class GEAR_primary_acc : GEAR_primary_acc_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_primary_acc_idc;
		};
		
		class GEAR_primary_optic_bg : GEAR_button_bg {
			text = GEAR_optic_icon;
			y = safezoneY + ( safezoneH * 0.12 ) + ( safezoneH * 0.12 + 0.005 ) * 1;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*2);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_primary_optic_bg_idc;
		};
		
		class GEAR_primary_optic : GEAR_primary_optic_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_primary_optic_idc;
		};
		
		class GEAR_primary_mag_bg : GEAR_button_bg {
			text = GEAR_mag_icon;
			y = safezoneY + ( safezoneH * 0.12 ) + ( safezoneH * 0.12 + 0.005 ) * 1;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*3);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_primary_mag_bg_idc;
		};
		
		class GEAR_primary_mag : GEAR_primary_mag_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_primary_mag_idc;
		};

		// Secondary
		class GEAR_secondary_bg : GEAR_button_bg {
			text = GEAR_secondary_icon;
			y = safezoneY + safezoneH * 0.3;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 3);
			w = safezoneW * 0.35;
			h = safezoneH * 0.12;
			idc = GEAR_secondary_bg_idc;			
		};
		
		class GEAR_secondary : GEAR_secondary_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_secondary_idc;
		};

		class GEAR_secondary_muzzle_bg : GEAR_button_bg {
			text = GEAR_muzzle_icon;
			y = safezoneY + safezoneH * 0.425;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_secondary_muzzle_bg_idc;
		};
		
		class GEAR_secondary_muzzle : GEAR_secondary_muzzle_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_secondary_muzzle_idc;
		};
		
		class GEAR_secondary_acc_bg : GEAR_button_bg {
			text = GEAR_acc_icon;
			y = safezoneY + safezoneH * 0.425;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*1);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_secondary_acc_bg_idc;
		};
		
		class GEAR_secondary_acc : GEAR_secondary_acc_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_secondary_acc_idc;
		};
		
		class GEAR_secondary_optic_bg : GEAR_button_bg {
			text = GEAR_optic_icon;
			y = safezoneY + safezoneH * 0.425;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*2);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_secondary_optic_bg_idc;
		};
		
		class GEAR_secondary_optic : GEAR_secondary_optic_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_secondary_optic_idc;
		};
		
		class GEAR_secondary_mag_bg : GEAR_button_bg {
			text = GEAR_mag_icon;
			y = safezoneY + safezoneH * 0.425;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*3);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_secondary_mag_bg_idc;
		};
		
		class GEAR_secondary_mag : GEAR_secondary_mag_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_secondary_mag_idc;
		};
		
		// Pistol
		class GEAR_pistol_bg : GEAR_button_bg {
			text = GEAR_pistol_icon;
			y = safezoneY + safezoneH * 0.48;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 ) * 3);
			w = safezoneW * 0.35;
			h = safezoneH * 0.12;
			idc = GEAR_pistol_bg_idc;
		};
		
		class GEAR_pistol : GEAR_pistol_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_pistol_idc;
		};

		class GEAR_pistol_muzzle_bg : GEAR_button_bg {
			text = GEAR_muzzle_icon;
			y = safezoneY + safezoneH * 0.605;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_pistol_muzzle_bg_idc;
		};
		
		class GEAR_pistol_muzzle : GEAR_pistol_muzzle_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_pistol_muzzle_idc;
		};
		
		class GEAR_pistol_acc_bg : GEAR_button_bg {
			text = GEAR_acc_icon;
			y = safezoneY + safezoneH * 0.605;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*1);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_pistol_acc_bg_idc;
		};
		
		class GEAR_pistol_acc : GEAR_pistol_acc_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_pistol_acc;
		};
		
		class GEAR_pistol_optic_bg : GEAR_button_bg {
			text = GEAR_optic_icon;
			y = safezoneY + safezoneH * 0.605;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*2);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_pistol_optic_bg_idc;
		};
		
		class GEAR_pistol_optic : GEAR_pistol_optic_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_pistol_optic_idc;
		};
		
		class GEAR_pistol_mag_bg : GEAR_button_bg {
			text = GEAR_mag_icon;
			y = safezoneY + safezoneH * 0.605;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*3);
			w = safezoneW * 0.08375;
			h = safezoneH * 0.045;
			idc = GEAR_pistol_mag_bg_idc;
		};
		
		class GEAR_pistol_mag : GEAR_pistol_mag_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_pistol_mag_idc;
		};		
		
		// Items (GPS/map/etc)
		class GEAR_item_map_bg : GEAR_button_bg {
			text = GEAR_map_icon;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_map_bg_idc;
		};
		
		class GEAR_item_map : GEAR_item_map_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_item_map_idc;
		};
		
		class GEAR_item_gps_bg : GEAR_button_bg {
			text = GEAR_gps_icon;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35 + (0.048 + 0.005) * 1);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_gps_bg_idc;
		};
		
		class GEAR_item_gps : GEAR_item_gps_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_item_gps_idc;
		};
		
		class GEAR_item_radio_bg : GEAR_button_bg {
			text = GEAR_radio_icon;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35 + (0.048 + 0.005) * 2);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_radio_bg_idc;
		};
		
		class GEAR_item_radio : GEAR_item_radio_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_item_radio_idc;
		};
		
		class GEAR_item_compass_bg : GEAR_button_bg {
			text = GEAR_compass_icon;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35 + (0.048 + 0.005) * 3);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_compass_bg_idc;
		};
		
		class GEAR_item_compass : GEAR_item_compass_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_item_compass_idc;
		};

		class GEAR_item_watch_bg : GEAR_button_bg {
			text = GEAR_watch_icon;
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.35 + (0.048 + 0.005) * 4);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
			idc = GEAR_item_watch_bg_idc;
		};
		
		class GEAR_item_watch : GEAR_item_watch_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
			idc = GEAR_item_watch_idc;
		};
		
		class GEAR_purchase_info_bg : GEAR_common {
			type = CT_STATIC;
			style = 0;
			y = safezoneY + safezoneH * 0.66;
			x = safezoneX + safezoneW * (0.36 + ( 0.01 + 0.08 )*3 + (0.08375 + 0.005)*0);
			w = safezoneW * 0.35;
			h = safezoneH * 0.33;
		};
	};
};