private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_player addEventHandler ["killed", {
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
		
		[format['$%1 bounty awarded for killing %2', _moneyToGive, name _player], "BL_fnc_systemChat"] spawn BIS_fnc_MP;
	};
}];