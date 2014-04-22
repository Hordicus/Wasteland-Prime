#include "functions\macro.sqf"
disableSerialization;
BL_groupLastClicked = -1;

[(_this select 0)] spawn {
	while { !isNull (_this select 0) } do {
		BL_serverUpTime = BL_serverUpTime + 1;
		[(_this select 0)] call BL_fnc_updateInfoText;
		sleep 1;
	};
};

((_this select 0) displayCtrl dropMoneyAmountIDC) ctrlSetText "$2500";

((_this select 0) displayCtrl footViewDistanceIDC) sliderSetRange [500, 5000];
((_this select 0) displayCtrl carViewDistanceIDC) sliderSetRange [500, 5000];
((_this select 0) displayCtrl airViewDistanceIDC) sliderSetRange [500, 5000];
((_this select 0) displayCtrl grassIDC) sliderSetRange [0, 50];

((_this select 0) displayCtrl footViewDistanceIDC) sliderSetPosition BL_footViewDistance;
((_this select 0) displayCtrl carViewDistanceIDC) sliderSetPosition BL_carViewDistance;
((_this select 0) displayCtrl airViewDistanceIDC) sliderSetPosition BL_airViewDistance;

((_this select 0) displayCtrl footViewDistanceValueIDC) ctrlSetText format['%1m', (
	sliderPosition ((_this select 0) displayCtrl footViewDistanceIDC)
)];

((_this select 0) displayCtrl carViewDistanceValueIDC) ctrlSetText format['%1m', (
	sliderPosition ((_this select 0) displayCtrl carViewDistanceIDC)
)];

((_this select 0) displayCtrl airViewDistanceValueIDC) ctrlSetText format['%1m', (
	sliderPosition ((_this select 0) displayCtrl airViewDistanceIDC)
)];

[_this select 0] call BL_fnc_updateGroupInfo;
[_this select 0] call BL_fnc_updatePlayerInv;

_grass = ((_this select 0) displayCtrl grassSettingIDC);
_grass lbAdd "None";
_grass lbAdd "Default";
_grass lbAdd "Medium";
_grass lbAdd "High";
_grass lbAdd "Ultra";
_grass lbSetCurSel BL_grass;

_env = ((_this select 0) displayCtrl enableEnvironmentIDC);
_env lbAdd "Life Disabled";
_env lbAdd "Life Enabled";
_env lbSetCurSel BL_enableEnv;

((_this select 0) displayCtrl dropMoneyAmountIDC) ctrlSetText str (player getVariable ['money', 0]);

((_this select 0) displayCtrl playerMenuKeyBindIDC) ctrlSetText format['Player Menu Key: %1', [BL_playerMenuKey] call BIS_fnc_keyCode];

// Keep group display up to date. If someone leaves/joins group size will change.
[] spawn {
	private ['_grpSize'];
	_grpSize = count units group player;

	while { !isNull findDisplay playerMenuDialogIDD } do {
		if ( _grpSize != count units group player ) then {
			[_this] call BL_fnc_updateGroupInfo;
			_grpSize = count units group player;
		};
		
		sleep 0.1;
	};
};

((_this select 0) displayCtrl adminPanelIDC) ctrlShow (isClass (configFile >> "adminPanel"));