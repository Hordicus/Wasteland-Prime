[] spawn {
	_noFriendlyFire = {
		private ['_player', '_attacker', '_dmg'];
		_player = _this select 0;
		_attacker = _this select 3;
		_dmg = _this select 2;
		
		if ( alive _player && _player != _attacker && (_attacker in (units group player) || ( playerSide in [east,west] && side player == side _attacker )) ) then {
			_attacker setDamage ((damage _attacker) + ((_this select 2) * 0.2)); // Reflect 20% damage
			damage _player
		}
		else {
			_this select 2
		};
	};
	
	player addEventHandler ['HandleDamage', _noFriendlyFire];

	_veh = vehicle player;
	while { true } do {
		waitUntil { _veh != vehicle player };
		_veh removeEventHandler ['HandleDamage', _veh getVariable ['noFFEH', -1]];
		_veh = vehicle player;
		
		_veh setVariable ['noFFEH', _veh addEventHandler ['HandleDamage', _noFriendlyFire]];
	};
};