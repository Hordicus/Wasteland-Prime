class BLLoadingScreen {
	idd = 6000;
	onLoad = "uiNamespace setVariable ['loadingScreen', _this select 0]; _this call BL_fnc_abortConfirm;";
	duration = 10e10;
	fadein = 0;
	fadeout = 0;
	name = "loading screen";

	class controlsBackground {
		class background : RscCommon {
			w = safezoneW;
			h = safezoneH;
			x = safezoneX;
			y = safezoneY;
			
			colorBackground[] = {0,0,0,1};
		};
		class noise : background {
			text = "\A3\Ui_f\data\GUI\Cfg\LoadingScreens\LoadingNoise_ca.paa";
			style = 48;
		};
	};
	
	class controls {
		class Title2 : RscText {
			idc = 101;
			style = ST_CENTER;
			text = "";
			w = safezoneW;
			h = safezoneH * 0.1;
			x = safezoneX;
			y = safezoneY + safezoneH * (0.5 - 0.1/2);
			
			colorBackground[] = {0,0,0,0.2};
		};
		
		class ProgressMap : RscProgress {
			idc = 104;
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			colorBar[] = {1,1,1,0.8};
			x = safezoneX;
			y = safezoneY + safezoneH * (0.5 + 0.1/2 - 0.01);
			w = safezoneW * 0.8;
			h = safezoneH * 0.01;
		};
	};
};