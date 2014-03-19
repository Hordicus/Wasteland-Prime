#include "macro.sqf"

private ["_beacons","_result","_ownerUID","_state","_friendlyBeacon", "_owner", "_spawnOnBeacon", "_nearestCity", "_info"];
_beacons = [_this, 0, [] call CBA_fnc_hashCreate, [[]], [4]] call BIS_fnc_param;
_result = [];

_spawnOnBeacon = {
	private ['_type', '_loc', '_dir'];
	_type = _this select 0;
	_loc = _this select 2;
	_dir = _this select 3;
	
	if ( _type == 'air' ) then {
		_loc set [2, 1000];
		player setPosATL _loc;
		[player, 1000, false, false, true] call COB_fnc_HALO;
	}
	else {
		player setPosATL _loc;
	};
	
	closeDialog respawnDialogIDD;
};

{
	private ['_state'];
	_ownerUID = _x select 1;
	_owner = _ownerUID call BL_fnc_playerByUID;
	_state = ([_beacons, _ownerUID] call CBA_fnc_hashGet) select 1;
	_friendlyBeacon = [_owner, player] call BL_fnc_friendlyState;
	
	if ( _friendlyBeacon == "FRIENDLY" ) then {
		_nearestCity = (_x select 1) call BL_fnc_nearestCity;
		
		_info = format['%1 beacon %2 of %3 facing %4',
			_x select 0,
			[(_nearestCity select 1), _x select 2] call BL_fnc_directionToString,
			_nearestCity select 0,
			[(_x select 3), true] call BL_fnc_azimuthToBearing
		];
	
		_result set [count _result, [
			name _owner,
			_info,
			round((_x select 2) distance playerRespawn_lastDeath),
			_state in ["MIXED", "ENEMY"],
			_x,
			_spawnOnBeacon
		]];
	};
} forEach BL_spawnBeacons;

_result