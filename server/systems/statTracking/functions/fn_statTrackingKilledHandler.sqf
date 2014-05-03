private ['_player', '_killer', '_playerIndex', '_playerVehicle'];
_player = _this select 0;
_killer = _this select 1;

_playerIndex = -1;
_playerVehicle = typeOf vehicle _player;

if ( isPlayer _player ) then {
	_playerIndex = BL_scoreboardLookup find (format['%1%2', _player getVariable 'side', _player getVariable 'name']);
};

if ( isPlayer _player && isPlayer _killer ) then {
	[_player, _killer] call BL_fnc_sendKillMsg;
};

if ( _playerIndex > -1 ) then {
	// Update player bounty
	(BL_scoreboard select _playerIndex) set [3, BL_bountyAmount];
		
	// Add one to player's deaths
	(BL_scoreboard select _playerIndex) set [5,
		((BL_scoreboard select _playerIndex) select 5) + 1
	];

	// Add to players score
	[_player, "death"] call BL_fnc_addPoints;		
};

if ( _killer != _player && isPlayer _killer ) then {
	private ['_killerIndex'];
	_killerIndex = BL_scoreboardLookup find (format['%1%2', side _killer, name _killer]);
	
	if ( _killerIndex == -1 ) exitwith{};
	
	// Update killer's bounty
	(BL_scoreboard select _killerIndex) set [3,
		([playerBounty, name _killer] call CBA_fnc_hashGet)*BL_bountyAmount
	];
	
	if ( isPlayer _player ) then {
		// Add one to killers' kills
		(BL_scoreboard select _killerIndex) set [5,
			((BL_scoreboard select _killerIndex) select 5) + 1
		];
	
		// Add to killer score
		[_killer, 'playerKill'] call BL_fnc_addPoints;
	}
	else {
		[_killer, 'aiKill'] call BL_fnc_addPoints;
	};
	
	// Bonus points for killing player in vehicle

	if !( _playerVehicle isKindOf "Man" ) then {
		private ['_vehicles', '_bonus', '_parent'];
		_vehicles = [call BL_fnc_statTrackingConfig, 'vehicleBonus'] call CBA_fnc_hashGet;
		_bonus = 0;
	
		if ( !isNil { [_vehicles, _playerVehicle] call CBA_fnc_hashGet } ) then {
			_bonus = [_vehicles, _playerVehicle] call CBA_fnc_hashGet;
		}
		else {
			_parent = _playerVehicle;
			while { _parent != "All" } do {
				_parent = configName inheritsFrom (configFile >> "CfgVehicles" >> _parent);

				if ( !isNil {[_vehicles, _parent] call CBA_fnc_hashGet} ) exitwith {
					_bonus = [_vehicles, _parent] call CBA_fnc_hashGet;
				};
			};
		};

		[_killer, _bonus, "vehicleBonus"] call BL_fnc_addPoints;
	};
};
