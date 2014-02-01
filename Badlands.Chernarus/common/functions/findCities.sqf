private ["_locations", "_cities", "_pos", "_name", "_radius"];

_locations = entities "LocationCityCapital_F";
_cities = [];

{
	_pos = position _x;
	_name = _x getVariable ["name", ""];
	_radius = _x getVariable "radius";
	
	if ( _name == "" ) then {
		_name = text ((nearestLocations [_pos, ["NameCityCapital", "nameCity", "NameVillage"], 500]) select 0);
	};
	
	_cities set [ count _cities, [_name, [_pos select 0, _pos select 1], _radius] ];
} count _locations;

_cities