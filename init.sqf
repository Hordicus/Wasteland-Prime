enableSaving [false, false];
waitUntil {!isNull player};
waituntil {!(IsNull (findDisplay 46))};
createDialog 'geard';

player addAction ["Open Gear", { createDialog "geard";}];