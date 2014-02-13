private ['_class', '_price', '_types'];
_types = ['guns', 'ammo', 'launchers', 'items', 'wearables', 'attachments'];
_config = call GEAR_config;
_class = _this;
_price = -1;

{
	_items = [_config, _x] call CBA_fnc_hashGet;
	
	{
		if ( _x select 0 == _class ) exitwith {
			_price = _x select 1;
		};
	} count _items;
	
	if ( _price > -1 ) exitwith {};	
} count _types;

_price