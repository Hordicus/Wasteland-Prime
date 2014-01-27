_center = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_locations = nearestLocations [_center, ["NameCityCapital", "nameCity", "NameVillage"], 100000];
_cities = [];

{
	_pos = locationPosition _x;
	_cities set [ count _cities, [text _x, [_pos select 0, _pos select 1], (size _x) select 0] ];
} forEach _locations;

_cities