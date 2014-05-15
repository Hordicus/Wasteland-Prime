#include "\x\bl_server\addons\performance.sqf"
"PVAR_requestSave" addPublicVariableEventHandler {
	PERF_START("requestSave");
	_requestedBy = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_obj         = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	_returnDone  = [_this select 1, 2, false, [false]] call BIS_fnc_param;
	_extra       = [_this select 1, 3, [], [[]]] call BIS_fnc_param;
	
	if ( !isPlayer _requestedBy || isNull _obj ) exitwith{};
	
	[] call {
		if ( _obj isKindOf "Man" ) exitwith{
			[_obj, _extra] call BL_fnc_savePlayer;
		};
		
		if ( _obj getVariable ['PERS_type', 'veh'] == 'basePart' && !(_obj getVariable ['objectLocked', false])) then {
			[_obj] call BL_fnc_deleteVehicleDB;
		}
		else {
			[_obj] call BL_fnc_queueSaveVehicle;
		};
	};
	
	if ( _returnDone ) then {
		PVAR_requestSaveDone = true;
		(owner _requestedBy) publicVariableClient "PVAR_requestSaveDone";
	};
	PERF_STOP("requestSave", true);
};