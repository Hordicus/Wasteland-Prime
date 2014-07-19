BL_PVAR_baseFlags = missionNamespace getVariable ['BL_PVAR_baseFlags', []];

["PVAR_createBaseFlag", "PVAR_createBaseFlag", {
	_player   = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_location = [_this select 1, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	
	if ( !isPlayer _player ) exitwith{};
	
	[getPlayerUID _player, _location] call BL_fnc_createBaseFlag;
}] call BL_fnc_addPublicVariableEventHandler;

["PVAR_destroyBaseFlag", "PVAR_destroyBaseFlag", {
	_player   = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_flag     = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	
	if ( !isPlayer _player || isNull _flag ) exitwith{};
	
	// Delete object
	[_flag] call BL_fnc_deleteVehicleDB;
	deleteVehicle _flag;
	
	// Remove from PVAR
	{
		if ( _x select 3 == _flag ) exitwith{
			BL_PVAR_baseFlags set [_forEachIndex, "REMOVE"];
		};
	} forEach BL_PVAR_baseFlags;
	
	[getPosATL _flag, 'baseFlagRadar'] call BL_fnc_removeRadarLoc;
	[getPosATL _flag, 'baseFlagBlock'] call BL_fnc_removeRadarLoc;
	
	BL_PVAR_baseFlags = BL_PVAR_baseFlags - ["REMOVE"];
	publicVariable "BL_PVAR_baseFlags";
}] call BL_fnc_addPublicVariableEventHandler;

// Update clients when a player disconnects or connects
['onPlayerDisconnected', {
	['updateBaseFlags'] call CBA_fnc_globalEvent;
}] call CBA_fnc_addEventHandler;

['initPlayerServer', {
	['updateBaseFlags'] call CBA_fnc_globalEvent;
}] call CBA_fnc_addEventHandler;

['baseFlag', [
	{(_this select 0) getVariable 'ownerUID'},
	{
		_obj = _this select 0;
		_obj setVariable ['ownerUID', _this select 1];
		[_this select 1, getPosATL _obj, _obj] call BL_fnc_createBaseFlag;
	}
]] call BL_fnc_persRegisterTypeHandler;