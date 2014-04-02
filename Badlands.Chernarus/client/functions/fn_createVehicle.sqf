private ["_class","_position","_cbArgs","_cb"];
_class    = [_this, 0, "", [""]] call BIS_fnc_param;
_position = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_type     = [_this, 2, "veh", [""]] call BIS_fnc_param;
_cbArgs   = [_this, 3, [], [[]]] call BIS_fnc_param;
_cb       = [_this, 4, {}, [{}]] call BIS_fnc_param;
_special  = [_this, 5, "CAN_COLLIDE", [""]] call BIS_fnc_param;

PVAR_createVehicle = [player, _class, _position, _type, _special];
publicVariableServer "PVAR_createVehicle";

[_cbArgs, _cb] spawn {
	PVAR_createVehicleResponse = nil;
	waitUntil {!isNil "PVAR_createVehicleResponse"};
	
	[PVAR_createVehicleResponse, _this select 0] call (_this select 1);
};