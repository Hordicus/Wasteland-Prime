['ababil', 'K40 Ababil-3', "I_UAV_02_CAS_F", [], {
	[15, [], {
		_items = (side player) call {
			if ( _this == resistance ) exitwith {["I_UavTerminal", "I_UAV_02_CAS_F"]};
			if ( _this == west ) exitwith {["B_UavTerminal", "B_UAV_02_CAS_F"]};
			if ( _this == east ) exitwith {["O_UavTerminal", "O_UAV_02_CAS_F"]};
		};

		player linkItem (_items select 0);
		[_items select 1, getPosATL player, "veh", [], {
			private ['_uav'];
			_uav = _this select 0;
			player connectTerminalToUav objNull;
			player connectTerminalToUav _uav;
			activeUAV = _uav;
		}, "FLY", true] call BL_fnc_createVehicle;
		
		['ababil'] call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
}] call BL_fnc_addInventoryType;