BL_safeZones = 'safeZones' call BL_fnc_config;

player addEventHandler ['Fired', "_this call " + str {
	{
		if ( (_this select 0) distance (_x select 0) < (_x select 1) ) exitwith {
			deleteVehicle (_this select 6);
			
			if ( _x select 2 ) then {
				player setDamage 1;
			};
		};
	} count BL_safeZones;
}];