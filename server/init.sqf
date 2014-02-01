_dir = __FILE__ call getDirectory;
_h = execVM (_dir + "\functions\compile.sqf");
waitUntil { scriptDone _h; };

execVM (_dir + "\systems\townRadar\init.sqf");
execVM (_dir + "\systems\vehicleTownSpawns\init.sqf");