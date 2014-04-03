private ['_config', '_allowedClasses', '_blConfig'];
_config = [] call CBA_fnc_hashCreate;

// Classes that the user can request with BL_fnc_createVehicle function
_allowedClasses = [];
_blConfig = [] call BL_fnc_config;

// All items in building store config should be creatable
{
	{
		_allowedClasses set [count _allowedClasses, _x select 1];
		true
	} count (_x select 1);
	true
} count ([_blConfig, 'buildingStore'] call CBA_fnc_hashGet);


// Players need to be able to create spawn beacons
_allowedClasses set [count _allowedClasses, [_blConfig, 'airBeaconModel'] call CBA_fnc_hashGet];
_allowedClasses set [count _allowedClasses, [_blConfig, 'groundBeaconModel'] call CBA_fnc_hashGet];

// Quadcopter classes. You can buy them from the general store.
_allowedClasses set [count _allowedClasses, "I_UAV_01_F"];
_allowedClasses set [count _allowedClasses, "O_UAV_01_F"];
_allowedClasses set [count _allowedClasses, "B_UAV_01_F"];

_allowedClasses set [count _allowedClasses, "I_UAV_02_CAS_F"];
_allowedClasses set [count _allowedClasses, "O_UAV_02_CAS_F"];
_allowedClasses set [count _allowedClasses, "B_UAV_02_CAS_F"];

_allowedClasses set [count _allowedClasses, [_blConfig, 'moneyModel'] call CBA_fnc_hashGet];

[_config, 'allowedClasses', _allowedClasses] call CBA_fnc_hashSet;

_config