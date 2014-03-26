private ['_player', '_playerUID'];
_player = [_this, 0, player, [player]] call BIS_fnc_param;
_playerUID = getPlayerUID _player;

diag_log format['Loading player with UID %1', _playerUID];

["SELECT `damage`, `pos_x`, `pos_y`, `pos_z`, `gear`, `animation`, `direction` FROM `players` WHERE `uid` = '%1'", [_playerUID], [_player, _playerUID], {
	private ['_result', '_player'];
	_result = _this select 0 select 0;
	_player = _this select 1 select 0;
	
	if ( count _result == 1 ) then {
		_result = _result select 0;
		
		_player setDamage parseNumber (_result select 0);
		_player setPosATL [
			parseNumber (_result select 1),
			parseNumber (_result select 2),
			parseNumber (_result select 3)
		];
		
		PVAR_playerLoaded = [
			[(call compile (_result select 4))] call BL_fnc_emptyArrayValues,
			_result select 5,
			parseNumber (_result select 6)
		];
		(owner _player) publicVariableClient "PVAR_playerLoaded";
		
		// Update last login
		["UPDATE `players` SET `last_login` = NOW() WHERE `uid` = '%1'", [_this select 1 select 1]] call BL_fnc_MySQLCommand;
	}
	else {
		// No record for player. Add to db.
		[_player] call BL_fnc_createPlayer;
		
		PVAR_playerLoaded = [];
		(owner _player) publicVariableClient "PVAR_playerLoaded";
	};
}] call BL_fnc_MySQLCommand;