_loc = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_nearest = ((_loc nearEntities['LocationCityCapital_F', 20000]) select 0);

(_nearest call BL_fnc_cityInfo)