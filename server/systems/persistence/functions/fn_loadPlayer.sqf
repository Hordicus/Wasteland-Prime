private ['_player', '_playerUID', '_result'];
_player = [_this, 0, player, [player]] call BIS_fnc_param;
_playerUID = getPlayerUID _player;

_result = (["SELECT `damage`, `pos_x`, `pos_y`, `pos_z`, `gear`, `animation`, `direction`, `money`, `playerInv` FROM `players` WHERE `uid` = '%1' AND `side` = '%2'", [_playerUID, str side _player]] call BL_fnc_MySQLCommandSync) select 0;

if ( count _result == 1 ) then {
	_result = _result select 0;
	_player setVariable ['money', _result select 7, true];
	
	if ( _result select 0 < 1 ) then {
		_player setDamage (_result select 0);
		_player setPosATL [
			_result select 1,
			_result select 2,
			_result select 3
		];
		
		_player setVariable ['BL_playerInv', _result select 8, true];
		
		PVAR_playerLoaded = [
			_result select 4,
			_result select 5,
			_result select 6
		];
	}
	else {
		// Indicates player logged out dead.
		PVAR_playerLoaded = [true];
	};
	
	(owner _player) publicVariableClient "PVAR_playerLoaded";
	
	// Update last login
	["UPDATE `players` SET `last_login` = NOW() WHERE `uid` = '%1' AND `side` = '%2'", [_playerUID, str side _player]] call BL_fnc_MySQLCommand;
}
else {
	// No record for player. Add to db.
	[_player] call BL_fnc_createPlayer;
	
	PVAR_playerLoaded = [];
	(owner _player) publicVariableClient "PVAR_playerLoaded";
};