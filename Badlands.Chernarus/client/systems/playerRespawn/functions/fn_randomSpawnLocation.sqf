/* ----------------------------------------------------------------------------
Function: BL_fnc_randomSpawnLocation

Description:
	Selects a random safe location near a vehicle in a city.
	Optionally can select a random city too.

Parameters:
	_restrictCity - city to spawn in [name, position, radius] (Default: Random selection)

Returns:
	position

---------------------------------------------------------------------------- */

private ["_cities","_city","_vehicles","_vehicle","_vehPos","_spawnPos","_distance","_direction","_attempts"];

// Select city to spawn in
_cities = call BL_fnc_findCities;
_vehPos = [];
_restrictCity = [_this, 0, [], [[]]] call BL_fnc_param;
_attempts = 0;

while { count _vehPos == 0 && _attempts < 10 } do {
	_city = [];
	if ( count _restrictCity == 0 ) then {
		// Select random city if one wasn't provided
		_city = _cities select floor random count _cities;
	}
	else {
		_city = _restrictCity;
	};

	// Select vehicle to spawn them near
	_vehicles = (_city select 1) nearEntities ['Car', _city select 2];
	
	if ( count _vehicles > 0 ) then {
		_vehicle = _vehicles select floor random count _vehicles;
		_vehPos = getPosATL _vehicle;
	}
	else {
		if ( count _restrictCity > 0 ) then {
			_vehPos = [_city select 1, random (_city select 2), random 359] call BIS_fnc_relPos;
		};
	};
	
	_attempts = _attempts + 1;
};

// Fallback if no vehicles were found
if ( count _vehPos == 0 ) then {
	_city = _cities select floor random count _cities;
	_vehPos = [_city select 1, random (_city select 2), random 359] call BIS_fnc_relPos;
};

_spawnPos = [];
while { count _spawnPos == 0 } do { // findEmptyPosition can fail
	// Random spot within 20m of vehicle
	_distance = random 20;
	_direction = random 360;
	_spawnPos = [_vehPos, _distance, _direction] call BIS_fnc_relPos;
	
	_spawnPos = _spawnPos findEmptyPosition [0, 5];
};

[_city select 0, _spawnPos]