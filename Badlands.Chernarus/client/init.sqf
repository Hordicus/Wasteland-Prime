execVM 'client\systems\townRadar\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';

waitUntil {!isNull player && player == player};
waitUntil{!isNil "BIS_fnc_init"};
waitUntil {!(isNull (findDisplay 46))};

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

// Get radar JIP update
[] spawn {
	PVAR_radarRequestJIPUpdate = player;
	publicVariableServer "PVAR_radarRequestJIPUpdate";
	
	waitUntil { !isNil "PVAR_radarRequestJIPUpdateResponse" };
	
	{
		_eventType = _x;
		{
			[_eventType, _x] call CBA_fnc_localEvent;
			true
		} count (PVAR_radarRequestJIPUpdateResponse select 1 select _forEachIndex);
	} forEach (PVAR_radarRequestJIPUpdateResponse select 0);
};

player setVariable ['money', ('minMoney' call BL_fnc_config), true];
player addEventHandler ["killed", {
	// Seems to be my only option if I want a killed event without
	// sending code...
	['killed', _this] call CBA_fnc_globalEvent;

	private ['_money', '_minMoney'];
	_money = player getVariable ['money', 0];
	_minMoney = ('minMoney' call BL_fnc_config);
	if ( _money < _minMoney ) then {
		player setVariable ['money', _minMoney, true];
	};
}];

player addEventHandler ["respawn", {
	['respawn', _this] call CBA_fnc_globalEvent;
}];