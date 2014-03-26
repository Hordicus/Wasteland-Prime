private ['_player', '_playerUID'];
_player = [_this, 0, player, [player]] call BIS_fnc_param;
_playerUID = getPlayerUID _player;

["SELECT `damage`, `pos_x`, `pos_y`, `pos_z`, `gear` FROM `players` WHERE `uid` = '%1'", [_playerUID], [_player, _playerUID], {
	_result = _this select 0 select 0 select 0;
	_player = _this select 1 select 0;
	
	_player setDamage parseNumber (_result select 0);
	_player setPosATL [
		parseNumber (_result select 1),
		parseNumber (_result select 2),
		parseNumber (_result select 3)
	];
	
	// [player, (_result select 4), ["ammo"]] call GEAR_fnc_setLoadout;
	
	PVAR_playerLoaded = [[(call compile (_result select 4))] call BL_fnc_emptyArrayValues];
	(owner _player) publicVariableClient "PVAR_playerLoaded";
	
	// Update last login
	["UPDATE `players` SET `last_login` = NOW() WHERE `uid` = '%1'", [_this select 1 select 1]] call BL_fnc_MySQLCommand;
}] call BL_fnc_MySQLCommand;