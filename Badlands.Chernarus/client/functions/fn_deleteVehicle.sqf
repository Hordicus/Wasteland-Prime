private ["_obj","_cbArgs","_cb"];
_obj    = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_cbArgs   = [_this, 3, [], [[]]] call BIS_fnc_param;
_cb       = [_this, 4, {}, [{}]] call BIS_fnc_param;

PVAR_deleteVehicle = [player, _obj];
publicVariableServer "PVAR_deleteVehicle";

[_cbArgs, _cb] spawn {
	PVAR_deleteVehicleResponse = nil;
	waitUntil {!isNil "PVAR_deleteVehicleResponse"};
	
	[PVAR_deleteVehicleResponse, _this select 0] call (_this select 1);
};