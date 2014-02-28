#include "functions\macro.sqf"
_dialog = _this select 0;

// Set up map background
_map = (_dialog displayCtrl respawnBackdropIDC);
_map ctrlMapAnimAdd [0, 1, mapCenter];
_map ctrlEnable false;
ctrlMapAnimCommit _map;


// Things that are selectively shown. Hide by default to avoid 'flash'
{
	(_dialog displayCtrl _x) ctrlShow false;
} count [
	respawnOptionOneIDC,
	respawnOptionOneInfoIDC,
	respawnOptionOneDistIDC,
	
	respawnOptionTwoIDC,
	respawnOptionTwoInfoIDC,
	respawnOptionTwoDistIDC,
	
	respawnOptionThreeIDC,
	respawnOptionThreeInfoIDC,
	respawnOptionThreeDistIDC,
	
	respawnOptionFourIDC,
	respawnOptionFourInfoIDC,
	respawnOptionFourDistIDC,
	
	respawnOptionFiveIDC,
	respawnOptionFiveInfoIDC,
	respawnOptionFiveDistIDC,
	
	respawnOptionSixIDC,
	respawnOptionSixInfoIDC,
	respawnOptionSixDistIDC
];

[] spawn {
	waitUntil {!isNull(findDisplay respawnDialogIDD)};
	['respawnDialogUpdate'] call CBA_fnc_localEvent;

	// Track air vehicles while respawnDialog is active
	while {!isNull(findDisplay respawnDialogIDD)} do {
		[playerRespawnOptions, 'airVehicles', call BL_fnc_flyingRespawnOptions] call CBA_fnc_hashSet;
		['respawnDialogUpdate'] call CBA_fnc_localEvent;
		sleep 0.5;
	};
};
