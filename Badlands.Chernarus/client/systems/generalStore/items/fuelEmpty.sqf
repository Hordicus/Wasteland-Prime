['fuelEmpty', 'Fuel Can (Empty)', 'Land_CanisterFuel_F', [], {
	hint "You cannot use an empty fuel can. Go find a fuel pump.";
}] call BL_fnc_addInventoryType;

['Refuel Fuel Can', {'fuelEmpty' in (player getVariable ['BL_playerInv', []]) && (
	(_this select 0) isKindOf "Land_fs_feed_F" ||
	(_this select 0) isKindOf "Land_FuelStation_Feed_F"
)}, {
	['fuelFull'] call BL_fnc_addInventoryItem;
	['fuelEmpty'] call BL_fnc_removeInventoryItem;
}] call BL_fnc_addAction;