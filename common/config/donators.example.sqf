private ['_config'];
_config = [] call CBA_fnc_hashCreate;

// Database to use for donator info
[_config, 'database', 'badlands'] call CBA_fnc_hashSet;

/*
	Functions to run for each tier
	_this select 0: player
*/
[_config, 'tiers', [
	{
		private ['_player'];
		_player = _this select 0;
		if ( [_player] call BL_fnc_money < 1000 ) then {
			_player setVariable ['money', 1000, true];
		};
	},
	{
		private ['_player'];
		_player = _this select 0;
		if ( [_player] call BL_fnc_money < 2000 ) then {
			_player setVariable ['money', 2000, true];
		};
	},
	{
		private ['_player'];
		_player = _this select 0;
		if ( [_player] call BL_fnc_money < 3000 ) then {
			_player setVariable ['money', 3000, true];
		};
	},
	{
		private ['_player'];
		_player = _this select 0;
		if ( [_player] call BL_fnc_money < 4000 ) then {
			_player setVariable ['money', 4000, true];
		};
	},
	{
		private ['_player'];
		_player = _this select 0;
		if ( [_player] call BL_fnc_money < 5000 ) then {
			_player setVariable ['money', 5000, true];
		};
	}
]] call CBA_fnc_hashSet;

_config