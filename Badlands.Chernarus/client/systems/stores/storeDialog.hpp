#include "functions\macro.sqf"
class storeDialog {
	idd = storeDialogIDD;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "_this call compile preprocessFileLineNumbers 'client\systems\stores\event_onLoad.sqf';";
	
	class controlsBackground {
		class storeTitle : RscCommon {
			idc = storeTitleIDC;
			w = safezoneW * (0.8);
			h = safezoneH * (0.05);
			x = safezoneX + safezoneW * (0.1);
			y = safezoneY + safezoneH * (0.1);
			
			text = "Store Title";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2);
			colorBackground[] = {0,0,0,1};
		};
	};
	
	class controls {
		class storeCategories : RscCombo {
			idc = storeCategoriesIDC;
			w = safezoneW * (0.26);
			h = safezoneH * (0.03);
			x = safezoneX + safezoneW * (0.1);
			y = safezoneY + safezoneH * (0.16);
			
			onLbSelChanged = "_this call compile preprocessFileLineNumbers 'client\systems\stores\event_onCatChange.sqf'";
		};
	
		class storeItems : RscListBox {
			idc = storeItemsIDC;
			w = safezoneW * (0.26);
			h = safezoneH * (0.75 - 0.03);
			x = safezoneX + safezoneW * (0.1);
			y = safezoneY + safezoneH * (0.16 + 0.03);

			onLbSelChanged = "_this call compile preprocessFileLineNumbers 'client\systems\stores\event_onItemSelected.sqf'";
		};
		
		class selectedItemInfo : RscStructuredText {
			idc = selectedItemInfoIDC;
			colorBackground[] = {0,0,0,0.5};
			w = safezoneW * (0.26);
			h = safezoneH * (0.44);
			x = safezoneX + safezoneW * (0.1 + 0.27);
			y = safezoneY + safezoneH * (0.16);
		};
		
		class addRemoveBtn : RscButton {
			idc = addRemoveBtnIDC;
			w = safezoneW * (0.26);
			h = safezoneH * (0.03);
			x = safezoneX + safezoneW * (0.1 + 0.27);
			y = safezoneY + safezoneH * (0.16 + 0.45);
			
			text = "Add To Cart";
			action = "_this call compile preprocessFileLineNumbers 'client\systems\stores\event_addRemoveItem.sqf'";
		};
		
		class cart : storeItems {
			idc = cartIDC;
			h = safezoneH * (0.44);
			x = safezoneX + safezoneW * (0.1 + 0.27 + 0.27);
			y = safezoneY + safezoneH * (0.16);
		};
		
		class cartInfo : RscStructuredText {
			idc = cartInfoIDC;
			colorBackground[] = {0,0,0,0.5};
			w = safezoneW * (0.26);
			h = safezoneH * (0.28);
			x = safezoneX + safezoneW * (0.1 + 0.27 + 0.27);
			y = safezoneY + safezoneH * (0.16 + 0.45);
		};
		
		class purchase : RscButton {
			idc = purchaseIDC;
			w = safezoneW * (0.1);
			h = safezoneH * (0.03);
			x = safezoneX + safezoneW * (0.1 + 0.27 + 0.27);
			y = safezoneY + safezoneH * (0.16 + 0.45 + 0.28);
			
			text = "Purchase";
			action = "_this call compile preprocessFileLineNumbers 'client\systems\stores\event_clickPurchase.sqf'";
		};
		
		class cancel : purchase {
			x = safezoneX + safezoneW * (0.1 + 0.27 + 0.27 + 0.1 + 0.005);
			
			text = "Cancel";
			action = "closeDialog 0";
		};
	};
};