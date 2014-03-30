"PVAR_requestSave" addPublicVariableEventHandler {
	_requestedBy = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_obj         = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	_returnDone  = [_this select 1, 2, false, [false]] call BIS_fnc_param;
	
	if ( !isPlayer _requestedBy ) exitwith{};
	
	[] call {
		if ( _obj isKindOf "Man" ) exitwith{
			[_obj] call BL_fnc_savePlayer;
		};
		
		if ( _obj isKindOf "LandVehicle" || _obj isKindOf "Air" ) exitwith{
			// No manual save of vehicles atm
		};
		
		if ( [_obj] call LOG_fnc_objectSize != -1 ) exitwith{
			if ( _obj getVariable ['objectLocked', false] ) then {
				[_obj] call BL_fnc_saveVehicle;
			}
			else {
				[_obj] call BL_fnc_deleteVehicle;
			};
		};
	};
	
	if ( _returnDone ) then {
		PVAR_requestSaveDone = true;
		(owner _requestedBy) publicVariableClient "PVAR_requestSaveDone";
	};
};