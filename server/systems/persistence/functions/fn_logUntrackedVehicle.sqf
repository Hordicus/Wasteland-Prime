private ['_obj', '_owner', '_city', '_dir', '_location', '_msg', '_nearPlayers', '_info'];
_obj = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_owner = objNull;

// Find player object with same owner as obj
{
	if ( owner _obj == owner _x ) then {
		_owner = _x;
	};
	true
} count playableUnits;

_city = [getPosATL _obj] call BL_fnc_nearestCity;
(_city select 1) set [2, 0];

_dir = [_city select 1, getPosATL _obj] call BIS_fnc_dirTo;
_location = format['%1m %2 of %3', (_city select 1) distance _obj, [_dir, true] call BL_fnc_azimuthToBearing, _city select 0];

_msg = format["Untracked Object: %1, netId: %3, Owner: %4 (%5, %6), Position: %7 (%8), Near Players (100m):
",
	typeOf _obj,
	_obj,
	netId _obj,
	name _owner,
	owner _owner,
	getPlayerUID _owner,
	_location,
	getPosATL _obj
];

_nearPlayers = [getPosATL _obj, 100] call BL_fnc_nearUnits;
_info = [];

{
	_info set [_forEachIndex, format["%1 (%2, %3)", name _x, owner _x, getPlayerUID _x]];
	true
} forEach _nearPlayers;

_msg = _msg + ([_info, "
"] call CBA_fnc_join);

diag_log _msg;
['security', _msg] call BL_fnc_log;

nil