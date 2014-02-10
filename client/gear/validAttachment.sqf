private ['_gun', '_attachment'];
_gun = _this select 0;
_attachment = _this select 1;
_cfg = _gun call GEAR_getConfig;

_compatible = getArray (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")
	+ getArray (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems")
	+ getArray (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
	
_attachment in _compatible