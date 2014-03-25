private ['_loc', '_nearestDistance', '_nearestCity'];
_loc = _this select 0;
_nearestDistance = 100000;
_nearestCity = [];

{
	if ( _loc distance _x < _nearestDistance ) then {
		_nearestCity = _x;
		_nearestDistance = _loc distance _x;
	};
} count entities "LocationCityCapital_F";

(_nearestCity call BL_fnc_cityInfo)