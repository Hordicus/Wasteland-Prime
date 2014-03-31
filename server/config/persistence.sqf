private ['_config', '_allowedClasses', '_blConfig'];
_config = [] call CBA_fnc_hashCreate;

// Classes that the user can request with BL_fnc_createVehicle function
_allowedClasses = [];
_blConfig = [] call BL_fnc_config;

// All items in building store config should be creatable
{
	{
		_allowedClasses set [count _allowedClasses, _x select 1];
	} count (_x select 1);
} count ([_blConfig, 'buildingStore'] call CBA_fnc_hashGet);


// Players need to be able to create spawn beacons

_allowedClasses set [count _allowedClasses, [_blConfig, 'airBeaconModel'] call CBA_fnc_hashGet];
_allowedClasses set [count _allowedClasses, [_blConfig, 'groundBeaconModel'] call CBA_fnc_hashGet];

[_config, 'allowedClasses', _allowedClasses] call CBA_fnc_hashSet;

_config