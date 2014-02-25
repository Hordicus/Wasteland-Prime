private ["_cities","_city","_vehicles","_vehicle","_vehPos","_spawnPos","_distance","_direction"];

// Select city to spawn in
_cities = call compile preprocessFileLineNumbers 'common\functions\findCities.sqf';
_city = _cities select floor random count _cities;

// Select vehicle to spawn them near
_vehicles = (_city select 1) nearEntities ['Car', _city select 2];
_vehicle = _vehicles select floor random count _vehicles;
_vehPos = getPosATL _vehicle;

_spawnPos = [];
while { count _spawnPos == 0 } do { // findEmptyPosition can fail
	// Random spot within 20m of vehicle
	_distance = random 20;
	_direction = random 360;
	_spawnPos = [_vehPos, _distance, _direction] call BIS_fnc_relPos;
	
	_spawnPos = _spawnPos findEmptyPosition [0, 5];
};

[_city select 0, _spawnPos]