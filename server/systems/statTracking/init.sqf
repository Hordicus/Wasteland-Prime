statTrackingQueue = [];
playerBounty = [[], 1] call CBA_fnc_hashCreate;
BL_scoreboard = [];
BL_bountyAmount = ('killBounty' call BL_fnc_config);
BL_scoreboardLookup = [];

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

// Scoreboard
// [_rank, _side, _playerName, _bounty, _kills, _deaths, _score ],
['killed', {
	private ['_player', '_killer', '_killerIndex'];
	_player = _this select 0;
	_killer = _this select 1;

	if ( _killer != _player && isPlayer _killer ) then {
		_killerIndex = BL_scoreboardLookup find (format['%1%2', side _killer, name _killer]);
		
		if ( _killerIndex == -1 ) exitwith{};
		
		// Update killer's bounty
		(BL_scoreboard select _killerIndex) set [3,
			([playerBounty, name _killer] call CBA_fnc_hashGet)*BL_bountyAmount
		];
		
		// Add one to killers' kills
		(BL_scoreboard select _killerIndex) set [5,
			((BL_scoreboard select _killerIndex) select 5) + 1
		];
	};
	
	// Respawn will be triggered next, broadcast then.
}] call CBA_fnc_addEventHandler;

['respawn', {
	private ['_player', '_playerIndex'];
	_player = _this select 0;	
	_playerIndex = BL_scoreboardLookup find (format['%1%2', side _player, name _player]);

	if ( _playerIndex == -1 ) exitwith{};

	// Update player bounty
	(BL_scoreboard select _playerIndex) set [3, BL_bountyAmount];
		
	// Add one to player's deaths
	(BL_scoreboard select _playerIndex) set [5,
		((BL_scoreboard select _playerIndex) select 5) + 1
	];

	publicVariable "BL_scoreboard";
}] call CBA_fnc_addEventHandler;

// Add player to scoreboard on connect
['initPlayerServer', {
	private ['_player'];
	_player = _this select 0;
	
	_index = count BL_scoreboard;
	BL_scoreboard set [_index, [
		1,
		side _player,
		name _player,
		BL_bountyAmount,
		0,
		0,
		0
	]];
	
	BL_scoreboardLookup set [_index, format['%1%2', side _player, name _player]];
	
	publicVariable "BL_scoreboard";
}] call CBA_fnc_addEventHandler;