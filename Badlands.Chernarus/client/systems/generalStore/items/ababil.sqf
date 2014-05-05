['ababil', 'K40 Ababil-3', "I_UAV_02_CAS_F", [], {
	[15, "Deploying K40 Ababil-3 %1", [], {
		private ['_items', '_uav'];
		_items = playerSide call {
			if ( _this == resistance ) exitwith {["I_UavTerminal", "I_UAV_02_CAS_F"]};
			if ( _this == west ) exitwith {["B_UavTerminal", "B_UAV_02_CAS_F"]};
		};

		player linkItem (_items select 0);
		_uav = createVehicle [_items select 1, getPosATL player, [], 0, "FLY"];
		createVehicleCrew _uav;
		player connectTerminalToUav objNull;	
		player connectTerminalToUav _uav;

		PVAR_trackVehicle = [player, _uav];
		publicVariableServer "PVAR_trackVehicle";
		
		['ababil'] call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
}] call BL_fnc_addInventoryType;