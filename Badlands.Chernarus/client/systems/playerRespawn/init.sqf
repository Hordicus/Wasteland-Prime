#include "functions\macro.sqf"
// Register beacon types with playerMenu
['airBeacon', 'Air Beacon', 'airBeaconModel' call BL_fnc_config, [], {
	_uid = getPlayerUID player;
	_continue = true;
	
	if ( { (_x select 1) == _uid } count BL_spawnBeacons >= 2 ) then {
		if ( 'autoRemoveBeacon' call BL_fnc_config ) then {
			{
				if ( (_x select 1) == _uid ) exitwith {
					[_x select 2] call BL_fnc_destroySpawnBeacon;
				};
			} count BL_spawnBeacons;
		}
		else {
			hint 'You may only have two beacons deployed at a time.';
			_continue = false;
		};
	};

	if ( _continue ) then {
		[15, "Deploying Air Beacon %1", [], {
			['air', getPosATL player, getDir player] call BL_fnc_createSpawnBeacon;
			['airBeacon'] call BL_fnc_removeInventoryItem;
		}] call BL_fnc_animDoWork;
	};
}] call BL_fnc_addInventoryType;

['groundBeacon', 'Ground Beacon', 'groundBeaconModel' call BL_fnc_config, [], {
	_uid = getPlayerUID player;
	_continue = true;
	
	if ( { (_x select 1) == _uid } count BL_spawnBeacons >= 2 ) then {
		if ( 'autoRemoveBeacon' call BL_fnc_config ) then {
			{
				if ( (_x select 1) == _uid ) exitwith {
					[_x select 2] call BL_fnc_destroySpawnBeacon;
				};
			} count BL_spawnBeacons;
		}
		else {
			hint 'You may only have two beacons deployed at a time.';
			_continue = false;
		};
	};

	if ( _continue ) then {
		[15, "Deploying Ground Beacon %1", [], {
			['ground', getPosATL player, getDir player] call BL_fnc_createSpawnBeacon;
			['groundBeacon'] call BL_fnc_removeInventoryItem;
		}] call BL_fnc_animDoWork;
	};
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
		private ['_players', '_code', '_state'];
		_players  = _this select 0;
		_code = _this select 1 select 0;
		_state = [_players] call BL_fnc_friendlyState;
		
		[playerRespawn_beacons, _code, [_players, _state]] call CBA_fnc_hashSet;
		[playerRespawnOptions, 'beacons', [playerRespawn_beacons] call BL_fnc_beaconRespawnOptions] call CBA_fnc_hashSet;
		
		['respawnDialogUpdate'] call CBA_fnc_localEvent;
	}] call CBA_fnc_addEventHandler;
	
	["airUpdate", {
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
		BL_playerSpawning = true;
		(_this select 0) allowDamage false;
		(_this select 0) enableSimulation false;
		createDialog "BLrespawnDialog";
	}];
	
	['groupChange', {
		// Update state of all towns
		[playerRespawn_towns, {
			_value set [1, [_value select 0] call BL_fnc_friendlyState];
		}] call CBA_fnc_hashEachPair;
		
		[playerRespawnOptions, 'towns', [playerRespawn_towns] call BL_fnc_townRespawnOptions] call CBA_fnc_hashSet;
		[playerRespawnOptions, 'airVehicles', [playerRespawn_air] call BL_fnc_flyingRespawnOptions] call CBA_fnc_hashSet;
		[playerRespawnOptions, 'beacons', [playerRespawn_beacons] call BL_fnc_beaconRespawnOptions] call CBA_fnc_hashSet;

		['respawnDialogUpdate'] call CBA_fnc_localEvent;
	}] call CBA_fnc_addEventHandler;

	// Do an update of all beacons
	[playerRespawnOptions, 'beacons', [playerRespawn_beacons] call BL_fnc_beaconRespawnOptions] call CBA_fnc_hashSet;
	['respawnDialogUpdate'] call CBA_fnc_localEvent;
	
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

private ['_beaconText'];
_beaconText = "
	private ['_owner', '_text'];
	_owner = objNull;
	_text = '<t color=''%1''>%2 beacon';
	
	{
		if ( (_x select 2) == (_this select 0) ) exitwith {
			_owner = [_x select 1] call BL_fnc_playerByUID;
		};
	} count BL_spawnBeacons;
	
	if ( [[_owner]] call BL_fnc_friendlyState == 'FRIENDLY' ) then {
		_text = _text + ' (Friendly)';
	}
	else {
		if ( !isNull _owner ) then {
			_text = _text + ' (Enemy)';
		};
	};

	_text + '</t>';
";

[compile format[_beaconText, '#3cff00', 'Repack'], _condition,
{
	[60, "Repacking Beacon %1", _this, {
		(format['%1Beacon', (_this select 0) getVariable 'beaconType']) call BL_fnc_addInventoryItem;
		[_this select 0] call BL_fnc_destroySpawnBeacon;
	}] call BL_fnc_animDoWork;
}, 1] call BL_fnc_addAction;

[compile format[_beaconText, '#ff0000', 'Destroy'], _condition,
{
	[30, "Destroying Beacon %1", _this, {
		[_this select 0] call BL_fnc_destroySpawnBeacon;
	}] call BL_fnc_animDoWork;
}, 1] call BL_fnc_addAction;