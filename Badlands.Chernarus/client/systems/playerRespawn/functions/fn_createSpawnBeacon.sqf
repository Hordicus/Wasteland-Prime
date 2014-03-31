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

private['_type', '_loc', '_dir', '_owner'];
_type  = [_this, 0, 'air', ['']] call BIS_fnc_param;
_loc   = [_this, 1, [], [[]], [3]] call BIS_fnc_param;
_dir   = [_this, 2, 0, [0]] call BIS_fnc_param;
_ownerUID = [_this, 3, getPlayerUID player, ['']] call BIS_fnc_param;

_data = [
	_type,
	_ownerUID,
	_loc,
	_dir
];

createSpawnBeacon = _data;
publicVariableServer "createSpawnBeacon";

_data