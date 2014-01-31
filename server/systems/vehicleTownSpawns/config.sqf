_config = [] call CBA_fnc_hashCreate;

[_config, "vehicles", [
	// ["class", chance],
	["C_Hatchback_01_F", 1],
	["C_Offroad_01_F", 1],
	["B_G_Offroad_01_F", 1],
	["B_G_Offroad_01_armed_F", 0.5],
	["C_SUV_01_F", 0.7],
	["C_Quadbike_01_F", 1],
	["C_Hatchback_01_sport_F", 0.1],
	["C_Van_01_fuel_F", 1],
	["B_G_Van_01_fuel_F", 1],
	["B_Truck_01_mover_F", 1],
	["B_G_Van_01_transport_F", 1],
	["C_Van_01_box_F", 1]
]] call CBA_fnc_hashSet;

_config