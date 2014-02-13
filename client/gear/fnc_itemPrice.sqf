private ['_class', '_types', '_prices', '_classes', '_lookup'];
_types = ['guns', 'ammo', 'launchers', 'items', 'wearables', 'attachments'];
_class = _this;

if ( isNil "GEAR_priceLookup" ) then {
	_config = call GEAR_config;
	_classes  = [];
	_prices = [];
	
	{
		_items = [_config, _x] call CBA_fnc_hashGet;
		
		{
			_classes set [count _classes, _x select 0];
			_prices set [count _prices, _x select 1];
			true
		} count _items;
		true
	} count _types;
	
	GEAR_priceLookup = compileFinal str [_classes, _prices];
};

_lookup = call GEAR_priceLookup;
((_lookup select 1) select ((_lookup select 0) find _class))