#include "functions\macro.sqf"

// Keep track of towns and beacons
// Towns
playerRespawn_towns = [[], "EMPTY"] call CBA_fnc_hashCreate;
playerRespawn_beacons = [];
playerRespawn_lastDeath = getPosATL mapCenter;
playerRespawnPage = 0;
playerRespawnOptionEventHandlers = [];

player addEventHandler ["killed", {
	playerRespawn_lastDeath = getPosATL (_this select 0);
}];

player addEventHandler ["respawn", {
	createDialog "respawnDialog";
}];

["radarUpdate", {
	private ["_town", "_players", "_state", "_pos"];
	
	_town = _this select 0;
	_players = _this select 1;
	_pos = _this select 2;
	_state = _players call BL_fnc_friendlyState;
	
	[playerRespawn_towns, _town, [_players, _state, _pos]] call CBA_fnc_hashSet;
	
	['respawnDialogUpdate'] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

['respawnDialogUpdate', {
	if !( isNull (findDisplay respawnDialogIDD)) then {
		[playerRespawn_towns, playerRespawn_beacons, playerRespawn_lastDeath] call BL_fnc_showRespawnOptions;
	};
}] call CBA_fnc_addEventHandler;