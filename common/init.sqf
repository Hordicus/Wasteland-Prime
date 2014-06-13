if ( isNil "CBA_eventHandlers" && !isServer ) then {
	CBA_eventHandlers = "Logic" createVehicleLocal [0, 0];
	CBA_eventHandlersLocal = "Logic" createVehicleLocal [0, 0];
};

if ( isServer ) then {
	BL_HCs = [];
	
	"BL_HC_register" addPublicVariableEventHandler {
		_player = _this select 1;
		_uid = getPlayerUID _player;
		
		if ( ({owner _player == _x select 0} count BL_HCs) == 0 && _uid in (call BL_fnc_systemsConfig select 2) ) then {
			BL_HCs set [count BL_HCs, [owner _player, getPlayerUID _player]];
		};
	};
	
	['onPlayerDisconnected', {
		_uid = _this select 1;
		
		if ( _uid in (call BL_fnc_systemsConfig select 2) ) then {
			{
				if ( (_x select 1) == _uid ) then {
					BL_HCs = BL_HCs - [_x];
				};
				nil
			} count BL_HCs;
		};
	}] call CBA_fnc_addEventHandler;

	[] spawn {
		"BL_PVAR_publicVariableClientRelay" addPublicVariableEventHandler {
			_pvar = _this select 1;
			
			missionNamespace setVariable [_pvar select 2, _pvar select 1];
			(owner (_pvar select 0)) publicVariableClient (_pvar select 2);
		};
	};

	['CBADisconnected', 'onPlayerDisconnected', {
		['onPlayerDisconnected', [_id, _uid, _name]] call CBA_fnc_localEvent;
	}] call BIS_fnc_addStackedEventHandler;

	['CBAConnected', 'onPlayerConnected', {
		['onPlayerConnected', [_id, _uid, _name]] call CBA_fnc_localEvent;
	}] call BIS_fnc_addStackedEventHandler;

	// Forward these events to any connected HCs
	["initPlayerServer", {
		["initPlayerServer", _this] call BL_fnc_forwardEventToAllHCs;
	}] call CBA_fnc_addEventHandler;
	
	["killed", {
		["killed", _this] call BL_fnc_forwardEventToAllHCs;
	}] call CBA_fnc_addEventHandler;
	
	["respawn", {
		["respawn", _this] call BL_fnc_forwardEventToAllHCs;
	}] call CBA_fnc_addEventHandler;
	
	["onPlayerDisconnected", {
		["onPlayerDisconnected", _this] call BL_fnc_forwardEventToAllHCs;
	}] call CBA_fnc_addEventHandler;
	
	["onPlayerConnected", {
		["onPlayerConnected", _this] call BL_fnc_forwardEventToAllHCs;
	}] call CBA_fnc_addEventHandler;
}
else {
	[] spawn {
		waitUntil { isPlayer player && player == player };
		player allowDamage false;
		player enableSimulation false;
		player hideObjectGlobal true;
		
		// Let server know we're here.
		BL_HC_register = player;
		publicVariableServer "BL_HC_register";
	};
};