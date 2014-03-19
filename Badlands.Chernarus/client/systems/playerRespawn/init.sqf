#include "functions\macro.sqf"

// Keep track of towns and beacons
// Towns
playerRespawn_towns = [[], "EMPTY"] call CBA_fnc_hashCreate;
playerRespawn_beacons = [[], "EMPTY"] call CBA_fnc_hashCreate;
playerRespawn_lastDeath = getPosATL mapCenter;

playerRespawnPage = 0;
playerRespawnOptionEventHandlers = [];

// Holds current spawn options. New spawn options should update this.
playerRespawnOptions = [[], []] call CBA_fnc_hashCreate;

// Set default for BL_spawnBeacons (publicVariable)
BL_spawnBeacons = missionNamespace getVariable ['BL_spawnBeacons', []];

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

["beaconUpdate", {
	private ['_players', '_ownerUID', '_state'];
	_players  = _this select 0;
	_ownerUID = _this select 1 select 0;
	_state = _players call BL_fnc_friendlyState;
	
	[playerRespawn_beacons, _ownerUID, [_players, _state]] call CBA_fnc_hashSet;
	[playerRespawnOptions, 'beacons', [playerRespawn_beacons] call BL_fnc_beaconRespawnOptions] call CBA_fnc_hashSet;
	
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
			(_x select 4) say3D "beacon";
		} count BL_spawnBeacons;
		
		sleep 3;
	};
};

// Register beacon types with playerMenu
['airBeacon', 'Air Beacon', [], {
	['air', getPosATL player, getDir player] call BL_fnc_createSpawnBeacon;
	['airBeacon'] call BL_fnc_removeInventoryItem;
},
{
	_model = 'airBeaconModel' call BL_fnc_config;
	createVehicle [_model, getPosATL player, [], 0, "CAN_COLLIDE"];
	['airBeacon'] call BL_fnc_removeInventoryItem;
}] call BL_fnc_addInventoryType;

['groundBeacon', 'Ground Beacon', [], {
	['ground', getPosATL player, getDir player] call BL_fnc_createSpawnBeacon;
	['groundBeacon'] call BL_fnc_removeInventoryItem;
},
{
	_model = 'groundBeaconModel' call BL_fnc_config;
	createVehicle [_model, getPosATL player, [], 0, "CAN_COLLIDE"];
	['groundBeacon'] call BL_fnc_removeInventoryItem;
}] call BL_fnc_addInventoryType;