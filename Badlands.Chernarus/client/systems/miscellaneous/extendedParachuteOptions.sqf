(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call " + str {
	if ( (_this select 1) == 18 && (vehicle player) isKindOf "ParachuteBase" ) then {
		deleteVehicle (vehicle player);
		
		true
	}
	else {
		false
	};
}];