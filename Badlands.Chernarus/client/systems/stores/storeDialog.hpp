#include "functions\macro.sqf"
class storeDialog {
	idd = storeDialogIDD;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "_this call compile preprocessFileLineNumbers 'client\systems\stores\event_onLoad.sqf';";
	
	class controlsBackground {
	};
	
	class controls {
		class storeCategories : RscCombo {
			idc = storeCategoriesIDC;
			w = safezoneW * (0.26);
			h = safezoneH * (0.03);
			x = safezoneX + safezoneW * (0.1);
			y = safezoneY + safezoneH * (0.1);
		};
	
		class storeItems : RscListBox {
			idc = storeItemsIDC;
			w = safezoneW * (0.26);
			h = safezoneH * (0.8 - 0.03);
			x = safezoneX + safezoneW * (0.1);
			y = safezoneY + safezoneH * (0.1 + 0.03);
		};
		
		class selectedItemInfo : RscStructuredText {
			idc = selectedItemInfoIDC;
			colorBackground[] = {0,0,0,0.5};
			w = safezoneW * (0.26);
			h = safezoneH * (0.49);
			x = safezoneX + safezoneW * (0.1 + 0.27);
			y = safezoneY + safezoneH * (0.1);
		};
		
		class itemBtnOne : RscButton {
			idc = itemBtnOneIDC;
			w = safezoneW * (0.26);
			h = safezoneH * (0.03);
			x = safezoneX + safezoneW * (0.1 + 0.27);
			y = safezoneY + safezoneH * (0.1 + 0.5);
			
			text = "Add To Cart";
		};
		
		class cart : storeItems {
			idc = cartIDC;
			h = safezoneH * (0.49);
			x = safezoneX + safezoneW * (0.1 + 0.27 + 0.27);
			y = safezoneY + safezoneH * (0.1);
		};
		
		class cartInfo : RscStructuredText {
			idc = cartInfoIDC;
			colorBackground[] = {0,0,0,0.5};
			w = safezoneW * (0.26);
			h = safezoneH * (0.28);
			x = safezoneX + safezoneW * (0.1 + 0.27 + 0.27);
			y = safezoneY + safezoneH * (0.1 + 0.5);
		};
		
		class purchase : RscButton {
			idc = purchaseIDC;
			w = safezoneW * (0.1);
			h = safezoneH * (0.03);
			x = safezoneX + safezoneW * (0.1 + 0.27 + 0.27);
			y = safezoneY + safezoneH * (0.1 + 0.5 + 0.28);
			
			text = "Purchase";
		};
		
		class cancel : purchase {
			x = safezoneX + safezoneW * (0.1 + 0.27 + 0.27 + 0.1 + 0.005);
			
			text = "Cancel";
			action = "closeDialog 0";
		};
	};
};