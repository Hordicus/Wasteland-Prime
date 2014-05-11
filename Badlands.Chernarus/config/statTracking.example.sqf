private ['_config', '_vehicles'];
_config = [] call CBA_fnc_hashCreate;

[_config, 'addPointsLogMaxSize', 20] call CBA_fnc_hashSet;
[_config, 'statTrackingQueueMaxSize', 20] call CBA_fnc_hashSet;

[_config, 'playerKill', 5] call CBA_fnc_hashSet;
[_config, 'aiKill', 3] call CBA_fnc_hashSet;
[_config, 'death', -1] call CBA_fnc_hashSet;

_vehicles = [] call CBA_fnc_hashCreate;
[_vehicles, "LandVehicle", 1] call CBA_fnc_hashSet;

[_config, 'vehicleBonus', _vehicles] call CBA_fnc_hashSet;

[_config, 'playerBounty', 250] call CBA_fnc_hashSet;
[_config, 'aiBounty', 250] call CBA_fnc_hashSet;

_config