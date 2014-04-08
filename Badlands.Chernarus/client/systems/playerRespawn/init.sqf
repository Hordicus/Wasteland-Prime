#include "functions\macro.sqf"
// Register beacon types with playerMenu
['airBeacon', 'Air Beacon', 'airBeaconModel' call BL_fnc_config, [], {
	[15, "Deploying Air Beacon %1", [], {
		['air', getPosATL player, getDir player] call BL_fnc_createSpawnBeacon;
		['airBeacon'] call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
}] call BL_fnc_addInventoryType;

['groundBeacon', 'Ground Beacon', 'groundBeaconModel' call BL_fnc_config, [], {
	[15, "Deploying Ground Beacon %1", [], {
		['ground', getPosATL player, getDir player] call BL_fnc_createSpawnBeacon;
		['groundBeacon'] call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
}] call BL_fnc_addInventoryType;

if ( !hasInterface ) exitwith {};

// Keep track of towns and beacons
// Towns
playerRespawn_towns = [[], "EMPTY"] call CBA_fnc_hashCreate;
playerRespawn_beacons = [[], [[], "EMPTY"]] call CBA_fnc_hashCreate;
playerRespawn_air = [[], [objNull, 0,0]] call CBA_fnc_hashCreate;

playerRespawnPage = 0;
playerRespawnOptionEventHandlers = [];

// Holds current spawn options. New spawn options should update this.
playerRespawnOptions = [[], []] call CBA_fnc_hashCreate;

// Set default for BL_spawnBeacons (publicVariable)
BL_spawnBeacons = missionNamespace getVariable ['BL_spawnBeacons', []];

// True when respawnDialog is open, false after player has been spawned.
BL_playerSpawning = false;
[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};
	
	playerRespawn_lastDeath = getPosATL mapCenter;

	["radarUpdate", {
		private ["_town", "_players", "_state", "_pos"];
		
		_players = _this select 0;
		_town = _this select 1 select 0;
		_pos = _this select 1 select 1;
		_state = [_players] call BL_fnc_friendlyState;
		
		[playerRespawn_towns, _town, [_players, _state, _pos]] call CBA_fnc_hashSet;
		[playerRespawnOptions, 'towns', [playerRespawn_towns] call BL_fnc_townRespawnOptions] call CBA_fnc_hashSet;
		
		['respawnDialogUpdate'] call CBA_fnc_localEvent;
	}] call CBA_fnc_addEventHandler;

	["beaconUpdate", {
		private ['_players', '_ownerUID', '_state'];
		_players  = _this select 0;
		_ownerUID = _this select 1 select 0;
		_state = [_players] call BL_fnc_friendlyState;
		
		[playerRespawn_beacons, _ownerUID, [_players, _state]] call CBA_fnc_hashSet;
		[playerRespawnOptions, 'beacons', [playerRespawn_beacons] call BL_fnc_beaconRespawnOptions] call CBA_fnc_hashSet;
		
		['respawnDialogUpdate'] call CBA_fnc_localEvent;
	}] call CBA_fnc_addEventHandler;
	
	["airUpdate", {
		diag_log format['Got airUpdate: %1', _this];
		_netId     = _this select 0;
		_pilot     = _this select 1;
		_altitude  = _this select 2;
		_cargoRoom = _this select 3;

		[playerRespawn_air, _netId, [_pilot, _altitude, _cargoRoom]] call CBA_fnc_hashSet;
		[playerRespawnOptions, 'airVehicles', [playerRespawn_air] call BL_fnc_flyingRespawnOptions] call CBA_fnc_hashSet;
		
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

	"BL_spawnBeacons" addPublicVariableEventHandler {
		[playerRespawnOptions, 'beacons', [playerRespawn_beacons] call BL_fnc_beaconRespawnOptions] call CBA_fnc_hashSet;
		['respawnDialogUpdate'] call CBA_fnc_localEvent;
	};

	player addEventHandler ["killed", {
		playerRespawn_lastDeath = getPosATL (_this select 0);
	}];

	player addEventHandler ["respawn", {
		player allowDamage false;
		player enableSimulation false;
		createDialog "respawnDialog";
	}];
	
	// Make beacons emit sound
	while { true } do {
		{
			(_x select 2) say3D "beacon";
		} count BL_spawnBeacons;
		
		sleep 3;
	};
};

// Repack/destroy beacon
_condition = compile format['((_this select 0) isKindOf "%1" || (_this select 0) isKindOf "%2") && !isNil {(_this select 0) getVariable "beaconType"}',
	'airBeaconModel' call BL_fnc_config,
	'groundBeaconModel' call BL_fnc_config
];
['Repack beacon', _condition,
{
	[60, "Repacking Beacon %1", _this, {
		(format['%1Beacon', (_this select 0) getVariable 'beaconType']) call BL_fnc_addInventoryItem;
		[_this select 0] call BL_fnc_destroySpawnBeacon;
	}] call BL_fnc_animDoWork;
}, 1] call BL_fnc_addAction;

['Destroy beacon', _condition,
{
	[30, "Destroying Beacon %1", _this, {
		[_this select 0] call BL_fnc_destroySpawnBeacon;
	}] call BL_fnc_animDoWork;
}, 1] call BL_fnc_addAction;