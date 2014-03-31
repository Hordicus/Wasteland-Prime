private ["_type","_ownerUID","_loc","_dir","_model","_beacon"];
_type     = [_this, 0, "ground", [""]] call BIS_fnc_param;
_ownerUID = [_this, 1, "", [""]] call BIS_fnc_param;
_loc      = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_dir      = [_this, 3, 0, [0]] call BIS_fnc_param;
_beacon   = [_this, 4, objNull, [objNull]] call BIS_fnc_param;

if ( isNull _beacon ) then {
	_model = (format['%1BeaconModel', _type]) call BL_fnc_config;
	_beacon = createVehicle [_model, _loc, [], 0, "CAN_COLLIDE"];
	_beacon setDir _dir;
	_beacon setVariable ['objectOwner', _ownerUID];
	_beacon setVariable ['beaconType', _type];

	[_beacon, 'spawnBeacon'] call BL_fnc_trackVehicle;
	[_beacon] call BL_fnc_saveVehicle;
};

BL_spawnBeacons = missionNamespace getVariable ['BL_spawnBeacons', []];
BL_spawnBeacons set [count BL_spawnBeacons, [
	_type,
	_ownerUID,
	_beacon
]];

publicVariable "BL_spawnBeacons";

[
	_loc,
	100,
	'beaconUpdate',
	[_ownerUID]
] call BL_fnc_registerLocWithRadar;