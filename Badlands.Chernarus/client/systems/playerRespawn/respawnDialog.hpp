#include "functions\macro.sqf"
#define spawnOptionY(OFFSET) safezoneY + safezoneH * ( 0.22 + 0.005 + 0.05 + 0.02 + (0.01 + 0.03)*OFFSET)

class respawnDialog {
	idd = respawnDialogIDD;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "_this call compile preprocessFileLineNumbers 'client\systems\playerRespawn\event_onLoad.sqf'; _this call BL_fnc_abortConfirm;";
	onChildDestroyed = "_this call compile preprocessFileLineNumbers 'client\systems\playerRespawn\event_updateGEARInfo.sqf';";
	
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5);
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
			text = "";

			x = safezoneX + safezoneW * ( 0.1 + 0.02 + 0.15 + 0.01);
			y = safezoneY + safezoneH * ( 0.1 + 0.005 + 0.05 + 0.02 );
			w = safezoneW * 0.61;
			h = safezoneH * 0.09;
			idc = respawnServerInfoIDC;
		};		
		
		class spawnOptionHeader : RscText {
			x = safezoneX + safezoneW * ( 0.1 + 0.02 );
			y = safezoneY + safezoneH * ( 0.18 + 0.005 + 0.05 + 0.02);
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
		
		// GEAR stuff
		class GEAR_select_uniform_bg : RscCommon {
			x = safezoneX + safezoneW * ( 0.1 + 0.4 + 0.0025 + 0.01 );
			y = safezoneY + safezoneH * (0.57 + 0.01);
			w = safezoneW * 0.07375;
			h = safezoneH * 0.07375;
		};

		class GEAR_select_uniform : GEAR_select_uniform_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_uniform_icon;
			idc = GEAR_select_uniform_idc;
		};

		class GEAR_select_backpack_bg : GEAR_select_uniform_bg {
			x = safezoneX + safezoneW * ( 0.1 + 0.4 + 0.0025 + 0.07375 + 0.01 + 0.005 );
		};

		class GEAR_select_backpack : GEAR_select_backpack_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_backpack_icon;
			idc = GEAR_select_backpack_idc;
		};
		
		class GEAR_select_vest_bg : GEAR_select_uniform_bg {
			y = safezoneY + safezoneH * (0.57 + 0.07375 + 0.01 + 0.005 );
		};

		class GEAR_select_vest : GEAR_select_vest_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_vest_icon;
			idc = GEAR_select_vest_idc;
		};
		
		class GEAR_select_helmet_bg : GEAR_select_backpack_bg {
			y = safezoneY + safezoneH * (0.57 + 0.07375 + 0.01 + 0.005 );
		};
		
		class GEAR_select_helmet : GEAR_select_helmet_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_helmet_icon;
			idc = GEAR_select_helmet_idc;
		};
		
		class GEAR_select_glasses_bg : GEAR_select_uniform_bg {
			y = safezoneY + safezoneH * (0.57 + 0.07375 + 0.07375 + 0.01 + 0.005 + 0.005  );
		};
		
		class GEAR_select_glasses : GEAR_select_glasses_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_glasses_icon;
			idc = GEAR_select_glasses_idc;
		};
		
		class GEAR_select_nvg_bg : GEAR_select_uniform_bg {
			y = safezoneY + safezoneH * (0.57 + 0.07375 + 0.07375 + 0.07375 + 0.01 + 0.005 + 0.005 + 0.005 );
		};
		
		class GEAR_select_nvg : GEAR_select_nvg_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_nvg_icon;
			idc = GEAR_select_nvg_idc;
		};
		
		class GEAR_select_binocular_bg : GEAR_select_backpack_bg {
			y = safezoneY + safezoneH * (0.57 + 0.07375 + 0.07375 + 0.01 + 0.005 + 0.005 );
		};
		
		class GEAR_select_binocular : GEAR_select_binocular_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_binocular_icon;
			idc = GEAR_select_binocular_idc;
		};
		
		// Primary Weapon
		class GEAR_primary_bg : RscCommon {
			y = safezoneY + safezoneH * (0.57 + 0.01);
			x = safezoneX + safezoneW * ( 0.1 + 0.4 + 0.0025 + 0.07375 + 0.01 + 0.005 + 0.07375 + 0.005 );
			w = safezoneW * 0.22;
			h = safezoneH * 0.1;
		};
		
		class GEAR_primary : GEAR_primary_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_primary_icon;
			idc = GEAR_primary_idc;
		};

		class GEAR_primary_muzzle_bg : RscCommon {
			y = safezoneY + safezoneH * ( 0.68 - 0.025625);
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 0 );
			w = safezoneW * 0.05125;
			h = safezoneH * 0.025625;
		};
		
		class GEAR_primary_muzzle : GEAR_primary_muzzle_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_muzzle_icon;
			idc = GEAR_primary_muzzle_idc;
		};
		
		class GEAR_primary_acc_bg : GEAR_primary_muzzle_bg {
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 1 );
		};
		
		class GEAR_primary_acc : GEAR_primary_acc_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_acc_icon;
			idc = GEAR_primary_acc_idc;
		};
		
		class GEAR_primary_optic_bg : GEAR_primary_muzzle_bg {
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 2 );
		};
		
		class GEAR_primary_optic : GEAR_primary_optic_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_optic_icon;
			idc = GEAR_primary_optic_idc;
		};
		
		class GEAR_primary_mag_bg : GEAR_primary_muzzle_bg {
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 3 );
		};
		
		class GEAR_primary_mag : GEAR_primary_mag_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_mag_icon;
			idc = GEAR_primary_mag_idc;
		};
		
		// Secondary Weapon
		class GEAR_secondary_bg : RscCommon {
			y = safezoneY + safezoneH * (0.57 + 0.01 + (0.1 + 0.005) * 1 );
			x = safezoneX + safezoneW * ( 0.1 + 0.4 + 0.0025 + 0.07375 + 0.01 + 0.005 + 0.07375 + 0.005 );
			w = safezoneW * 0.22;
			h = safezoneH * 0.1;
		};
		
		class GEAR_secondary : GEAR_secondary_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_secondary_icon;
			idc = GEAR_secondary_idc;
		};

		class GEAR_secondary_muzzle_bg : RscCommon {
			y = safezoneY + safezoneH * ( 0.68 - 0.025625 + (0.1 + 0.005) * 1);
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 0 );
			w = safezoneW * 0.05125;
			h = safezoneH * 0.025625;
		};
		
		class GEAR_secondary_muzzle : GEAR_secondary_muzzle_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_muzzle_icon;
			idc = GEAR_secondary_muzzle_idc;
		};
		
		class GEAR_secondary_acc_bg : GEAR_secondary_muzzle_bg {
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 1 );
		};
		
		class GEAR_secondary_acc : GEAR_secondary_acc_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_acc_icon;
			idc = GEAR_secondary_acc_idc;
		};
		
		class GEAR_secondary_optic_bg : GEAR_secondary_muzzle_bg {
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 2 );
		};
		
		class GEAR_secondary_optic : GEAR_secondary_optic_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_optic_icon;
			idc = GEAR_secondary_optic_idc;
		};
		
		class GEAR_secondary_mag_bg : GEAR_secondary_muzzle_bg {
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 3 );
		};
		
		class GEAR_secondary_mag : GEAR_secondary_mag_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_mag_icon;
			idc = GEAR_secondary_mag_idc;
		};		
		
		// Pistol
		class GEAR_pistol_bg : RscCommon {
			y = safezoneY + safezoneH * (0.57 + 0.01 + (0.1 + 0.005) * 2 );
			x = safezoneX + safezoneW * ( 0.1 + 0.4 + 0.0025 + 0.07375 + 0.01 + 0.005 + 0.07375 + 0.005 );
			w = safezoneW * 0.22;
			h = safezoneH * 0.1;
		};
		
		class GEAR_pistol : GEAR_pistol_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_pistol_icon;
			idc = GEAR_pistol_idc;
		};

		class GEAR_pistol_muzzle_bg : RscCommon {
			y = safezoneY + safezoneH * ( 0.68 - 0.025625 + (0.1 + 0.005) * 2);
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 0 );
			w = safezoneW * 0.05125;
			h = safezoneH * 0.025625;
		};
		
		class GEAR_pistol_muzzle : GEAR_pistol_muzzle_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_muzzle_icon;
			idc = GEAR_pistol_muzzle_idc;
		};
		
		class GEAR_pistol_acc_bg : GEAR_pistol_muzzle_bg {
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 1 );
		};
		
		class GEAR_pistol_acc : GEAR_pistol_acc_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_acc_icon;
			idc = GEAR_pistol_acc_idc;
		};
		
		class GEAR_pistol_optic_bg : GEAR_pistol_muzzle_bg {
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 2 );
		};
		
		class GEAR_pistol_optic : GEAR_pistol_optic_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_optic_icon;
			idc = GEAR_pistol_optic_idc;
		};
		
		class GEAR_pistol_mag_bg : GEAR_pistol_muzzle_bg {
			x = safezoneX + safezoneW * ( 0.67 + ( 0.05125 + 0.005 ) * 3 );
		};
		
		class GEAR_pistol_mag : GEAR_pistol_mag_bg {
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
			type = CT_ACTIVETEXT;
			text = GEAR_mag_icon;
			idc = GEAR_pistol_mag_idc;
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
		
		class spawnRandomHALO : spawnRandomGround {
			y = safezoneY + safezoneH * ( 0.1 + 0.005 + 0.05 + 0.02 + 0.04);
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
		
		class spawnPagePrev : RscButton {
			text = "<";
			style = ST_CENTER;
			x = safezoneX + safezoneW * ( 0.43 );
			w = safezoneW * 0.02;
			h = safezoneH * 0.02;
			y = safezoneY + safezoneH * ( 0.535 );
			
			action = "call compile preprocessFileLineNumbers 'client\systems\playerRespawn\event_prevPage.sqf'";
		};
		
		class spawnPages : spawnPagePrev {
			type = CT_STATIC;
			x = safezoneX + safezoneW * ( 0.43 + 0.02 );
			w = safezoneW * 0.1;
			text = "Page 1 of 10";
			
			idc = respawnSpawnPagesIDC;
		};
		
		class spawnPageNext : spawnPagePrev {
			x = safezoneX + safezoneW * ( 0.43 + 0.02 + 0.1 );
			text = ">";

			action = "call compile preprocessFileLineNumbers 'client\systems\playerRespawn\event_nextPage.sqf'";
		};
		
		// GEAR stuff
		class respawnListPresets : RscListNBox {
			style = 0;
			idc = respawnListPresetsIDC;
			columns[] = {0, 0.04, 0.7};
			
			x = safezoneX + safezoneW * ( 0.1 );
			y = safezoneY + safezoneH * ( 0.57 + 0.02 );
			w = safezoneW * ( 0.3975 - 0.02 );
			h = safezoneH * (1 - 0.57 - 0.1 - 0.02 - 0.03 - 0.07 );
		};
		
		class respawnActivatePreset : RscButton {
			text = "Activate Preset";
			w = safezoneW * 0.15;
			h = safezoneH * 0.03;
			x = safezoneX + safezoneW * ( 0.1 + 0.02 );
			y = safezoneY + safezoneH * ( 0.9 - 0.02 - 0.03 - 0.03 - 0.01 );
			
			action = "call compile preprocessFileLineNumbers 'client\systems\playerRespawn\event_activatePreset.sqf'";
		};
		
		class respawnChangeLoadout : respawnActivatePreset {
			text = "Change Loadout";
			y = safezoneY + safezoneH * ( 0.9 - 0.02 - 0.03 );
			
			action = "createDialog 'geard';";
		};
		
		class transactionDetails : RscStructuredText {
			idc = respawnTransactionDetailsIDC;
			w = safezoneW * 0.1975;
			h = safezoneH * 0.07;
			x = safezoneX + safezoneW * ( 0.1 + 0.02 + 0.15 + 0.01 );
			y = safezoneY + safezoneH * ( 0.9 - 0.02 - 0.03 - 0.03 - 0.01 );
			
			text = "Cash:<t align='right'>$8000</t><br />Loadout Cost:<t align='right'>$1000</t><br/><br/>Total:<t align='right'>$7000</t>";
		};
	};
};