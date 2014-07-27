execVM 'client\systems\townRadar\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';
execVM 'addons\zlt_fastrope.sqf';

waitUntil {!isNull player && player == player};
waitUntil{!isNil "BIS_fnc_init"};
waitUntil {!(isNull (findDisplay 46))};

player allowDamage false;
player enableSimulation false;
[player] join grpNull;
0 fadeRadio 0;
player setVariable ['side', playerSide, true];
BL_donatorInfo = missionNamespace getVariable ["BL_donatorInfo", -1];

GEAR_activeLoadout = profileNamespace getVariable ["GEAR_activeLoadout", []];
_itemCount = {
	if ( isNil "_x" ) then {
		false
	}
	else {
		[typeName _x, _x] call {
			if ( (_this select 0) == "STRING" ) exitwith { (_this select 1) != "" };
			if ( (_this select 0) == "ARRAY" ) exitwith { count (_this select 1) > 0 };
			true
		};
	};
} count GEAR_activeLoadout;

if ( _itemCount == 0 ) then {
	if ( playerSide == west ) then {
		GEAR_activeLoadout = "defaultWest" call BL_fnc_config;
	}
	else {
		GEAR_activeLoadout = "defaultIndy" call BL_fnc_config;	
	};
	
	profileNamespace setVariable ["GEAR_activeLoadout", GEAR_activeLoadout];
	saveProfileNamespace;
};

[] spawn {
	["Waiting for server to initialize", 0.01] call BL_fnc_loadingScreen;
	if ( isNil "PERS_init_done" ) then {
		[] spawn {
			waitUntil {!isNil "PERS_init_count"};
			PERS_init_currentCount = missionNamespace getVariable ['PERS_init_currentCount', 0];
			while { isNil "PERS_init_done" } do {
				["Waiting for server to initialize", PERS_init_currentCount / PERS_init_count] call BL_fnc_loadingScreen;
				sleep 0.5;
			};
		};
	};
	
	waitUntil {!isNil"PERS_init_done"};

	["Waiting for player data", 0.1] call BL_fnc_loadingScreen;
	PVAR_loadPlayer = player;
	publicVariableServer "PVAR_loadPlayer";
	
	waitUntil { !isNil "PVAR_playerLoaded" };
	[0.5] call BL_fnc_loadingScreen;
	
	if ( count PVAR_playerLoaded > 0 ) then {
		// By this point player has been restored. Give them control ASAP.
		// Check if they are in spawn. If their last save was at a respawn
		// marker they logged out dead.
		if ( count PVAR_playerLoaded != 1 ) then { // Length will be one when player logged out dead
			["Setting up player", 0.6] call BL_fnc_loadingScreen;
			
			[player, PVAR_playerLoaded select 0] call GEAR_fnc_setLoadout;
			player playMove (PVAR_playerLoaded select 1);
			player setDir (PVAR_playerLoaded select 2);

			// Server will call setPos on player. Wait for client to notice.
			["Waiting for position update", 0.9] call BL_fnc_loadingScreen;
			waitUntil {
				(getMarkerPos 'respawn_west') distance player > 100 &&
				(getMarkerPos 'respawn_east') distance player > 100 &&
				(getMarkerPos 'respawn_guerrila') distance player > 100
			};

			player addRating 9999999999999999999999999;
			player allowDamage true;
			player enableSimulation true;
			
			[] call BL_fnc_showLocationInfo;
			[] call BL_fnc_loadingScreen;
		}
		else {
			[] call BL_fnc_loadingScreen;
			BL_playerSpawning = true;
			createDialog 'BLrespawnDialog';
		};
	}
	else {
		["No player data found", 0.9] call BL_fnc_loadingScreen;
		sleep 1;
		[] call BL_fnc_loadingScreen;
		BL_playerSpawning = true;
		createDialog 'BLrespawnDialog';
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
	['killed', _this] call BL_fnc_serverEvent;

	if ( BL_donatorInfo > -1 ) then {
		[player] call (([call BL_fnc_donatorsConfig, 'tiers'] call CBA_fnc_hashGet) select BL_donatorInfo);
	}
	else {
		private ['_money', '_minMoney'];
		_money = player getVariable ['money', 0];
		_minMoney = ('minMoney' call BL_fnc_config);
		if ( _money < _minMoney ) then {
			player setVariable ['money', _minMoney, true];
		};
	};
}];

"BL_donatorTime" addPublicVariableEventHandler {
	_this spawn {
		_time = _this select 1;
		waitUntil { isPlayer player && alive player && !dialog };
		
		[format['Your donation expires in %1 days', _time], 5] call BL_fnc_actionText;
	};
};

player addEventHandler ["respawn", {
	['respawn', _this] call BL_fnc_serverEvent;
	(_this select 0) setVariable ['side', playerSide, true];
}];

0.99 spawn {
	while { true} do {
		sleep 1;
		player setFatigue ((getFatigue player) * _this);
	};
};
