private ['_player', '_playerUID'];
_player = [_this, 0, player, [player]] call BIS_fnc_param;
_playerUID = getPlayerUID _player;

["INSERT INTO `players` (`created`, `uid`, `name`, `last_login`, `side`) VALUES (NOW(), '%1', '%2', NOW(), '%3');", [_playerUID, name _player, str side _player]] call BL_fnc_MySQLCommand;