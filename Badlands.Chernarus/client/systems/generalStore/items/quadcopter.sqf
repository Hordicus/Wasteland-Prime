['quadcopter', 'Quadcopter UAV', [],
// Use
{
	[15, [], {
		_items = (side player) call {
			if ( _this == resistance ) exitwith {["I_UavTerminal", "I_UAV_01_F"]};
			if ( _this == west ) exitwith {["B_UavTerminal", "B_UAV_01_F"]};
			if ( _this == east ) exitwith {["O_UavTerminal", "O_UAV_01_F"]};
		};

		player linkItem (_items select 0);
		[_items select 1, getPosATL player, "veh", [], {
			private ['_uav'];
			_uav = _this select 0;
			player connectTerminalToUav objNull;
			player connectTerminalToUav _uav;
			activeUAV = _uav;
		}, "CAN_COLLIDE", true] call BL_fnc_createVehicle;
		
		['quadcopter'] call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
},
// Drop
{
	[5, [], {
		["I_UAV_01_F", getPosATL player, "veh"] call BL_fnc_createVehicle;
		['quadcopter'] call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
}
] call BL_fnc_addInventoryType;

['Pick up Quadcopter UAV',
{(_this select 0) isKindOf "UAV_01_base_F" && (count crew (_this select 0)) == 0 && !BL_animDoWorkInProgress},
{
	[5, _this, {
		if ( !isNull (_this select 0) ) then {
			(_this select 0) call BL_fnc_deleteVehicle;
			['quadcopter'] call BL_fnc_addInventoryItem;
		};
	}] call BL_fnc_animDoWork;
},
5] call BL_fnc_addAction;

[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};

	// Keep the UAV connected to the player
	player addEventHandler ['Respawn', {
		if ( !isNil "activeUAV" && {!isNull activeUAV} ) then {
			_this spawn {
				waitUntil {BL_playerSpawning};
				waitUntil {!BL_playerSpawning};
				_term = (side player) call {
					if ( _this == resistance ) exitwith {"I_UavTerminal"};
					if ( _this == west ) exitwith {"B_UavTerminal"};
					if ( _this == east ) exitwith {"O_UavTerminal"};
				};
				
				(_this select 1) connectTerminalToUav objNull;

				(_this select 0) linkItem _term;
				(_this select 0) connectTerminalToUav activeUAV;
			};
		};
	}];
};