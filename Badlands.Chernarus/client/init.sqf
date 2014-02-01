friendlyState = compileFinal preprocessFileLineNumbers "client\functions\friendlyState.sqf";

execVM 'client\systems\townRadar\init.sqf';
execVM 'addons\fpsFix\vehicleManager.sqf';