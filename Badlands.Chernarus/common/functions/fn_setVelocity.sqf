private ['_obj', '_vel'];
_obj = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_vel = [_this, 1, [0,0,0], [[]], [3]] call BIS_fnc_param;

if ( local _obj ) then {
	_obj setVelocity _vel;
}
else {
	[_this, "BL_fnc_setVelocity", _obj] call BIS_fnc_MP;
};