private ["_pos", "_men", "_vehicles", "_animals", "_radius"];

_pos      = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_radius   = [_this, 1, 5, [0]] call BIS_fnc_param;
_men      = _pos nearEntities ["Man", _radius];
_vehicles = _pos nearEntities [["Air", "Car"], _radius];
_animals  = _pos nearEntities ["Animal", _radius];
_men      = _men - _animals; // Why are Animals of type Man?

{
	_crew = crew _x;
	_men = _men + _crew;
} count _vehicles;

_men