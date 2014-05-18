statTrackingQueue = [];
playerBounty = [[], 1] call CBA_fnc_hashCreate;
BL_scoreboard = [];
BL_playerBountyAmount = [call BL_fnc_statTrackingConfig, "playerBounty"] call CBA_fnc_hashGet;
BL_aiBountyAmount = [call BL_fnc_statTrackingConfig, "aiBounty"] call CBA_fnc_hashGet;
BL_scoreboardLookup = [];
BL_totalPoints = [[], 0] call CBA_fnc_hashCreate;
BL_addPointsLog = [];
BL_addPointsLogMaxSize = [call BL_fnc_statTrackingConfig, "addPointsLogMaxSize"] call CBA_fnc_hashGet;
BL_statTrackingQueueMaxSize = [call BL_fnc_statTrackingConfig, "statTrackingQueueMaxSize"] call CBA_fnc_hashGet;

[] spawn {
	private ['_lastBroadcast'];
	_lastBroadcast = [];
	
	// Broadcast BL_scoreboard up to once a second, but only if
	// it has changed.
	while { true } do {
		sleep 5;
		
		if !( _lastBroadcast isEqualTo BL_scoreboard ) then {
			_lastBroadcast = +BL_scoreboard;
			publicVariable "BL_scoreboard";
		};
	};
};

// Player bounty
['killed', {
	private ["_player","_killer","_bounty","_playerName","_killerName"];
	_player = _this select 0;
	_killer = [_this select 1] call BL_fnc_getKiller;

	_killerName = _killer getVariable 'name';
	_playerName = _player getVariable 'name';
	_bounty = 0;
	
	if ( isPlayer _player ) then {
		// Reset players bounty
		[playerBounty, _playerName, 1] call CBA_fnc_hashSet;
		
		_bounty = BL_playerBountyAmount * ([playerBounty, _playerName] call CBA_fnc_hashGet);
	}
	else {
		_bounty = _player getVariable ['bounty', BL_aiBountyAmount];
	};
	
	if ( _player != _killer && isPlayer _killer && isPlayer _player ) then {
		// Add to killer's bounty
		[playerBounty, _killerName, ([playerBounty, _killerName] call CBA_fnc_hashGet)+1] call CBA_fnc_hashSet;	
	};
	
	if ( _player != _killer ) then {
		[_bounty, _killer] call BL_fnc_addMoney;
	};
}] call CBA_fnc_addEventHandler;

// Database logging
['killed', {
	private ["_player","_killer","_weapon","_friendlyFire","_playerVehicle","_killerVehicle"];
	_player = _this select 0;
	_killer = [_this select 1] call BL_fnc_getKiller;
	
	_friendlyFire = ([[_killer], _player] call BL_fnc_friendlyState) == "FRIENDLY";
	
	_playerVehicle = typeOf vehicle _player;
	_killerVehicle = typeOf vehicle _killer;
	
	if ( _playerVehicle isKindOf "Man" ) then {
		_playerVehicle = "NULL";
	};
	
	if ( _killerVehicle isKindOf "Man" ) then {
		_killerVehicle = "NULL";
	};

	statTrackingQueue set [count statTrackingQueue, [
		BL_sessionStart,
		_player getVariable 'uid',
		_killer getVariable 'uid',
		currentWeapon _player,
		currentWeapon _killer,
		_playerVehicle,
		_killerVehicle,
		getPosATL _player,
		getPosATL _killer,
		(if(_friendlyFire) then {1} else {0})
	]];

	if ( count statTrackingQueue >= BL_statTrackingQueueMaxSize ) then {
		private ["_queue","_command","_values"];
		_queue = +statTrackingQueue;
		statTrackingQueue = [];
		
		_command = "INSERT INTO `player_kills` (`session`, `player_uid`, `killer_uid`, `player_weapon`, `killer_weapon`, `player_veh`, `killer_veh`, `player_pos`, `killer_pos`, `friendly`) VALUES ";
		_values = [];
	
		{
			_values set [_forEachIndex, format(["('%1', '%2', '%3', '%4', '%5', '%6', '%7', '%8', '%9', '%10')"] + ([_x] call BL_fnc_noEmptyArrayValues))];
		} forEach _queue;
		
		_command = _command + ([_values, ','] call CBA_fnc_join);
		[_command] call BL_fnc_MySQLCommand;
	};
}] call CBA_fnc_addEventHandler;

// Scoreboard
// [_rank, _side, _playerName, _bounty, _kills, _deaths, _score ],
['killed', BL_fnc_statTrackingKilledHandler] call CBA_fnc_addEventHandler;

['respawn', {
	private ['_player', '_playerIndex'];
	_player = _this select 0;	
	_player setVariable ['name', name _player];
	_player setVariable ['side', side _player];
	_player setVariable ['uid', getPlayerUID _player];
}] call CBA_fnc_addEventHandler;

// Add player to scoreboard on connect
['initPlayerServer', {
	private ['_player', '_playerIndex'];
	_player = _this select 0;
	_player setVariable ['name', name _player];
	_player setVariable ['side', side _player];
	_player setVariable ['uid', getPlayerUID _player];
	
	_points = (["SELECT SUM(`points`) FROM `player_points` WHERE `player_uid` = '%1'", [getPlayerUID _player]] call BL_fnc_MySQLCommandSync) select 0 select 0 select 0;
	[BL_totalPoints, getPlayerUID _player, _points] call CBA_fnc_hashSet;
	
	// Player could be reconnecting. Don't add player if they are already on the scoreboard
	_playerIndex = BL_scoreboardLookup find (format['%1%2', side _player, name _player]);
	if ( _playerIndex > -1 ) exitwith{};
	
	_index = count BL_scoreboard;
	BL_scoreboard set [_index, [
		[_points] call BL_fnc_pointsToRank,
		side _player,
		name _player,
		BL_playerBountyAmount,
		0,
		0,
		0
	]];
	
	BL_scoreboardLookup set [_index, format['%1%2', side _player, name _player]];
}] call CBA_fnc_addEventHandler;