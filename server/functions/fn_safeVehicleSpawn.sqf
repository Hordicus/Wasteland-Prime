private ["_class","_position","_veh","_v","_dir"];
_class = [_this, 0, "", [""]] call BIS_fnc_param;
_position = [_this, 1, [0,0,0], [[]], [3, 2]] call BIS_fnc_param;
_dir = [_this, 2, random 359, [0]] call BIS_fnc_param;

_veh = createVehicle [_class, _position, [], 0, "CAN_COLLIDE"];
_veh allowDamage false;
_veh setDir _dir;
_veh setVelocity [0, 0, 1];

// Car might be flying...
// Once it's done turn dmg back on.
_veh spawn {
	while { true } do {
		sleep 1;
		_v = velocity _this;
		
		if ( _v select 0 == 0 && _v select 1 == 0 && _v select 2 == 0 ) exitwith {};
	};
	_this setDamage 0;
	_this allowDamage true;
	_this setVariable ['originalSpawnPoint', getPosATL _this];
};

_veh