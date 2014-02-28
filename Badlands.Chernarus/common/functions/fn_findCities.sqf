private ["_locations", "_cities", "_pos", "_name", "_radius"];

_locations = entities "LocationCityCapital_F";
_cities = [];

{
	_cities set [ count _cities, _x call BL_fnc_cityInfo ];
} count _locations;

_cities