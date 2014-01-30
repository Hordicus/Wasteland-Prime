private ["_center", "_locations", "_cities", "_pos"];

_center = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_locations = nearestLocations [_center, ["NameCityCapital", "nameCity", "NameVillage"], 100000];
_cities = [];

{
	_pos = locationPosition _x;
	_radius = (size _x) select 0;
	
	// The mission can override world using Logic -> Locations -> City
	_override = _pos nearEntities ["LocationCityCapital_F", _radius];
	
	if ( count _override > 0) then {
		_pos = getPosATL _override;
		_radius = _override getVariable ['radius', _radius];
	};
	

	_cities set [ count _cities, [text _x, [_pos select 0, _pos select 1], _radius] ];
} forEach _locations;

_cities