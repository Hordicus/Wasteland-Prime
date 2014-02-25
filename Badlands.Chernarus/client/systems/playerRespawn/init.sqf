#include "dialog\defines.sqf"
disableSerialization;
((_this select 0) displayCtrl respawnBackdropIDC) ctrlSetText (getText (configFile >> "CfgWorlds" >> worldName >> "pictureMap"));

_map = ((_this select 0) displayCtrl respawnBackdropIDC);
_map ctrlMapAnimAdd [0, 1, mapCenter];
_map ctrlEnable false;
ctrlMapAnimCommit _map;