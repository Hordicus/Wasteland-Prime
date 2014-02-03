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
		rowHeight = 0.04;
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
	
	class GEAR_picture_btn : GEAR_common {
		type = CT_STATIC;
		style = ST_POS; // ST_PICTURE
		colorBackground[] = {1,1,1,1};
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
		
		class GEAR_select_guns : GEAR_picture_btn {
			idc = GEAR_select_guns_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.06) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.06;
		};
		
		class GEAR_select_launchers : GEAR_picture_btn {
			idc = GEAR_select_launchers_idc;

			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.06) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.06;
		};
		
		class GEAR_select_items : GEAR_picture_btn {
			idc = GEAR_select_items_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.06) + (safezoneH * 0.01)) * 2 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.06;
		};
		
		class GEAR_select_wearables : GEAR_picture_btn {
			idc = GEAR_select_wearables_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.01 ) + ( ((safezoneH * 0.06) + (safezoneH * 0.01)) * 3 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.06;
		};
		
		class GEAR_itemslist : GEAR_list {
			idc = GEAR_itemslist_idc;

			x = safezoneX + (safezoneW * 0.05) + (safezoneW * 0.01);
			y = safezoneY + ( safezoneH * 0.01 );
			w = safezoneW * 0.2;
			h = safezoneH * 0.5;
		};
		
		class GEAR_select_ammo : GEAR_picture_btn {
			idc = GEAR_select_ammo_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.06) + (safezoneH * 0.01)) * 0 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.06;
		};
		
		class GEAR_select_attachments : GEAR_picture_btn {
			idc = GEAR_select_attachments_idc;
			
			x = safezoneX + ( safezoneW * 0.01 );
			y = safezoneY + ( safezoneH * 0.52 ) + ( ((safezoneH * 0.06) + (safezoneH * 0.01)) * 1 );
			w = safezoneW * 0.05;
			h = safezoneH * 0.06;
		};
		
		class GEAR_items_attachments_ammo : GEAR_list {
			idc = GEAR_items_attachments_ammo_idc;

			x = safezoneX + (safezoneW * 0.05) + (safezoneW * 0.01);
			y = safezoneY + ( safezoneH * 0.01 * 2 ) + (safezoneH * 0.5);
			w = safezoneW * 0.2;
			h = safezoneH * 0.47;
		};
	};
};