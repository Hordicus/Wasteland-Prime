if ( isServer ) then {
	BL_HCs = [] call CBA_fnc_hashCreate;
	
	["initPlayerServer", {
		_player = _this select 0;
		_uid = getPlayerUID _player;
		[call BL_fnc_systemsConfig, {
			if ( _uid == _value ) exitwith {
				[BL_HCs, _uid, owner _player] call CBA_fnc_hashSet;
			};
		}] call CBA_fnc_hashEachPair;
	}] call CBA_fnc_addEventHandler;
	
	["HCTracking", "onPlayerDisconnected", {
		[BL_HCs, _uid] call CBA_fnc_hashRem;
	}] call BIS_fnc_addStackedEventHandler;

	[] spawn {
		"BL_PVAR_publicVariableClientRelay" addPublicVariableEventHandler {
			diag_log format["BL_PVAR_publicVariableClientRelay: %1", _this];
			_pvar = _this select 0;
			
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
	};
};