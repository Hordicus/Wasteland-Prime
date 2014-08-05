class abortConfirm {
	idd = -1;
	onLoad = "uiNamespace setVariable ['abortConfirm', _this select 0];";
	class controls {
		class AbortHeader : RscCommon {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			w = safezoneW * 0.3;
			h = safezoneH * 0.02;
			x = safezoneX + safezoneW * ( 0.5 - 0.3/2 );
			y = safezoneY + safezoneH * ( 0.5 - 0.1/2 - 0.001 - 0.02 );
		};
		
		class AbortBackground : RscCommon {
			colorBackground[] = {0,0,0,1};
			w = safezoneW * 0.3;
			h = safezoneH * 0.1;
			x = safezoneX + safezoneW * ( 0.5 - 0.3/2 );
			y = safezoneY + safezoneH * ( 0.5 - 0.1/2 );
		};

		class AbortText : RscCommon {
			text = "You will be returned to lobby. Are you sure?";
			w = safezoneW * 0.28;
			h = safezoneH * 0.08;
			x = safezoneX + safezoneW * ( 0.5 - 0.28/2 );
			y = safezoneY + safezoneH * ( 0.5 - 0.08/2 );
		};

		class AbortYes : RscButton {
			text = "YES";
			action = "endMission 'FAILED';";
			
			w = safezoneW * 0.1;
			h = safezoneH * 0.02;
			x = safezoneX + safezoneW * ( 0.5 - 0.3/2 );
			y = safezoneY + safezoneH * ( 0.5 + 0.1/2 + 0.001 );
		};

		class AbortNo : AbortYes  {
			text = "NO";
			action = "closeDialog 0";
			
			x = safezoneX + safezoneW * ( 0.5 + 0.3/2 - 0.1 );
		};	
	};
};
