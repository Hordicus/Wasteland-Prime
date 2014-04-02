private ['_player', '_playerUID', '_position'];
_player = [_this, 0, player, [player]] call BIS_fnc_param;
_playerUID = getPlayerUID _player;

_position = getPosATL _player;
["UPDATE `players` SET
`name` = '%1',
`damage` = %2,
`pos_x` = %3,
`pos_y` = %4,
`pos_z` = %5,
`gear` = '%6',
`animation` = '%7',
`direction` = %8,
`money` = %9,
`playerInv` = '%10'
WHERE `uid` = '%11'", [
	name _player,
	damage _player,
	_position select 0,
	_position select 1,
	_position select 2,
	[_player, ["repetitive" ]] call BL_fnc_getLoadout,
	animationState _player,
	getDir _player,
	_player getVariable ['money', 0],
	_player getVariable ['BL_playerInv', []],
	_playerUID
]] call BL_fnc_MySQLCommand;