friendlyState    = compileFinal preprocessFileLineNumbers "client\functions\friendlyState.sqf";
COB_fnc_HALO     = compileFinal preprocessFileLineNumbers "client\functions\fn_halo.sqf";
COB_fnc_paradrop = compileFinal preprocessFileLineNumbers "client\functions\fn_paradrop.sqf";

execVM 'client\systems\townRadar\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';

waituntil {!(isNull (findDisplay 46))};
createDialog 'respawnDialog';