if ( !hasInterface ) exitwith{};

[] spawn {
	waitUntil { isPlayer player && player == player };
	_stores = call BL_fnc_storeConfig;
	if ( [_stores, 'repairPad'] call CBA_fnc_hashHasKey ) then {
		{
			_trg = (_x select 0) nearestObject "EmptyDetector";
			_trg setTriggerArea [5, 5, 0, false];
			_trg setTriggerStatements [
				"(vehicle player) in thislist && 'AllVehicles' countType thislist > 0 && vehicle player call BIS_fnc_absSpeed < 10",
				"[(vehicle player)] execVM 'client\systems\repairPads\x_reload.sqf'",
				""
			];
			_trg setTriggerActivation ["ANY", "PRESENT", true];

			nil
		} count (([_stores, 'repairPad'] call CBA_fnc_hashGet) select 2);
	};
};