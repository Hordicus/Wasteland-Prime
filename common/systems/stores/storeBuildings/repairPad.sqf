private ['_location', '_direction', '_pad', '_trg'];
_location = _this select 0;
_direction = _this select 1;

_pad = createVehicle['Land_HelipadCircle_F', _location, [], 0, "CAN_COLLIDE"];
_pad setDir _direction;

_trg = createTrigger ["EmptyDetector", getPosATL _pad];

[_pad] call BL_fnc_trackVehicle;

objNull