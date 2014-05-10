private ["_flags","_result","_state","_friendly", "_owner", "_spawnOnFlag", "_nearestCity", "_info"];
_flags = [_this, 0, [[], [[], "EMPTY"]] call CBA_fnc_hashCreate, [[]], [4]] call BIS_fnc_param;
_result = [];

_spawnOnFlag = {
	private ['_type', '_loc', '_dir'];
	player setPosATL ([(_this select 2), 3, random 359] call BIS_fnc_relPos);
	
	closeDialog 0;
};

{
	_owner = (_x select 1) call BL_fnc_playerByUID;
	_state = ([_flags, (_x select 0)] call CBA_fnc_hashGet) select 1;
	_friendly = [[_owner, player]] call BL_fnc_friendlyState;

	if ( _friendly == "FRIENDLY" ) then {
		_nearestCity = [_x select 2] call BL_fnc_nearestCity;
		
		_info = format['Base beacon %1 of %2',
			[(_nearestCity select 1), (_x select 2)] call BL_fnc_directionToString,
			_nearestCity select 0
		];
	
		_result set [count _result, [
			name _owner,
			_info,
			_x select 2,
			_state in ["MIXED", "ENEMY"],
			_x,
			_spawnOnFlag
		]];
	};
} forEach BL_PVAR_baseFlags;

_result