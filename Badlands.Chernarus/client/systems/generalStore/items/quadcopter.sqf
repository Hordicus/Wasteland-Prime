['quadcopter', 'Quadcopter UAV', "I_UAV_01_F", [], {
	[15, "Deploying Quadcopter UAV %1", [], {
		private ['_items', '_uav'];
		_items = playerSide call {
			if ( _this == resistance ) exitwith {["I_UavTerminal", "I_UAV_01_F"]};
			if ( _this == west ) exitwith {["B_UavTerminal", "B_UAV_01_F"]};
		};

		player linkItem (_items select 0);
		_uav = createVehicle [_items select 1, getPosATL player, [], 0, "CAN_COLLIDE"];
		createVehicleCrew _uav;
		player connectTerminalToUav objNull;	
		player connectTerminalToUav _uav;

		PVAR_trackVehicle = [player, _uav];
		publicVariableServer "PVAR_trackVehicle";
		
		['quadcopter'] call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
}] call BL_fnc_addInventoryType;

[] spawn {
	if ( !hasInterface ) exitwith{};
	
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};

	// Keep the UAV connected to the player
	player addEventHandler ['Killed', {
		// Seems to be more reliable then connectTerminalToUav objNull
		getConnectedUAV (_this select 0) action ["UAVTerminalReleaseConnection", (_this select 0)];
	}];
	
	player addEventHandler ['Respawn', {
		if ( !isNil "activeUAV" && {!isNull activeUAV} ) then {
			_this spawn {
				waitUntil {BL_playerSpawning};
				waitUntil {!BL_playerSpawning};
				_term = (side player) call {
					if ( _this == resistance ) exitwith {"I_UavTerminal"};
					if ( _this == west ) exitwith {"B_UavTerminal"};
				};
				
				(_this select 0) linkItem _term;
				(_this select 0) connectTerminalToUav activeUAV;
			};
		};
	}];
};