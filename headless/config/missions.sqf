private ['_config'];
_config = [] call CBA_fnc_hashCreate;

// Amount of missions to run at the same time
[_config, 'count', 3] call CBA_fnc_hashSet;

// How long to wait after a mission is finished before
// starting another.
[_config, 'delay', 30] call CBA_fnc_hashSet;

// How long to wait before the first mission
// after a restart.
[_config, 'roundStartDelay', 30] call CBA_fnc_hashSet;

// How long to wait before removing task
[_config, 'taskCleanupDelay', 15] call CBA_fnc_hashSet;

// Missions available for selection
[_config, 'missions', [
	// server\systems\missions\{missionName}.sqf, probability of selecting mission
	['randomVehicle', 1]
	// ['convoyMission',1]
	// ['heliCrash', 1]
	// ['hostileTakeover', 1]
]] call CBA_fnc_hashSet;

[_config, 'randomVehicleRewards', [
	["I_APC_Wheeled_03_cannon_F", 1],
	["I_APC_tracked_03_cannon_F", 1],
	["B_APC_Wheeled_01_cannon_F", 1],
	["B_APC_Tracked_01_AA_F", 1],
	["O_APC_Tracked_02_cannon_F", 1],
	["O_APC_Wheeled_02_rcws_F", 1],

	["B_Heli_Light_01_armed_F", 0.5],
	["O_Heli_Light_02_F", 0.5],
	["I_Heli_light_03_F", 0.5],

	["O_MBT_02_cannon_F", 0.2],
	["I_MBT_03_cannon_F", 0.2],
	["B_MBT_01_cannon_F", 0.2],
	["B_MBT_01_TUSK_F", 0.2]
]] call CBA_fnc_hashSet;

[_config, 'hostileTakeoverRewards', [
	["O_Truck_03_ammo_F", 1],
	["O_Truck_03_repair_F", 1],
	["O_MRAP_02_gmg_F", 1],
	["O_MRAP_02_hmg_F", 1],

	["I_APC_Wheeled_03_cannon_F", 0.5],
	["I_APC_tracked_03_cannon_F", 0.5],
	["B_APC_Wheeled_01_cannon_F", 0.5],
	["B_APC_Tracked_01_AA_F", 0.5],
	["O_APC_Tracked_02_cannon_F", 0.5],
	["O_APC_Wheeled_02_rcws_F", 0.5],
	["B_APC_Tracked_01_CRV_F", 0.5],

	["O_MBT_02_cannon_F", 0.2],
	["I_MBT_03_cannon_F", 0.2],
	["B_MBT_01_cannon_F", 0.2],
	["B_MBT_01_TUSK_F", 0.2]
]] call CBA_fnc_hashSet;

_config