_h = execVM "server\functions\compile.sqf";
waitUntil { scriptDone _h; };

execVM "server\systems\townRadar\init.sqf";
execVM "server\systems\vehicleTownSpawns\init.sqf";