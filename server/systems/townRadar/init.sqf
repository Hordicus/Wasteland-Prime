_cities = call BL_fnc_findCities;
{
	[_x select 1, _x select 2, "radarUpdate", [_x select 0, [_x select 1, _x select 2]]] call BL_fnc_registerLocWithRadar;
} count _cities;