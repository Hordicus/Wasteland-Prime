private ["_veh","_position","_veh","_v","_dir"];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_position = [_this, 1, [0,0,0], [[]], [3, 2]] call BIS_fnc_param;
_dir = [_this, 2, random 359, [0]] call BIS_fnc_param;

if ( count _position == 2 ) then {
	_position set [2, 0];
};

_veh enableSimulation true;
_veh allowDamage false;
_veh setDir _dir;
_veh setPosATL _position;
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
	if ( isNil {_this getVariable 'originalSpawnPoint'} ) then {
		_this setVariable ['originalSpawnPoint', getPosATL _this];
	};
	
	[_this] call BL_fnc_simulationManager;
};

_veh