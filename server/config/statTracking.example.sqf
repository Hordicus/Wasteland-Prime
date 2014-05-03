private ['_config', '_vehicles'];
_config = [] call CBA_fnc_hashCreate;

[_config, 'playerKillScore', 5] call CBA_fnc_hashSet;
[_config, 'aiKillScore', 3] call CBA_fnc_hashSet;
[_config, 'deathScore', -1] call CBA_fnc_hashSet;

_vehicles = [] call CBA_fnc_hashCreate;
[_vehicles, "LandVehicle", 3] call CBA_fnc_hashSet;

[_config, 'vehicleBonusScore', _vehicles] call CBA_fnc_hashSet;

_config