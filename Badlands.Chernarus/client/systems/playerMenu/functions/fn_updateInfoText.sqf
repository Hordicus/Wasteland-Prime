#include "macro.sqf"
disableSerialization;

private ['_dialog'];
_dialog = [_this, 0, findDisplay playerMenuDialogIDD, [displayNull]] call BIS_fnc_param;

(_dialog displayCtrl infoTextIDC) ctrlSetStructuredText parseText format["
<t align='left'>Server Uptime</t> <t align='right'>%8</t><br />
<t align='left'>Blufor Players</t> <t align='right'>%1/%2</t><br />
<t align='left'>Opfor Players</t> <t align='right'>%3/%4</t><br />
<t align='left'>Indy Players</t> <t align='right'>%5/%6</t><br />
<t align='left'>Server FPS</t> <t align='right'>%7 FPS</t><br />
<t align='left'>Money</t> <t align='right'>$%9</t><br />
",
{ side _x == blufor } count playableUnits,
playableSlotsNumber blufor,
{ side _x == opfor } count playableUnits,
playableSlotsNumber opfor,
{ side _x == resistance } count playableUnits,
playableSlotsNumber resistance,
BL_avgServerFps,
[BL_serverUpTime/60/60] call BIS_fnc_timeToString,
player getVariable ['money', 0]
];