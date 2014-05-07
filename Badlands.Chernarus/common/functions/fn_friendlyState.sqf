#include "\x\cba\addons\main\script_macros_common.hpp"

private ["_players","_friendlyTo","_enemy","_friendly","_state"];
_players = [_this, 0, [], [[]]] call BIS_fnc_param;
_friendlyTo = [_this, 1, player, [objNull]] call BIS_fnc_param;
_enemy = 0;
_friendly = 0;
_state = "";

{
	if ( _friendlyTo != _x ) then {
		if ( (_friendlyTo getVariable ['side', civilian]) in [east, west] ) then {
			if ( (_friendlyTo getVariable ['side', civilian]) == (_x getVariable ['side', civilian]) ) then {
				INC(_friendly);
			}
			else {
				INC(_enemy);
			};
		}
		else {
			if ( group _friendlyTo == group _x ) then {
				INC(_friendly);
			}
			else {
				INC(_enemy);
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