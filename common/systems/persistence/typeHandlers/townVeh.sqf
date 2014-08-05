['townVeh', [
	// Save
	{},
	
	// Load
	{
		private ['_veh'];
		_veh = _this select 0;
		
		_veh setVariable ['originalCargo', [
			getWeaponCargo _veh,
			getMagazineCargo _veh,
			getItemCargo _veh
		]];
	}
]] call BL_fnc_persRegisterTypeHandler;