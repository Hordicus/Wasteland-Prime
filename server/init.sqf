_dir = __FILE__ call BL_fnc_getDirectory;
call compile preprocessFileLineNumbers ("\server\functions\compile.sqf");
call compile preprocessFileLineNumbers ("\server\systems\playerMoney\functions\compile.sqf");

execVM ("\server\systems\radar\init.sqf");
execVM ("\server\systems\townRadar\init.sqf");
execVM ("\server\systems\vehicleTownSpawns\init.sqf");
execVM ("\server\systems\playerRespawn\init.sqf");
execVM ("\server\systems\playerMenu\init.sqf");
execVM ("\server\systems\playerMoney\init.sqf");

BL_spawnBeacons = [];
publicVariable "BL_spawnBeacons";