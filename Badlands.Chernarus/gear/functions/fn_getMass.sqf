private ['_class'];

_class = _this;
_cfg   = _class call GEAR_fnc_getConfig;
_mass  = 0;

_mass = getNumber ( _cfg >> 'WeaponSlotsInfo' >> 'mass' );

if ( _mass == 0 ) then {
	_mass = getNumber ( _cfg >> 'ItemInfo' >> 'mass' );
};

if ( _mass == 0 ) then {
	_mass = getNumber ( _cfg >> 'mass' );
};

_mass