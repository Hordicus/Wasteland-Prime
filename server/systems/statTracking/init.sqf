statTrackingQueue = [];
playerBounty = [[], 1] call CBA_fnc_hashCreate;

// Player bounty
['killed', {
	private ["_player","_killer","_bounty","_moneyToGive"];
	_player = _this select 0;
	_killer = _this select 1;
	_bounty = [playerBounty, name _player] call CBA_fnc_hashGet;
	
	// Reset players bounty
	[playerBounty, name _player, 1] call CBA_fnc_hashSet;
	
	if ( _player != _killer && isPlayer _killer) then {
		// Add to killer's bounty
		[playerBounty, name _killer, ([playerBounty, name _killer] call CBA_fnc_hashGet)+1] call CBA_fnc_hashSet;
	
		// Give killer their money
		_moneyToGive = ('killBounty' call BL_fnc_config) * _bounty;
		_killer setVariable ['money', (_killer getVariable ['money', 0]) + _moneyToGive, true];
		
		[format['$%1 bounty awarded for killing %2', _moneyToGive, name _player], "BL_fnc_systemChat", owner _killer] spawn BIS_fnc_MP;
	};
}] call CBA_fnc_addEventHandler;

// Database logging
['killed', {
	private ["_player","_killer","_weapon","_friendlyFire"];
	_player = _this select 0;
	_killer = _this select 1;
	
	_friendlyFire = ([[_killer], _player] call BL_fnc_friendlyState) == "FRIENDLY";

	if ( _player != _killer && isPlayer _killer ) then {
		statTrackingQueue set [count statTrackingQueue, [
			getPlayerUID _player,
			getPlayerUID _killer,
			currentWeapon _player,
			currentWeapon _killer,
			getPosATL _player,
			getPosATL _killer,
			_friendlyFire
		]];
	
		if ( count statTrackingQueue >= 10 ) then {
			private ["_queue","_command","_values"];
			_queue = +statTrackingQueue;
			statTrackingQueue = [];
			
			_command = "INSERT INTO `playerkills` (`timestamp`, `player_uid`, `killer_uid`, `player_weapon`, `killer_weapon`, `player_pos`, `killer_pos`, `friendly`) VALUES ";
			_values = [];
		
			{
				_values set [_forEachIndex, format(["(UNIX_TIMESTAMP(), '%1', '%2', '%3', %4, '%5', '%6', '%7')"] + ([_x] call BL_fnc_noEmptyArrayValues))];
			} forEach _queue;
			
			_command = _command + ([_values, ','] call CBA_fnc_join);
			[_command] call BL_fnc_MySQLCommand;
		};
	};
}] call CBA_fnc_addEventHandler;