execVM 'client\systems\townRadar\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';

waitUntil {!isNull player && player == player};
waitUntil{!isNil "BIS_fnc_init"};
waitUntil {!(isNull (findDisplay 46))};

player allowDamage false;
player enableSimulation false;
[player] join grpNull;
enableRadio false;
0 fadeRadio 0;

[] spawn {
	["Waiting for player data", 0.1] call BL_fnc_loadingScreen;
	PVAR_loadPlayer = player;
	publicVariableServer "PVAR_loadPlayer";
	
	waitUntil { !isNil "PVAR_playerLoaded" };
	[0.5] call BL_fnc_loadingScreen;
	
	if ( count PVAR_playerLoaded > 0 ) then {
		// By this point player has been restored. Give them control ASAP.
		// Check if they are in spawn. If their last save was at a respawn
		// marker they logged out dead.
		if (
			(getMarkerPos 'respawn_west') distance player > 100 &&
			(getMarkerPos 'respawn_east') distance player > 100 &&
			(getMarkerPos 'respawn_guerrila') distance player > 100 &&
			count PVAR_playerLoaded != 1 // Length will be one when player logged out dead
		) then {
			[player, PVAR_playerLoaded select 0] call GEAR_fnc_setLoadout;
			player allowDamage true;
			player enableSimulation true;
			player playMove (PVAR_playerLoaded select 1);
			player setDir (PVAR_playerLoaded select 2);
			[] call BL_fnc_loadingScreen;
		}
		else {
			[] call BL_fnc_loadingScreen;
			createDialog 'respawnDialog';
		};
	}
	else {
		["No player data found", 0.9] call BL_fnc_loadingScreen;
		sleep 1;
		[] call BL_fnc_loadingScreen;
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

if ( side player == resistance ) then {
	// When player is damaged set rating to -4000 in case they die.
	// If the player dies with a negative rating it won't show as 
	// friendly fire.
	player addEventhandler ['HandleDamage', {
		_player = _this select 0;
		-4000 call BL_fnc_setRating;
		
		_h = _player getVariable 'HandleDamageSH';
		if ( !isNil "_h" ) then {
			if ( !scriptDone _h ) then {
				terminate _h;
			};
		};
		
		_h = [_player] spawn {
			sleep 0.1;
			0 call BL_fnc_setRating;
		};
		
		_h = _player setVariable ['HandleDamageSH', _h];
	}];
};