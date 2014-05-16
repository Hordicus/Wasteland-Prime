/*
	Description:
	Gets name, position and radius from LocationCityCapital_F
*/

private ["_city","_loc","_cityName","_radius"];
_city = _this;

_loc = getPosATL _city;
_cityName = _city getVariable ["name", ""];
_radius = _city getVariable "radius";

if ( _cityName == "" ) then {
	_cityName = text ((nearestLocations [_loc, ["NameCityCapital", "nameCity", "NameVillage"], 500]) select 0);
};

[_cityName, [_loc select 0, _loc select 1], _radius]