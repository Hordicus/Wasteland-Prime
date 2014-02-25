execVM 'client\systems\townRadar\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';

waituntil {!(isNull (findDisplay 46))};
createDialog 'respawnDialog';