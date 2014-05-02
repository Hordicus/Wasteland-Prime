private ['_player', '_playerIndex'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_playerIndex = [_player] call BL_fnc_playerIndex;

if ( _playerIndex == -1 ) exitwith { [] };

BL_scoreboard select _playerIndex