['fuelFull', 'Fuel Can (Full)', 'Land_CanisterFuel_F', [], {
	private ['_vehs', '_veh'];
	_vehs = nearestObjects [getPosATL player, ["LandVehicle","Air"], 10];

	if ( count _vehs == 0 ) then {
		hint 'Unable to find vehicle to refuel!';
	}
	else {
		_veh = _vehs select 0;
		
		if ( cursorTarget in _vehs ) then {
			_veh = cursorTarget;
		};
		
		if (local _veh) then {
			[5, "Refueling Vehicle %1", [_veh], {
				(_this select 0) setFuel 1;
				['fuelFull'] call BL_fnc_removeInventoryItem;
				['fuelEmpty'] call BL_fnc_addInventoryItem;
			}] call BL_fnc_animDoWork;
		}
		else {
			hint "You need to enter and exit the vehicle before refueling."; 
		};
	};
}] call BL_fnc_addInventoryType;