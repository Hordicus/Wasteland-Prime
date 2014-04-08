player addEventHandler ['HandleDamage', {
	_player = _this select 0;
	_attacker = _this select 3;
	_dmg = _this select 2;
	
	if ( _attacker in (units group player) || ( playerSide in [east,west] && playerSide == side _attacker ) ) then {
		_attacker setDamage ((damage _attacker) + ((_this select 2) * 0.2)); // Reflect 20% damage
		damage player
	}
	else {
		_this select 2
	};
}];