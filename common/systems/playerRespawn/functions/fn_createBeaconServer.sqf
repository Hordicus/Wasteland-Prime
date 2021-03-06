private ["_type","_ownerUID","_loc","_dir","_model","_beacon","_info","_blockRadius"];
_type     = [_this, 0, "ground", [""]] call BIS_fnc_param;
_ownerUID = [_this, 1, "", [""]] call BIS_fnc_param;
_loc      = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_dir      = [_this, 3, 0, [0]] call BIS_fnc_param;
_beacon   = [_this, 4, objNull, [objNull]] call BIS_fnc_param;

if ( isNull _beacon ) then {
	_model = (format['%1BeaconModel', _type]) call BL_fnc_config;
	_beacon = createVehicle [_model, _loc, [], 0, "CAN_COLLIDE"];
	_beacon setDir _dir;
	_beacon setVariable ['objectOwner', _ownerUID, true];
	_beacon setVariable ['beaconType', _type, true];

	[_beacon, 'spawnBeacon'] call BL_fnc_trackVehicle;
	[_beacon] call BL_fnc_saveVehicle;
};

_info = [
	_type,
	_ownerUID,
	_beacon,
	10 call BL_fnc_randStr
];

BL_spawnBeacons = missionNamespace getVariable ['BL_spawnBeacons', []];
BL_spawnBeacons set [count BL_spawnBeacons, _info];

publicVariable "BL_spawnBeacons";

if ( surfaceIsWater _loc ) then {
	_loc = ATLtoASL _loc;
};

_blockRadius = 0;
if ( _type == 'air' ) then {
	_blockRadius = 'airBeaconBlockRadius' call BL_fnc_config;
}
else {
	_blockRadius = 'groundBeaconBlockRadius' call BL_fnc_config;
};

[
	_loc,
	_blockRadius,
	'beaconUpdate',
	[_info select 3]
] call BL_fnc_registerLocWithRadar;