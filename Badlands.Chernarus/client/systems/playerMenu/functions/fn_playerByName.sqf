/*
	Description:
	Finds player by name and returns the
	player object.
	
	Parameter(s):
	_player_name - Name of player to search forEach
	_players - Array of players to search though. Default: allUnits
	
	Returns:
	player or objNull
*/

private ['_player_name', '_players', '_unit'];
_player_name = [_this, 0, "", [""]] call BIS_fnc_param;
_players   = [_this, 1, playableUnits, [[]]] call BIS_fnc_param;

_unit = objNull;

{	
	if ( name _x == _player_name ) exitwith {
		_unit = _x;
	};
} forEach _players;

_unit