#include "functions\macro.sqf"
#define spawnOptionY(OFFSET) safezoneY + safezoneH * ( 0.24 + 0.005 + 0.05 + 0.02 + (0.01 + 0.03)*OFFSET)

class respawnDialog {
	idd = respawnDialogIDD;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "_this call compile preprocessFileLineNumbers 'client\systems\playerRespawn\event_onLoad.sqf'";

	class controlsBackground {
		class respawnBackdrop : RscMap {
			idc = respawnBackdropIDC;
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH;
			colorGrid[] = {0.1, 0.1, 0.1, 0};
			colorGridMap[] = {0.1, 0.1, 0.1, 0};
			scaleMin     = 0.7;
			scaleDefault = 0.7;
			scaleMax     = 0.7;
		};
		
		class respawnTitle : RscCommon {
			x = safezoneX + safezoneW * ( 0.1 );
			y = safezoneY + safezoneH * ( 0.1 );
			w = safezoneW * 0.8;
			h = safezoneH * 0.05;
			colorBackground[] = {0,0,0,1};
			text = "Player Respawn";
			sizeEx = 0.04;
		};
		
		class respawnControlsBackground : RscCommon {
			x = safezoneX + safezoneW * ( 0.1 );
			y = safezoneY + safezoneH * ( 0.1 + 0.005 + 0.05);
			w = safezoneW * 0.8;
			h = safezoneH * 0.41;
		};
		
		class respawnMiscLeftBackground : RscCommon {
			x = safezoneX + safezoneW * ( 0.1 );
			y = safezoneY + safezoneH * 0.57;
			w = safezoneW * 0.3975;
			h = safezoneH * (1 - 0.57 - 0.1);
		};
		
		class respawnMiscRightBackground : RscCommon {
			x = safezoneX + safezoneW * ( 0.1 + 0.4 + 0.0025);
			y = safezoneY + safezoneH * 0.57;
			w = safezoneW * 0.3975;
			h = safezoneH * (1 - 0.57 - 0.1);
		};
		
		class serverInfo : RscStructuredText {
			text = "<t align='right'>Server Name<br />ts.gamingserver.com<br/>http://gamingserver.com</t>";

			x = safezoneX + safezoneW * ( 0.1 + 0.02 + 0.15 + 0.01);
			y = safezoneY + safezoneH * ( 0.1 + 0.005 + 0.05 + 0.02 );
			w = safezoneW * 0.61;
			h = safezoneH * 0.09;
		};		
		
		class spawnOptionHeader : RscText {
			x = safezoneX + safezoneW * ( 0.1 + 0.02 );
			y = safezoneY + safezoneH * ( 0.2 + 0.005 + 0.05 + 0.02);
			w = safezoneW * 0.15;
			h = safezoneH * 0.03;

			text = "Location";
			sizeEx = 0.03;
		};
		
		class spawnOptionInfoHeader : spawnOptionHeader {
			x = safezoneX + safezoneW * ( 0.1 + 0.02 + 0.15 + 0.01 );
			w = safezoneW * 0.15;
			text = "Information";
		};
		
		class spawnOptionDistHeader : spawnOptionHeader {
			style = ST_RIGHT;
			x = safezoneX + safezoneW * ( 0.1 + 0.73 );
			w = safezoneW * 0.06;
			text = "Distance";
		};
	};
	
	class controls {
		class spawnRandomGround : RscButton {
			x = safezoneX + safezoneW * ( 0.1 + 0.02 );
			w = safezoneW * 0.15;
			h = safezoneH * 0.03;
			y = safezoneY + safezoneH * ( 0.1 + 0.005 + 0.05 + 0.02 );
			text = "Random Ground Insert";
			onMouseButtonClick = "'ground' call compile preprocessFileLineNumbers 'client\systems\playerRespawn\event_spawnRandomButton.sqf'";
		};
		
		class spawnRandomHALO : RscButton {
			x = safezoneX + safezoneW * ( 0.1 + 0.02 );
			w = safezoneW * 0.15;
			h = safezoneH * 0.03;
			y = safezoneY + safezoneH * ( 0.1 + 0.005 + 0.05 + 0.02 + 0.01 + 0.03);
			text = "Random Air Drop";
			onMouseButtonClick = "'air' call compile preprocessFileLineNumbers 'client\systems\playerRespawn\event_spawnRandomButton.sqf'";
		};
	
		// Spawn buttons and info lines
		class spawnOptionOne : spawnRandomGround {
			onMouseButtonClick = "_this call compile preprocessFileLineNumbers 'client\systems\playerRespawn\event_spawnOptionClick.sqf'";
			idc = respawnOptionOneIDC;
			y = spawnOptionY(0);
			
			text = "Zelenogorsk";
		};
		
		class spawnOptionOneInfo : RscText {
			idc = respawnOptionOneInfoIDC;
			x = safezoneX + safezoneW * ( 0.1 + 0.02 + 0.15 + 0.01 );
			y = spawnOptionY(0);
			w = safezoneW * 0.55;
			h = safezoneH * 0.03;

			text = "Player 1, Player 2, Player 3";
		};
		
		class spawnOptionOneDist : RscText {
			idc = respawnOptionOneDistIDC;
			style = ST_RIGHT;
			x = safezoneX + safezoneW * ( 0.1 + 0.74 );
			y = spawnOptionY(0);
			w = safezoneW * 0.05;
			h = safezoneH * 0.03;

			text = "20000m";
		};
		
		class spawnOptionTwo : spawnOptionOne {
			idc = respawnOptionTwoIDC;
			y = spawnOptionY(1);
		};

		class spawnOptionTwoInfo : spawnOptionOneInfo {
			idc = respawnOptionTwoInfoIDC;
			y = spawnOptionY(1);
		};
		
		class spawnOptionTwoDist : spawnOptionOneDist {
			idc = respawnOptionTwoDistIDC;
			y = spawnOptionY(1);
		};

		class spawnOptionThree: spawnOptionOne {
			idc = respawnOptionThreeIDC;
			y = spawnOptionY(2);
		};
		
		class spawnOptionThreeInfo: spawnOptionOneInfo {
			idc = respawnOptionThreeInfoIDC;
			y = spawnOptionY(2);
		};

		class spawnOptionThreeDist: spawnOptionOneDist {
			idc = respawnOptionThreeDistIDC;
			y = spawnOptionY(2);
		};

		class spawnOptionFour: spawnOptionOne {
			idc = respawnOptionFourIDC;
			y = spawnOptionY(3);
		};

		class spawnOptionFourInfo: spawnOptionOneInfo {
			idc = respawnOptionFourInfoIDC;
			y = spawnOptionY(3);
		};

		class spawnOptionFourDist: spawnOptionOneDist {
			idc = respawnOptionFourDistIDC;
			y = spawnOptionY(3);
		};
		
		class spawnOptionFive: spawnOptionOne {
			idc = respawnOptionFiveIDC;
			y = spawnOptionY(4);
		};

		class spawnOptionFiveInfo: spawnOptionOneInfo {
			idc = respawnOptionFiveInfoIDC;
			y = spawnOptionY(4);
		};
		
		class spawnOptionFiveDist: spawnOptionOneDist {
			idc = respawnOptionFiveDistIDC;
			y = spawnOptionY(4);
		};
		
		class spawnOptionSix: spawnOptionOne {
			idc = respawnOptionSixIDC;
			y = spawnOptionY(5);
		};

		class spawnOptionSixInfo: spawnOptionOneInfo {
			idc = respawnOptionSixInfoIDC;
			y = spawnOptionY(5);
		};
		
		class spawnOptionSixDist: spawnOptionOneDist {
			idc = respawnOptionSixDistIDC;
			y = spawnOptionY(5);
		};
		
		// GEAR stuff
		class respawnListPresets : RscListNBox {
			style = 0;
			colorBackground[] = {1,0,0,0.5};
			idc = respawnListPresetsIDC;
			columns[] = {0, 0.04, 0.7};
			
			x = safezoneX + safezoneW * ( 0.1 );
			y = safezoneY + safezoneH * ( 0.57 + 0.02 );
			w = safezoneW * ( 0.3975 - 0.02 );
			h = safezoneH * (1 - 0.57 - 0.1 - 0.02 - 0.03 - 0.03);
		};
		
		class respawnActivatePreset : RscButton {
			text = "Activate Preset";
			w = safezoneW * 0.15;
			h = safezoneH * 0.03;
			x = safezoneX + safezoneW * ( 0.1 + 0.02 );
			y = safezoneY + safezoneH * ( 0.9 - 0.02 - 0.03 );
		};
	};
};