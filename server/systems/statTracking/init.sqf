statTrackingQueue = [];

['killed', {
	private ["_player","_killer","_weapon","_friendlyFire"];
	_player = _this select 0;
	_killer = _this select 1;
	
	_weapon = currentWeapon _killer;
	_friendlyFire = ([[_killer], _player] call BL_fnc_friendlyState) == "FRIENDLY";

	if ( _player != _killer && isPlayer _killer ) then {
		statTrackingQueue set [count statTrackingQueue, [
			getPlayerUID _player,
			getPlayerUID _killer,
			_weapon,
			_friendlyFire,
			getPosATL _player,
			getPosATL _killer
		]];
	
		if ( count statTrackingQueue >= 10 ) then {
			private ["_queue","_command","_values"];
			_queue = +statTrackingQueue;
			statTrackingQueue = [];
			
			_command = "INSERT INTO `playerkills` (`timestamp`, `player_uid`, `killer_uid`, `weapon`, `friendly`, `playerpos`, `killerpos`) VALUES ";
			_values = [];
		
			{
				_values set [_forEachIndex, format(["(UNIX_TIMESTAMP(), '%1', '%2', '%3', %4, '%5', '%6')"] + ([_x] call BL_fnc_noEmptyArrayValues))];
			} forEach _queue;
			
			_command = _command + ([_values, ','] call CBA_fnc_join);
			[_command] call BL_fnc_MySQLCommand;
		};
	};
}] call CBA_fnc_addEventHandler;