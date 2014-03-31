private ['_player', '_playerUID'];
_player = [_this, 0, player, [player]] call BIS_fnc_param;
_playerUID = getPlayerUID _player;

["INSERT INTO `players` (`created`, `uid`, `name`, `last_login`) VALUES (NOW(), '%1', '%2', NOW());", [_playerUID, name _player]] call BL_fnc_MySQLCommand;