#include "functions\macro.sqf"

#define scoreboardH 0.3
#define scoreboardW 0.5

#define playerLine(LINE) safezoneY + safezoneH * ( 0.5 - scoreboardH/2 + (((scoreboardH - (0.005 * 9)) / 10)*LINE) + (0.005 * LINE))
class scoreboardRsc {
	idd = -1;
	fadein = 0;
	fadeout = 0;
	duration = 99999999999999;
	onLoad = "_this call compile preprocessFileLineNumbers 'client\systems\statTracking\event_onLoad.sqf';";
	
	class controlsBackground {
		class headerImagesBackground : RscCommon {
			colorBackground[] = {0,0,0,1};
			w = safezoneW * scoreboardW;
			h = safezoneH * ((scoreboardH - (0.005 * 9)) / 10);
			
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 );
			y = playerLine(-1);
		};
	};
	
	class controls{
		class P1Position : RscCommon {
			idc = IDC(0,0);
			colorBackground[] = {0,0,0,1};
			text = "10";
			w = safezoneW * (scoreboardW * 0.05);
			h = safezoneH * ((scoreboardH - (0.005 * 9)) / 10);
			
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 );
			y = playerLine(0);
		};

		class P1RankBG : P1Position {
			idc = IDC(0,1);
			text = "";
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.05));
		};
		
		class P1Rank : P1Position {
			idc = IDC(0,2);
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO + ST_CENTER;
			text = "";
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.05));
		};
		
		class P1Name : P1Position {
			idc = IDC(0,3);
			text = "A really super long player name";
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.1));
			w = safezoneW * (scoreboardW * 0.4);
		};
		
		class P1Bounty : P1Position {
			idc = IDC(0,4);
			text = "$100,000";
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.5));
			w = safezoneW * (scoreboardW * 0.15);
		};
		
		class P1Kills : P1Position {
			idc = IDC(0,5);
			style = ST_RIGHT;
			text = "1,000";
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.65));
			w = safezoneW * (scoreboardW * 0.1);
		};
		
		class P1Deaths : P1Position {
			idc = IDC(0,6);
			style = ST_RIGHT;
			text = "1,000";
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.75));
			w = safezoneW * (scoreboardW * 0.1);
		};
		
		class P1Score : P1Position {
			idc = IDC(0,7);
			style = ST_RIGHT;
			text = "100,000";
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.85));
			w = safezoneW * (scoreboardW * 0.15);
		};
		
		// Player Two
		class P2Position : P1Position { idc = IDC(1,0); y = playerLine(1); };
		class P2RankBG   : P1RankBG   { idc = IDC(1,1); y = playerLine(1); };
		class P2Rank     : P1Rank     { idc = IDC(1,2); y = playerLine(1); };
		class P2Name     : P1Name     { idc = IDC(1,3); y = playerLine(1); };
		class P2Bounty   : P1Bounty   { idc = IDC(1,4); y = playerLine(1); };
		class P2Kills    : P1Kills    { idc = IDC(1,5); y = playerLine(1); };
		class P2Deaths   : P1Deaths   { idc = IDC(1,6); y = playerLine(1); };
		class P2Score    : P1Score    { idc = IDC(1,7); y = playerLine(1); };
		
		// Player Three
		class P3Position : P1Position { idc = IDC(2,0); y = playerLine(2); };
		class P3RankBG   : P1RankBG   { idc = IDC(2,1); y = playerLine(2); };
		class P3Rank     : P1Rank     { idc = IDC(2,2); y = playerLine(2); };
		class P3Name     : P1Name     { idc = IDC(2,3); y = playerLine(2); };
		class P3Bounty   : P1Bounty   { idc = IDC(2,4); y = playerLine(2); };
		class P3Kills    : P1Kills    { idc = IDC(2,5); y = playerLine(2); };
		class P3Deaths   : P1Deaths   { idc = IDC(2,6); y = playerLine(2); };
		class P3Score    : P1Score    { idc = IDC(2,7); y = playerLine(2); };
		
		// Player Four
		class P4Position : P1Position { idc = IDC(3,0); y = playerLine(3); };
		class P4RankBG   : P1RankBG   { idc = IDC(3,1); y = playerLine(3); };
		class P4Rank     : P1Rank     { idc = IDC(3,2); y = playerLine(3); };
		class P4Name     : P1Name     { idc = IDC(3,3); y = playerLine(3); };
		class P4Bounty   : P1Bounty   { idc = IDC(3,4); y = playerLine(3); };
		class P4Kills    : P1Kills    { idc = IDC(3,5); y = playerLine(3); };
		class P4Deaths   : P1Deaths   { idc = IDC(3,6); y = playerLine(3); };
		class P4Score    : P1Score    { idc = IDC(3,7); y = playerLine(3); };
		
		// Player Five
		class P5Position : P1Position { idc = IDC(4,0); y = playerLine(4); };
		class P5RankBG   : P1RankBG   { idc = IDC(4,1); y = playerLine(4); };
		class P5Rank     : P1Rank     { idc = IDC(4,2); y = playerLine(4); };
		class P5Name     : P1Name     { idc = IDC(4,3); y = playerLine(4); };
		class P5Bounty   : P1Bounty   { idc = IDC(4,4); y = playerLine(4); };
		class P5Kills    : P1Kills    { idc = IDC(4,5); y = playerLine(4); };
		class P5Deaths   : P1Deaths   { idc = IDC(4,6); y = playerLine(4); };
		class P5Score    : P1Score    { idc = IDC(4,7); y = playerLine(4); };
		
		// Player Six
		class P6Position : P1Position { idc = IDC(5,0); y = playerLine(5); };
		class P6RankBG   : P1RankBG   { idc = IDC(5,1); y = playerLine(5); };
		class P6Rank     : P1Rank     { idc = IDC(5,2); y = playerLine(5); };
		class P6Name     : P1Name     { idc = IDC(5,3); y = playerLine(5); };
		class P6Bounty   : P1Bounty   { idc = IDC(5,4); y = playerLine(5); };
		class P6Kills    : P1Kills    { idc = IDC(5,5); y = playerLine(5); };
		class P6Deaths   : P1Deaths   { idc = IDC(5,6); y = playerLine(5); };
		class P6Score    : P1Score    { idc = IDC(5,7); y = playerLine(5); };
		
		// Player Seven
		class P7Position : P1Position { idc = IDC(6,0); y = playerLine(6); };
		class P7RankBG   : P1RankBG   { idc = IDC(6,1); y = playerLine(6); };
		class P7Rank     : P1Rank     { idc = IDC(6,2); y = playerLine(6); };
		class P7Name     : P1Name     { idc = IDC(6,3); y = playerLine(6); };
		class P7Bounty   : P1Bounty   { idc = IDC(6,4); y = playerLine(6); };
		class P7Kills    : P1Kills    { idc = IDC(6,5); y = playerLine(6); };
		class P7Deaths   : P1Deaths   { idc = IDC(6,6); y = playerLine(6); };
		class P7Score    : P1Score    { idc = IDC(6,7); y = playerLine(6); };
		
		// Player Eight
		class P8Position : P1Position { idc = IDC(7,0); y = playerLine(7); };
		class P8RankBG   : P1RankBG   { idc = IDC(7,1); y = playerLine(7); };
		class P8Rank     : P1Rank     { idc = IDC(7,2); y = playerLine(7); };
		class P8Name     : P1Name     { idc = IDC(7,3); y = playerLine(7); };
		class P8Bounty   : P1Bounty   { idc = IDC(7,4); y = playerLine(7); };
		class P8Kills    : P1Kills    { idc = IDC(7,5); y = playerLine(7); };
		class P8Deaths   : P1Deaths   { idc = IDC(7,6); y = playerLine(7); };
		class P8Score    : P1Score    { idc = IDC(7,7); y = playerLine(7); };
		
		// Player Nine
		class P9Position : P1Position { idc = IDC(8,0); y = playerLine(8); };
		class P9RankBG   : P1RankBG   { idc = IDC(8,1); y = playerLine(8); };
		class P9Rank     : P1Rank     { idc = IDC(8,2); y = playerLine(8); };
		class P9Name     : P1Name     { idc = IDC(8,3); y = playerLine(8); };
		class P9Bounty   : P1Bounty   { idc = IDC(8,4); y = playerLine(8); };
		class P9Kills    : P1Kills    { idc = IDC(8,5); y = playerLine(8); };
		class P9Deaths   : P1Deaths   { idc = IDC(8,6); y = playerLine(8); };
		class P9Score    : P1Score    { idc = IDC(8,7); y = playerLine(8); };
		
		// Player Ten
		class P10Position : P1Position { idc = IDC(9,0); y = playerLine(9); };
		class P10RankBG   : P1RankBG   { idc = IDC(9,1); y = playerLine(9); };
		class P10Rank     : P1Rank     { idc = IDC(9,2); y = playerLine(9); };
		class P10Name     : P1Name     { idc = IDC(9,3); y = playerLine(9); };
		class P10Bounty   : P1Bounty   { idc = IDC(9,4); y = playerLine(9); };
		class P10Kills    : P1Kills    { idc = IDC(9,5); y = playerLine(9); };
		class P10Deaths   : P1Deaths   { idc = IDC(9,6); y = playerLine(9); };
		class P10Score    : P1Score    { idc = IDC(9,7); y = playerLine(9); };
		
		// Header
		class HeaderBounty : P1Bounty {
			y = playerLine(-1);
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.5));
			w = safezoneW * 0.02;
			text = "client\systems\statTracking\icons\money.paa";
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO + ST_CENTER;
		};
		class HeaderKills : P1Kills {
			y = playerLine(-1);
			w = safezoneW * 0.02;
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.71));
			
			text = "A3\ui_f\data\IGUI\Cfg\MPTable\infantry_ca.paa";
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO + ST_CENTER;
		};
		
		class HeaderDeaths : P1Deaths {
			y = playerLine(-1);
			w = safezoneW * 0.02;
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.81));
			text = "A3\ui_f\data\IGUI\Cfg\MPTable\killed_ca.paa";
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO + ST_CENTER;
		};
		
		class HeaderScore : P1Score {
			y = playerLine(-1);
			w = safezoneW * 0.02;
			x = safezoneX + safezoneW * ( 0.5 - scoreboardW/2 + (scoreboardW * 0.96));
			text = "A3\ui_f\data\IGUI\Cfg\MPTable\total_ca.paa";
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO + ST_CENTER;
		};
	};
};