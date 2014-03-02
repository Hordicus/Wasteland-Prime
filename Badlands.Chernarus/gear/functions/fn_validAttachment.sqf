private ['_gun', '_attachment'];
_gun = _this select 0;
_attachment = _this select 1;
_cfg = _gun call GEAR_fnc_getConfig;
_limit = switch (_this select 2) do {
	case 'muzzle': {["MuzzleSlot"]};
	case 'acc': {["PointerSlot"]};
	case 'optic': {["CowsSlot"]};
};

if ( isNil "_limit" ) then {
	_limit = ["MuzzleSlot", "PointerSlot", "CowsSlot"];
};

_compatible = [];
{
	_compatible = _compatible + getArray (configFile >> "CfgWeapons" >> _gun >> "WeaponSlotsInfo" >> _x >> "compatibleItems");
} count _limit;
	
_attachment in _compatible || { toLower(_attachment) in _compatible }