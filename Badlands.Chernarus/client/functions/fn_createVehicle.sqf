private ["_class","_position","_cbArgs","_cb"];
_class    = [_this, 0, "", [""]] call BIS_fnc_param;
_position = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_cbArgs   = [_this, 2, [], [[]]] call BIS_fnc_param;
_cb       = [_this, 3, {}, [{}]] call BIS_fnc_param;

PVAR_createVehicle = [player, _class, _position];
publicVariableServer "PVAR_createVehicle";

[_cbArgs, _cb] spawn {
	PVAR_createVehicleResponse = nil;
	waitUntil {!isNil "PVAR_createVehicleResponse"};
	
	[PVAR_createVehicleResponse, _this select 0] call (_this select 1);
};