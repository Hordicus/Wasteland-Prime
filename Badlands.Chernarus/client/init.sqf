execVM 'client\systems\townRadar\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';

waitUntil {!isNull player && player == player};
waitUntil{!isNil "BIS_fnc_init"};
waitUntil {!(isNull (findDisplay 46))};

player allowDamage false;
player enableSimulation false;
[player] join grpNull;
enableRadio false;

[] spawn {
	startLoadingScreen ["Waiting for player data...", "BLLoadingScreen"];
	progressLoadingScreen 0.1;
	PVAR_loadPlayer = player;
	publicVariableServer "PVAR_loadPlayer";
	
	waitUntil { !isNil "PVAR_playerLoaded" };
	progressLoadingScreen 0.5;
	
	if ( count PVAR_playerLoaded > 0 ) then {
		// By this point player has been restored. Give them control ASAP.
		// Check if they are in spawn. If their last save was at a respawn
		// marker they logged out dead.
		if (
			(getMarkerPos 'respawn_west') distance player > 100 &&
			(getMarkerPos 'respawn_east') distance player > 100 &&
			(getMarkerPos 'respawn_guerrila') distance player > 100
		) then {
			[player, PVAR_playerLoaded select 0] call GEAR_fnc_setLoadout;
			player allowDamage true;
			player enableSimulation true;
			player playMove (PVAR_playerLoaded select 1);
			player setDir (PVAR_playerLoaded select 2);
		}
		else {
			createDialog 'respawnDialog';
		};
	}
	else {
		startLoadingScreen ["No player data found...", "BLLoadingScreen"];
		progressLoadingScreen 0.9;
		sleep 1;
		createDialog 'respawnDialog';
	};
	
	endLoadingScreen;
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

if ( side player == resistance ) then {
	// Keep player's rating at -100,000. Below -2000 switches side to enemy.

	player addRating (-100000 + -(rating player));
	['killed', {
		if ( rating player > -50000 ) then {
			player addRating (-100000 + -(rating player));
		};
	}] call CBA_fnc_addEventHandler;

	player addEventHandler ['Respawn', {
		player addRating (-100000 + -(rating player));
	}];
};