/*
	Description:
	Creates a spawn beacon and updates other clients
	
	Parameter(s):
	_type     - Type of beacon. Air or ground.
	_loc      - Where the beacon should be created
	_dir      - Direction that players will be spawned facing
	_ownerUID - Optional - UID of the player who owns the beacon
	
	Returns:
	Array - Data that will be added to BL_spawnBeacons
*/

private['_type', '_loc', '_dir', '_owner', '_model', '_data', '_veh'];
_type  = [_this, 0, 'air', ['']] call BIS_fnc_param;
_loc   = [_this, 1, [], [[]], [3]] call BIS_fnc_param;
_dir   = [_this, 2, 0, [0]] call BIS_fnc_param;
_ownerUID = [_this, 3, getPlayerUID player, ['']] call BIS_fnc_param;

_model = (format['%1BeaconModel', _type]) call BL_fnc_config;

_veh = createVehicle [_model, _loc, [], 0, "CAN_COLLIDE"];
_veh setDir _dir;

_data = [
	_type,
	_ownerUID,
	_loc,
	_dir,
	_veh
];

BL_spawnBeacons = BL_spawnBeacons + [_data];
publicVariable "BL_spawnBeacons";

createSpawnBeacon = _data;
publicVariableServer "createSpawnBeacon";

_data