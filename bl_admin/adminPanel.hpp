#include "styles.hpp"
#include "common.hpp"
#include "functions\macro.sqf"

class adminPanel {
	idd = -1;
	onLoad = "_this call compile preprocessFileLineNumbers 'bl_admin\event_onLoad.sqf'";
	
	class controlsBackground {};
	
	class controls {
		class paneOne : BLRscListBox {
			idc = paneOneIDC;
			w = safezoneW * (0.6/3);
			h = safezoneW * 0.8;
			x = safezoneX + safezoneW * ( 0.2 );
			y = safezoneY + safezoneH * ( 0.5 - 0.8/2 );
			
			onLBSelChanged = "_this call compile preprocessFileLineNumbers 'bl_admin\event_paneOneChange.sqf'";
		};
		
		class paneTwo : paneOne {
			idc = paneTwoIDC;
			x = safezoneX + safezoneW * ( 0.2 + (0.6/3) );
			
			onLBSelChanged = "_this call compile preprocessFileLineNumbers 'bl_admin\event_paneTwoChange.sqf'";
		};
		
		class paneThree : BLRscCommon {
			idc = paneThreeIDC;
			w = safezoneW * (0.6/3);
			h = safezoneW * 0.8;
			x = safezoneX + safezoneW * ( 0.2 + (0.6/3)*2 );
			y = safezoneY + safezoneH * ( 0.5 - 0.8/2 );
		};

		class infoText : BLRscStructuredText {
			idc = infoTextIDC;
			w = safezoneW * (0.6/3 - 0.02);
			h = safezoneW * 0.2;
			x = safezoneX + safezoneW * ( 0.2 + (0.6/3)*2 + 0.01);
			y = safezoneY + safezoneH * ( 0.5 - 0.8/2 + 0.01 );
		};
		
		// Ctrls for money
		class money : BLRscEdit {
			idc = moneyIDC;
		
			x = safezoneX + safezoneW * ( 0.2 + (0.6/3)*2 + 0.01 );
			w = safezoneW * (0.6/3 - 0.02);
			h = safezoneH * 0.03;
			y = safezoneY + safezoneH * ( 0.5 - 0.8/2 + 0.01 );
		};
		
		class buttonOne : BLRscButton {
			idc = buttonOneIDC;
			x = safezoneX + safezoneW * ( 0.2 + (0.6/3)*2 + 0.01 );
			y = 0;
			w = safezoneW * (0.6/3 - 0.02);
			h = safezoneH * 0.03;
		};
	};
};