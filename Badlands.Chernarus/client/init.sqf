execVM 'client\systems\townRadar\init.sqf';
execVM 'client\systems\playerRespawn\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';

waituntil {!(isNull (findDisplay 46))};
createDialog 'respawnDialog';

execVM 'logistics\init.sqf';