#include "\x\cba\addons\main\script_macros_common.hpp"

private ["_players", "_friendlies"];
_players = _this;
_friendlies = [];

{
	if ( player != _x ) then {
		if ( playerSide in [east, west] ) then {
			if ( playerSide == side _x ) then {
				_friendlies set [count _friendlies, _x];
			};
		}
		else {
			if ( group player == group _x ) then {
				_friendlies set [count _friendlies, _x];
			};
		};
	}
	else {
		_friendlies set [count _friendlies, _x];
	};
} forEach _players;

_friendlies