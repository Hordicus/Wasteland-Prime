private ['_box', '_prices', '_total', '_items', '_class', '_count', '_price'];
_box = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_prices = [[] call BL_fnc_generalStoreConfig, 'resalePrices'] call CBA_fnc_hashGet;

if !( _box isKindOf "Reammobox_F" ) exitwith {0};

_total = 0;

{
	_items = _x;
	
	{
		_class = _x;
		_count = _items select 1 select _forEachIndex;
		_price = 1;
		
		{
			if ( (_x select 0) == _class ) exitwith {
				_price = _x select 1;
			};
			nil
		} count _prices;

		_total = _total + (_price * _count);
		
	} forEach (_items select 0);
} count [
	getWeaponCargo _box,
	getMagazineCargo _box,
	getItemCargo _box
];

_total