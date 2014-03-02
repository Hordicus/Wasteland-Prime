private ['_class'];

_class = _this;
_cfg   = _class call GEAR_fnc_getConfig;
_capacity  = getNumber ( _cfg >> 'maximumLoad' );

if ( _capacity == 0 ) then {
	_container = getText ( _cfg >> 'ItemInfo' >> 'ContainerClass' );
	_capacity = getNumber ( configFile >> 'CfgVehicles' >> _container >> 'maximumLoad' );
};

_capacity