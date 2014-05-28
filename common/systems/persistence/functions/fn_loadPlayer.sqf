private ['_player', '_playerUID'];
_player = [_this, 0, player, [player]] call BIS_fnc_param;
_playerUID = getPlayerUID _player;

["SELECT `damage`, `pos_x`, `pos_y`, `pos_z`, `gear`, `animation`, `direction`, `money`, `playerInv` FROM `players` WHERE `uid` = '%1' AND `side` = '%2'", [_playerUID, str side _player], [_player, _playerUID], {
	private ['_player', '_playerUID', '_result', '_position'];
	_player = _this select 1 select 0;
	_playerUID = _this select 1 select 1;
	_result = _this select 0 select 0;
	
	if ( count _result == 1 ) then {
		_result = _result select 0;
		_player setVariable ['money', _result select 7, true];
		_position = [
			_result select 1,
			_result select 2,
			_result select 3
		];
		
		if ( _result select 0 < 1 && (
			(getMarkerPos 'respawn_west') distance _position > 100 &&
			(getMarkerPos 'respawn_east') distance _position > 100 &&
			(getMarkerPos 'respawn_guerrila') distance _position > 100		
		)) then {
			_player setDamage (_result select 0);
			_player setPosATL _position;
			
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
}] call BL_fnc_MySQLCommand;