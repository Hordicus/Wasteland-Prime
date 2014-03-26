execVM 'client\systems\townRadar\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';

waitUntil {!isNull player && player == player};
waitUntil{!isNil "BIS_fnc_init"};
waitUntil {!(isNull (findDisplay 46))};
execVM 'client\systems\playerRespawn\init.sqf';

[] spawn {
	titleText ["Waiting for player data...", "BLACK", 0.01];
	PVAR_loadPlayer = player;
	publicVariableServer "PVAR_loadPlayer";
	
	waitUntil { !isNil "PVAR_playerLoaded" };
	
	if ( count PVAR_playerLoaded > 0 ) then {
		// By this point player has been restored. Give them control ASAP.
		[player, PVAR_playerLoaded select 0] call GEAR_fnc_setLoadout;
		player playMove (PVAR_playerLoaded select 1);
		player setDir (PVAR_playerLoaded select 2);
		titleFadeOut 0.01;
	}
	else {
		titleText ["No player data found...", "BLACK", 0.01];
		sleep 1;
		titleFadeOut 0.5;
		createDialog 'respawnDialog';
	};
	
};

player setVariable ['money', ('minMoney' call BL_fnc_config), true];
player addEventHandler ["killed", {
	private ['_money', '_minMoney'];
	_money = player getVariable ['money', 0];
	_minMoney = ('minMoney' call BL_fnc_config);
	if ( _money < _minMoney ) then {
		player setVariable ['money', _minMoney, true];
	};
}];