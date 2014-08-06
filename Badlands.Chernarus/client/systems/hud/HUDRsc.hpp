#include "functions\macro.sqf"
class HUDRsc {
	idd = -1;
	fadein = 0;
	fadeout = 0;
	duration = 99999999999999;
	onLoad = "uiNamespace setVariable ['HUD', _this select 0]";
	
	class controlsBackground {		
		class playerInfo : RscStructuredText {
			idc = HUDplayerInfoIDC;
			x = safezoneX + safezoneW - (safezoneW * (0.06 + 0.01));
			y = safezoneY + safezoneH - (safezoneH * (0.05 + 0.01));
			
			w = safezoneW * 0.06;
			h = safezoneW * 0.05;
		};
		
		class vehicleInfo : RscStructuredText {
			idc = HUDvehicleInfoIDC;
			x = safezoneX + safezoneW - (safezoneW * (0.2 + 0.01));
			y = safezoneY + safezoneH * ( 0.01 );
			
			w = safezoneW * 0.2;
			h = safezoneH * 0.90;
		};
		
		class serverInfo : RscStructuredText {
			idc = HUDserverInfoIDC;
			x = safezoneX + safezoneW * (0.01);
			y = safezoneY + safezoneH * (0.01);
			
			w = safezoneW * 0.5;
			h = safezoneW * 0.12;
		};
		
		class actionText : RscStructuredText {
			idc = HUDactionTextIDC;
			x = safezoneX;
			y = safezoneY + safezoneH/2;
			w = safezoneW;
			h = safezoneW * 0.1;
		};		

		class banner : RscCommon {
			colorBackground[] = {1,0,0,1};
			idc = HUDbannerIDC;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO + ST_LEFT;
			
			x = safezoneX + safezoneW * ( 0.5 - 0.2/2 );
			y = safezoneY + safezoneH * 0.01;
			w = safezoneW * 0.2;
			h = safezoneH * 0.2;
		};
	};
};