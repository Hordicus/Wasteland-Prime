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
			y = safezoneY + safezoneH - (safezoneH * (0.07 + 0.01));
			
			w = safezoneW * 0.06;
			h = safezoneW * 0.07;
		};
		
		class vehicleInfo : RscStructuredText {
			idc = HUDvehicleInfoIDC;
			x = safezoneX + safezoneW - (safezoneW * (0.2 + 0.01));
			y = safezoneY + safezoneH * ( 0.01 );
			
			w = safezoneW * 0.2;
			h = safezoneW * 0.96;
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
	};
	
	class controls{};
};