#include "functions\macro.sqf"
disableSerialization;
BL_groupLastClicked = -1;

[(_this select 0)] spawn {
	while { !isNull (_this select 0) } do {
		[(_this select 0)] call BL_fnc_updateInfoText;
		sleep 1;
	};
};

((_this select 0) displayCtrl dropMoneyAmountIDC) ctrlSetText "$2500";

((_this select 0) displayCtrl footViewDistanceIDC) sliderSetRange [500, 5000];
((_this select 0) displayCtrl carViewDistanceIDC) sliderSetRange [500, 5000];
((_this select 0) displayCtrl airViewDistanceIDC) sliderSetRange [500, 5000];

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