#include "functions\macro.sqf"
disableSerialization;

((_this select 0) displayCtrl infoTextIDC) ctrlSetStructuredText parseText format["
<t align='left'>Server Uptime</t> <t align='right'>06:00:00</t><br />
<t align='left'>Blufor Players</t> <t align='right'>%1/%2</t><br />
<t align='left'>Opfor Players</t> <t align='right'>%3/%4</t><br />
<t align='left'>Indy Players</t> <t align='right'>%5/%6</t><br />
<t align='left'>Server FPS</t> <t align='right'>30 FPS</t><br />
<t align='left'>Money</t> <t align='right'>$50000</t><br />
",
{ side _x == blufor } count playableUnits,
playableSlotsNumber blufor,
{ side _x == opfor } count playableUnits,
playableSlotsNumber opfor,
{ side _x == resistance } count playableUnits,
playableSlotsNumber resistance
];

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