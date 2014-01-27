#include "\x\cba\addons\main\script_macros_common.hpp"

private ["_players", "_enemy", "_friendly", "_state"];
_players = _this;
_enemy = 0;
_friendly = 0;
_state = "";

{
	if ( player != _x ) then {
		if ( playerSide in [east, west] ) then {
			if ( playerSide == side _x ) then {
				INC(_friendly);
			}
			else {
				INC(_enemy);
			};
		}
		else {
			if ( group player == group _x ) then {
				INC(_friendly);
			}
			else {
				INC(_friendly);
			};
		};
	}
	else {
		INC(_friendly);
	};
} forEach _players;

if ( _enemy > 0 && _friendly > 0 ) then {
	_state = "MIXED";
};

if ( _enemy == 0 && _friendly > 0 ) then {
	_state = "FRIENDLY";
};

if ( _enemy > 0 && _friendly == 0 ) then {
	_state = "ENEMY";
};

if ( _enemy == 0 && _friendly == 0 ) then {
	_state = "EMPTY";
};

_state