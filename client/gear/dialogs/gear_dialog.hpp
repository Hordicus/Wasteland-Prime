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
	
	class GEAR_picture_bg : GEAR_common {
		type = CT_STATIC;
		style = ST_PICTURE + ST_KEEP_ASPECT_RATIO + ST_VCENTER; // ST_PICTURE
		// style = ST_PICTURE; // ST_PICTURE
		colorBackground[] = {0,0,0,0.5};
		colorText[] = {1,1,1,1};
	};

	class GEAR_picture_btn : GEAR_common {
		type = CT_STATIC;
		style = 0; // ST_PICTURE
		colorBackground[] = {0,0,0,0.5};
		colorText[] = {1,1,1,1};
	};
	
	class GEAR_inv_slot : GEAR_picture_btn {
	
	};

	class controls {
		class GEAR_background : GEAR_common {
			type = CT_STATIC;
			style = ST_POS;
			
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH;
		};
		
		// Left column
		class GEAR_select_guns : GEAR_picture_btn {
			idc = GEAR_select_guns_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_launchers : GEAR_picture_btn {
			idc = GEAR_select_launchers_idc;

			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_items : GEAR_picture_btn {
			idc = GEAR_select_items_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 2 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_wearables : GEAR_picture_btn {
			idc = GEAR_select_wearables_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 3 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_itemslist : GEAR_list {
			idc = GEAR_itemslist_idc;

			x = safezoneX + (safezoneW * 0.05) + (safezoneW * 0.01);
			y = safezoneY + ( safezoneH * 0.01 );
			w = safezoneW * 0.26;
			h = safezoneH * 0.5;
		};
		
		class GEAR_select_ammo : GEAR_picture_btn {
			idc = GEAR_select_ammo_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_select_attachments : GEAR_picture_btn {
			idc = GEAR_select_attachments_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.05625) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.05625;
		};
		
		class GEAR_items_attachments_ammo : GEAR_list {
			idc = GEAR_items_attachments_ammo_idc;

			x = safezoneX + (safezoneW * 0.05) + (safezoneW * 0.01);
			y = safezoneY + ( safezoneH * 0.01 * 2 ) + (safezoneH * 0.5);
			w = safezoneW * 0.26;
			h = safezoneH * 0.47;
		};
		
		// Uniform
		class GEAR_select_uniform : GEAR_picture_btn {
			idc = GEAR_select_uniform_idc;
			
			x = safezoneX + safezoneW * (0.34 + ( 0.01 + 0.08 ) * 0);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		// Uniform load
		class GEAR_uniform_load : GEAR_load {
			idc = GEAR_uniform_load_idc;
			
			x = safezoneX + safezoneW * (0.34 + ( 0.01 + 0.08 ) * 0);
			y = safezoneY + safezoneH * ( 0.01 + 0.08 );
			w = safezoneW * 0.08;
			h = safezoneH * 0.01;
		};
		
		// Vest
		class GEAR_select_vest : GEAR_picture_btn {
			idc = GEAR_select_vest_idc;
			
			x = safezoneX + safezoneW * (0.34 + ( 0.01 + 0.08 ) * 1);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		// Vest load
		class GEAR_vest_load : GEAR_load {
			idc = GEAR_vest_load_idc;
			
			x = safezoneX + safezoneW * (0.34 + ( 0.01 + 0.08 ) * 1);
			y = safezoneY + safezoneH * ( 0.01 + 0.08 );
			w = safezoneW * 0.08;
			h = safezoneH * 0.01;
		};
		
		// Backpack
		class GEAR_select_backpack : GEAR_picture_btn {
			idc = GEAR_select_backpack_idc;
			
			x = safezoneX + safezoneW * (0.34 + ( 0.01 + 0.08 ) * 2);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		// Backpack load
		class GEAR_backpack_load : GEAR_load {
			idc = GEAR_backpack_load_idc;
			
			x = safezoneX + safezoneW * (0.34 + ( 0.01 + 0.08 ) * 2);
			y = safezoneY + safezoneH * ( 0.01 + 0.08 );
			w = safezoneW * 0.08;
			h = safezoneH * 0.01;
		};
		
		class GEAR_selected_inv : GEAR_list {
			idc = GEAR_selected_inv_idc;

			x = safezoneX + (safezoneW * 0.34) + (safezoneW * 0.1 * 0);
			y = safezoneY + ( safezoneH * 0.12 );
			w = safezoneW * 0.26;
			h = safezoneH * 0.81;
		};
		
		// Helmet
		class GEAR_select_helmet : GEAR_picture_btn {
			// idc = GEAR_select_helmet_idc;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 3);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		// Glasses
		class GEAR_select_glasses : GEAR_picture_btn {
			// idc = GEAR_select_helmet_idc;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 4);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		// NVGs
		class GEAR_select_nvg : GEAR_picture_btn {
			// idc = GEAR_select_helmet_idc;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 5);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		// Binoculars
		class GEAR_select_binoculars : GEAR_picture_btn {
			// idc = GEAR_select_helmet_idc;
			
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 6);
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.08;
			h = safezoneH * 0.08;
		};
		
		// Primary Weapon
		class GEAR_primary_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_primary_gs.paa";
			y = safezoneY + ( safezoneH * 0.12 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 3);
			w = safezoneW * 0.26;
			h = safezoneH * 0.16;
		};
		
		class GEAR_primary : GEAR_primary_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};

		class GEAR_primary_muzzle_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + (0.16 + 0.005)*1 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*0);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_primary_muzzle : GEAR_primary_muzzle_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_primary_acc_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + (0.16 + 0.005)*1 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*1);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_primary_acc : GEAR_primary_acc_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_primary_optic_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + (0.16 + 0.005)*1 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*2);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_primary_optic : GEAR_primary_optic_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_primary_mag_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_magazine_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + (0.16 + 0.005)*1 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*3);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_primary_mag : GEAR_primary_mag_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};

		// Secondary
		class GEAR_secondary_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_secondary_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + (0.16 + 0.005 + 0.045 + 0.01)*1 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 3);
			w = safezoneW * 0.26;
			h = safezoneH * 0.16;
		};
		
		class GEAR_secondary : GEAR_secondary_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};

		class GEAR_secondary_muzzle_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + ( 0.16 + 0.005 + 0.045 + 0.01 + 0.16 + 0.005 ) );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*0);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_secondary_muzzle : GEAR_secondary_muzzle_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_secondary_acc_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + ( 0.16 + 0.005 + 0.045 + 0.01 + 0.16 + 0.005 ) );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*1);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_secondary_acc : GEAR_secondary_acc_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_secondary_optic_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + ( 0.16 + 0.005 + 0.045 + 0.01 + 0.16 + 0.005 ) );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*2);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_secondary_optic : GEAR_secondary_optic_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_secondary_mag_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_magazine_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + ( 0.16 + 0.005 + 0.045 + 0.01 + 0.16 + 0.005 ) );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*3);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_secondary_mag : GEAR_secondary_mag_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		// Pistol
		class GEAR_pistol_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_hgun_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + (0.16 + 0.005 + 0.045 + 0.01)*2 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 ) * 3);
			w = safezoneW * 0.26;
			h = safezoneH * 0.16;
		};
		
		class GEAR_pistol : GEAR_pistol_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};

		class GEAR_pistol_muzzle_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + 0.606 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*0);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_pistol_muzzle : GEAR_pistol_muzzle_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_pistol_acc_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + 0.606 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*1);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_pistol_acc : GEAR_pistol_acc_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_pistol_optic_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + 0.606 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*2);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_pistol_optic : GEAR_pistol_optic_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_pistol_mag_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_magazine_gs.paa";
			y = safezoneY + safezoneH * ( 0.12 + 0.606 );
			x = safezoneX + safezoneW * (0.35 + ( 0.01 + 0.08 )*3 + (0.06125 + 0.005)*3);
			w = safezoneW * 0.06125;
			h = safezoneH * 0.045;
		};
		
		class GEAR_pistol_mag : GEAR_pistol_mag_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};		
		
		// Items (GPS/map/etc)
		class GEAR_item_map_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_map_gs.paa";
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.34);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
		};
		
		class GEAR_item_map : GEAR_item_map_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_item_gps_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_gps_gs.paa";
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.34 + (0.048 + 0.005) * 1);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
		};
		
		class GEAR_item_gps : GEAR_item_gps_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_item_radio_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_radio_gs.paa";
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.34 + (0.048 + 0.005) * 2);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
		};
		
		class GEAR_item_radio : GEAR_item_radio_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
		
		class GEAR_item_compass_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_compass_gs.paa";
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.34 + (0.048 + 0.005) * 3);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
		};
		
		class GEAR_item_compass : GEAR_item_compass_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};

		class GEAR_item_watch_bg : GEAR_picture_bg {
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_watch_gs.paa";
			y = safezoneY + safezoneH * ( 0.99 - 0.048 );
			x = safezoneX + safezoneW * (0.34 + (0.048 + 0.005) * 4);
			w = safezoneW * 0.048;
			h = safezoneH * 0.048;
		};
		
		class GEAR_item_watch : GEAR_item_watch_bg {
			type = CT_STATIC;
			style = 0;
			text = "";
		};
	};
};