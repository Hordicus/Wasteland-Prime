["PVAR_requestSave", "PVAR_requestSave", {
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
			if ( _obj getVariable ['PERS_type', 'veh'] == 'basePart' && count _extra == 3 ) then {
				_obj setVectorUp _extra;
			};
		
			[_obj] call BL_fnc_queueSaveVehicle;
		};
	};
	
	if ( _returnDone ) then {
		PVAR_requestSaveDone = true;
		[_requestedBy, "PVAR_requestSaveDone"] call BL_fnc_publicVariableClient;
	};
}] call BL_fnc_addPublicVariableEventHandler;