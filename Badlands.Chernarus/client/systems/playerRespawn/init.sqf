#include "functions\macro.sqf"

// Keep track of towns and beacons
// Towns
playerRespawn_towns = [[], "EMPTY"] call CBA_fnc_hashCreate;
playerRespawn_beacons = [];
playerRespawn_lastDeath = getPosATL mapCenter;

playerRespawnPage = 0;
playerRespawnOptionEventHandlers = [];

// Holds current spawn options
playerRespawnOptions = [[], []] call CBA_fnc_hashCreate;

player addEventHandler ["killed", {
	playerRespawn_lastDeath = getPosATL (_this select 0);
}];

player addEventHandler ["respawn", {
	createDialog "respawnDialog";
}];

["radarUpdate", {
	private ["_town", "_players", "_state", "_pos"];
	
	_players = _this select 0;
	_town = _this select 1 select 0;
	_pos = _this select 1 select 1;
	_state = _players call BL_fnc_friendlyState;
	
	[playerRespawn_towns, _town, [_players, _state, _pos]] call CBA_fnc_hashSet;
	[playerRespawnOptions, 'towns', [playerRespawn_towns] call BL_fnc_townRespawnOptions] call CBA_fnc_hashSet;
	
	['respawnDialogUpdate'] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

['respawnDialogUpdate', {
	if !( isNull (findDisplay respawnDialogIDD)) then {
		_options = [];
		{
			_options = _options + _x;
		} count (playerRespawnOptions select 2);

		[_options] call BL_fnc_showRespawnOptions;
	};
}] call CBA_fnc_addEventHandler;

// Make beacons emit sound
[] spawn {
	while { true } do {
		{
			(_x select 3) say3D "beacon";
		} count BL_spawnBeacons;
		
		sleep 3;
	};
};