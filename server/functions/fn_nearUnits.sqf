private ["_pos", "_men", "_vehicles", "_animals", "_radius"];

_pos      = _this select 0;
_radius   = _this select 1;
_men      = _pos nearEntities ["Man", _radius];
_vehicles = _pos nearEntities [["Air", "Car"], _radius];
_animals  = _pos nearEntities ["Animal", _radius];
_men      = _men - _animals; // Why are Animals of type Man?

{
	_crew = crew _x;
	_men = _men + _crew;
} count _vehicles;

_men