if ( isNil "CBA_eventHandlers" ) then {
	CBA_eventHandlers = "Logic" createVehicleLocal [0, 0];
	CBA_eventHandlersLocal = "Logic" createVehicleLocal [0, 0];
};

if ( isServer ) then {
	BL_sessionStart = call compile ("Arma2Net.Unmanaged" callExtension "DateTime ['now', 'yyyy-MM-dd HH:mm:ss']");
	publicVariable "BL_sessionStart";

	BL_HCs = [];
		
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

		"BL_HC_register" addPublicVariableEventHandler {
			_player = _this select 1;
			_uid = getPlayerUID _player;
			
			if ( ({owner _player == _x select 0} count BL_HCs) == 0 && _uid in (call BL_fnc_systemsConfig select 2) ) then {
				BL_HCs set [count BL_HCs, [owner _player, getPlayerUID _player]];
				
				BL_HC_registerAck = true;
				(owner _player) publicVariableClient "BL_HC_registerAck";
			};
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
	[] spawn {
		while { true } do {
			sleep (60*10);
			
			_classes = [[], 0] call BL_fnc_hashCreate;
			
			{
				_type = typeOf _x;
				[_classes, _type, ([_classes, _type] call BL_fnc_hashGet)+1] call BL_fnc_hashSet;
				
				nil
			} count (allMissionObjects "All");
			
			_flatArray = [];
			[_classes, {
				_flatArray set [count _flatArray, [_key, _value]];
			}] call BL_fnc_hashEachPair;
			
			_flatArray = [_flatArray, [], {_x select 1}, "DESCEND"] call BL_fnc_sortBy;
			
			diag_log "======= Begin object count dump =======";
			{
				diag_log format['%1: %2', _x select 0, _x select 1];
				
				nil
			} count _flatArray;
			diag_log "======= End object count dump =======";
		};
	};
}
else {
	[] spawn {
		waitUntil { isPlayer player && player == player };
		player allowDamage false;
		player enableSimulation false;
		player hideObjectGlobal true;
		
		// Let server know we're here.
		// Retry every 10 sec until we get an ack
		_start = 0;
		while { isNil "BL_HC_registerAck" } do {
			_start = diag_tickTime;
			BL_HC_register = player;
			publicVariableServer "BL_HC_register";
			
			waitUntil { diag_tickTime - _start > 10 || !isNil "BL_HC_registerAck" };
		};
	};
	
	// http://killzonekid.com/arma-scripting-tutorials-how-to-skip-briefing-screen-in-mp/
	[] spawn {
		waitUntil {
			if (!isNull findDisplay 53) exitWith {
				ctrlActivate (findDisplay 53 displayCtrl 1);
				findDisplay 53 closeDisplay 1;
				true
			};
			false
		};
	};	
};
