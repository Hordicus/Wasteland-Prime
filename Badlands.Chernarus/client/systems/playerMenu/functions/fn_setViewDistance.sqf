/*
	Description:
	Sets view distance depending on
	if the player is in a vehicle.
	
	Parameter(s):
	None
	
	Returns:
	Current view distance
*/

private ['_veh', '_dist'];
_veh = vehicle player;
_dist = viewDistance;

switch true do {
	case (_veh isKindOf "Man"): {
		_dist = BL_footViewDistance;
	};
	case (_veh isKindOf "LandVehicle"): {
		_dist = BL_carViewDistance;
	};
	case (_veh isKindOf "Air"): {
		_dist = BL_airViewDistance;
	};
};

setViewDistance _dist;

_dist