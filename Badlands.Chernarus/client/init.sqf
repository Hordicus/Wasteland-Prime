execVM 'client\systems\townRadar\init.sqf';
execVM 'client\systems\playerRespawn\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';

waitUntil {!isNull player && player == player};
waitUntil{!isNil "BIS_fnc_init"};
waitUntil {!(isNull (findDisplay 46))};
createDialog 'respawnDialog';

player setVariable ['money', ('minMoney' call BL_fnc_config), true];
player addEventHandler ["killed", {
	private ['_money', '_minMoney'];
	_money = player getVariable ['money', 0];
	_minMoney = ('minMoney' call BL_fnc_config);
	if ( _money < _minMoney ) then {
		player setVariable ['money', _minMoney, true];
	};
}];