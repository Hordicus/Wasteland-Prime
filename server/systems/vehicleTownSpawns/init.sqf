#define DEBUG_MODE_FULL
#include "\x\cba\addons\main\script_macros_common.hpp"
_cities = call findCities;
_config = call compile preprocessFileLineNumbers "server\systems\vehicleTownSpawns\config.sqf";
_vehicles = [_config, "vehicles"] call CBA_fnc_hashGet;
_classes = [];

{
	_classes set [count _classes, _x select 0];
} forEach _vehicles;

while { true } do {
	{
		_cityCenter = _x select 1;
		_cityRadius = _x select 2;
		_sqMeters   = (PI * _cityRadius^2);
	
		_currentCount = count (_cityCenter nearEntities [_classes, _cityRadius*2]);
		_maxCount = round (_sqMeters / 8000);
		_searchDistance = 5;
		
		// Bring vehicle count up to max count
		for "_i" from 1 to ( _maxCount - _currentCount ) do {
			_pos = [];
			_class = _vehicles select (floor random count _vehicles) select 0;
			
			while { count _pos == 0 } do {
				_distance = random _cityRadius - _searchDistance;
				_direction = random 360;
				
				_pos = [_cityCenter, _distance, _direction] call BIS_fnc_relPos;
				_nearCars = _pos nearEntities ["Car", 20];
				
				if ( count _nearCars == 0 ) then {
					_pos = _pos findEmptyPosition [0, _searchDistance, _class];
				}
				else {
					_pos = [];
				};
			};
			
			_veh = createVehicle [_class, [random -1000, random -1000, random 1000], [], 0, "CAN_COLLIDE"];
			_veh setDir (random 360);
			_veh allowDamage false;
			_veh setPos _pos;
			_veh setVelocity [1, 0, 0];

			_veh spawn {
				while { true } do {
					sleep 1;
					_v = velocity _this;
					
					if ( _v select 0 == 0 && _v select 1 == 0 && _v select 2 == 0 ) exitwith {};
				};
				_this allowDamage true;
			};
		};
	
	} forEach _cities;

	sleep 5;
};

/*
// Run in console to put X over every vehicle in a town.
// Helpful for testing.
addMissionEventHandler ["Draw3D", {
	_city   = nearestLocations [(position player), ["NameCityCapital", "nameCity", "NameVillage"], 100] select 0;
	_center = locationPosition _city;
	_radius = (size _city) select 0;
	_cars   = _center nearEntities ["Car", _radius*2];
	
	{
		drawIcon3D ["\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa", [1,0,0,1], getPosATL _x, 1, 1, 0, "", 0, 0.03, "PuristaMedium"];		
	} forEach _cars;
}];
*/