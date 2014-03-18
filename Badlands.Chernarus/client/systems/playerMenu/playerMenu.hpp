#include "functions\macro.sqf"
#define DIALOG_W 0.6
#define DIALOG_H 0.7

class playerMenuDialog {
	idd = playerMenuDialogIDD;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "_this call compile preprocessFileLineNumbers 'client\systems\playerMenu\event_onLoad.sqf';";
	
	class controlsBackground {
		class background : RscCommon {
			w = safezoneW * DIALOG_W;
			h = safezoneH * DIALOG_H;
			x = safezoneX + safezoneW * ( 0.5 - DIALOG_W/2 );
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 );
		};
	};
	
	class controls {
		class infoText : RscStructuredText {
			idc = infoTextIDC;
			w = safezoneW * 0.2;
			h = safezoneH * 0.135;
			
			x = safezoneX + safezoneW * ( 0.5 - DIALOG_W/2 + 0.01 );
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 );
		};
		
		class manageLoadouts : RscButton {
			text = "Manage Loadouts";
			action = "createDialog 'geard';";
			w = safezoneW * 0.2;
			h = safezoneH * 0.03;

			x = safezoneX + safezoneW * ( (0.5 - DIALOG_W/2) + 0.01 );
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.01 + 0.135 + 0.005 );
		};
		
		class flipVehicle : manageLoadouts {
			text = "Flip Vehicle";
			action = "[] call BL_fnc_flipVehicle;";
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.01 + 0.135 + 0.005 + (0.03 + 0.005) * 1);
		};
		
		class dropMoney : manageLoadouts {
			text = "Drop Money";
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.01 + 0.135 + 0.005 + (0.03 + 0.005) * 2);
			w = safezoneW * 0.1;
		};
		
		class dropMoneyAmount : RscEdit {
			w = safezoneW * (0.1 - 0.005);
			h = safezoneH * 0.03;
			x = safezoneX + safezoneW * ( (0.5 - DIALOG_W/2) + 0.01 + 0.1 + 0.005 );
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.01 + 0.135	 + 0.005 + (0.03 + 0.005) * 2);
			idc = dropMoneyAmountIDC;
		};
		
		// class somethingOne : manageLoadouts {
		// 	text = "Flip Vehicle";
		// 	y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.01 + 0.135 + 0.005 + (0.03 + 0.005) * 3);
		// };
		// 
		// class somethingTwo : manageLoadouts {
		// 	text = "Flip Vehicle";
		// 	y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.01 + 0.135 + 0.005 + (0.03 + 0.005) * 4);
		// };
		
		// View distance
		// Labels
		#define viewDistW (0.4 - 0.03)
		class viewDist : RscCommon {
			text = "View Distance";
			colorBackground[] = {0,0,0,1};
			
			w = safezoneW * viewDistW;
			h = safezoneH * 0.03;
			
			x = safezoneX + safezoneW * ( 0.5 + DIALOG_W/2 - 0.01 - viewDistW );
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 );
		};
		
		class viewDistFoot : viewDist {
			colorBackground[] = {0,0,0,0};
			text = "On Foot:";
			w = safezoneW * (viewDistW * 0.15);
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + ( 0.03 + 0.005 ) * 1);
		};
		
		class viewDistCar : viewDistFoot {
			text = "In Car:";
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + ( 0.03 + 0.005 ) * 2);
		};
		
		class viewDistAir : viewDistFoot {
			text = "In Air:";
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + ( 0.03 + 0.005 ) * 3);
		};
		
		// Sliders
		class viewDistFootSlider : RscXSliderH {
			w = safezoneW * (viewDistW * 0.65);
			h = safezoneH * 0.03;
			
			x = safezoneX + safezoneW * ( 0.5 + DIALOG_W/2 - 0.01 - viewDistW + (viewDistW * 0.15) + 0.005 );
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + ( 0.03 + 0.005 ) * 1);
			colorBackground[] = {0,0,1,0.2};
			idc = footViewDistanceIDC;
			onSliderPosChanged = "_this call compile preprocessFileLineNumbers 'client\systems\playerMenu\event_viewDistChange.sqf'";
		};
		
		class viewDistCarSlider : viewDistFootSlider {
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + ( 0.03 + 0.005 ) * 2);
			idc = carViewDistanceIDC;
		};
		
		class viewDistAirSlider : viewDistFootSlider {
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + ( 0.03 + 0.005 ) * 3);
			idc = airViewDistanceIDC;
		};
		
		// Slider values
		class viewDistFootValue : viewDistFoot {
			style = ST_RIGHT;
			w = safezoneW * (viewDistW * 0.2 - 0.005);
			x = safezoneX + safezoneW * ( 0.5 + DIALOG_W/2 - 0.01 - (viewDistW * 0.2) + 0.005 );
			text = "500m";
			idc = footViewDistanceValueIDC;
		};
		
		class viewDistCarValue : viewDistFootValue {
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + ( 0.03 + 0.005 ) * 2);
			idc = carViewDistanceValueIDC;
		};
		
		class viewDistAirValue : viewDistFootValue {
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + ( 0.03 + 0.005 ) * 3);
			idc = airViewDistanceValueIDC;
		};
		
		// "Inventory"
		class playerInventory : RscListBox {
			w = safezoneW * 0.2;
			h = safezoneH * 0.15;
			
			x = safezoneX + safezoneW * ( 0.5 + DIALOG_W/2 - 0.01 - 0.2 );
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + 0.135 + 0.005);
			idc = playerInventoryIDC;
			rowHeight = 0.03;
		};
		
		class playerInvUse : RscButton {
			w = safezoneW * 0.05;
			h = safezoneH * 0.02;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);

			x = safezoneX + safezoneW * ( 0.5 + DIALOG_W/2 - 0.01 - 0.2 );
			y = safezoneY + safezoneH * ( 0.5 - DIALOG_H/2 + 0.01 + 0.135 + 0.005 + 0.15);
			text = "Use";
		};
		
		class playerInvDrop : playerInvUse {
			text = "Drop";
			x = safezoneX + safezoneW * ( 0.5 + DIALOG_W/2 - 0.01 - 0.2 + 0.005 + 0.05 );
		};
		
		class groupManagement : RscCommon {
			text = "Group Management";
			w = safezoneW * ( DIALOG_W - 0.02 );
			h = safezoneH * 0.03;
			x = safezoneX + safezoneW * ( (0.5 - DIALOG_W/2) + 0.01 );
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.01 + 0.135 + 0.005 + (0.03 + 0.005) * 5 + 0.01 );
			colorBackground[] = {0,0,0,1};
		};
		
		class allPlayers : RscListBox {
			w = safezoneW * 0.2;
			h = safezoneH * 0.32;
			x = safezoneX + safezoneW * ( (0.5 - DIALOG_W/2) + 0.01 );
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.01 + 0.135 + 0.005 + (0.03 + 0.005) * 5 + 0.01 + 0.03 + 0.005 );
			idc = allPlayersIDC;
			onLBSelChanged = "call compile preprocessFileLineNumbers 'client\systems\playerMenu\event_playerLBChanged.sqf'";
		};
		
		class groupPlayers : allPlayers {
			x = safezoneX + safezoneW * ( 0.5 + DIALOG_W/2 - 0.01 - 0.2 );
			idc = groupPlayersIDC;
		};
		
		class groupBtn1 : RscButton {
			text = "Button One";
			w = safezoneW * 0.17;
			h = safezoneH * 0.03;

			x = safezoneX + safezoneW * ( (0.5 - DIALOG_W/2) + 0.01 + 0.2 + 0.005 );
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.37 );
			
			idc = groupBtn1IDC;
			onMouseButtonClick = "_this call compile preprocessFileLineNumbers 'client\systems\playerMenu\event_clickGrpBtn.sqf'";
		};
		
		class groupBtn2 : groupBtn1 {
			text = "Button Two";
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.37 + (0.03 + 0.005) * 1 );
			idc = groupBtn2IDC;
		};
		
		class groupBtn3 : groupBtn1 {
			text = "Button Three";
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.37 + (0.03 + 0.005) * 2 );
			idc = groupBtn3IDC;
		};
		
		class groupBtn4 : groupBtn1 {
			text = "Button Four";
			y = safezoneY + safezoneH * ( (0.5 - DIALOG_H/2) + 0.37 + (0.03 + 0.005) * 3 );
			idc = groupBtn4IDC;
		};
		
		class groupLeave : groupBtn1 {
			text = "Leave Group";
			y = safezoneY + safezoneH * ( (0.5 + DIALOG_H/2) - 0.01 - 0.03 );
			idc = groupLeaveIDC;
			action = "[] call BL_fnc_leaveGroup;";
			onMouseButtonClick = "";
		};
	};
};