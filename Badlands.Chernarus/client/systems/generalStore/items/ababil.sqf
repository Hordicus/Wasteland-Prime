['ababil', 'K40 Ababil-3', [],
{
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
},
{
	[5, [], {
		["I_UAV_02_CAS_F", getPosATL player, "veh"] call BL_fnc_createVehicle;
		['ababil'] call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
}
] call BL_fnc_addInventoryType;

['Pick up K40 Ababil-3',
{(_this select 0) isKindOf "UAV_02_base_F" && (count crew (_this select 0)) == 0 && !BL_animDoWorkInProgress},
{
	[5, _this, {
		if ( !isNull (_this select 0) ) then {
			(_this select 0) call BL_fnc_deleteVehicle;
			['ababil'] call BL_fnc_addInventoryItem;
		};
	}] call BL_fnc_animDoWork;
}
] call BL_fnc_addAction;