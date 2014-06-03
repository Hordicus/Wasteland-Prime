diag_log format['persistanceEventHandler: %1', _this];

if ( 'PVAR_requestSave' call BL_fnc_shouldRun ) then {
	private ["_veh","_index","_dbID"];
	_veh =  _this select 0;

	if ( [_veh] call BL_fnc_databaseId > -1 ) then {
		if ( !alive _veh ) then {
			[_veh] call BL_fnc_deleteVehicleDB;
		}
		else {
			[_veh, 60] call BL_fnc_queueSaveVehicle;
		};
	};
};