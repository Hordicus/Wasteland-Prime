diag_log format['fn_deleteVehicleDB: %1', _this];
private ['_veh', '_id'];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

if ( !isNil {_veh getVariable 'PERS_type'} ) then {
	_id  = _veh getVariable ['PERS_id', -1];

	_veh setVariable ['PERS_id', -1, true];	
	if ( _id != -1 ) then {
		["DELETE FROM `vehicles` WHERE `id` = %1", [_id]] call BL_fnc_MySQLGroupCommand;
	};
};