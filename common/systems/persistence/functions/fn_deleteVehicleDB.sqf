private ['_veh', '_index'];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_index = PERS_trackedObjectsNetIDs find (netId _veh);
if ( _index != -1 ) then {
	_id  = PERS_trackedObjectsIDs select _index;

	PERS_trackedObjectsIDs set [_index, nil];
	if ( isServer ) then {
		{
			(_x select 0) publicVariableClient "PERS_trackedObjectsIDs";
		} count BL_HCs;
	}
	else {
		publicVariableServer "PERS_trackedObjectsIDs";
	};
	
	if ( !isNil "_id" ) then {
		["DELETE FROM `vehicles` WHERE `id` = %1", [_id]] call BL_fnc_MySQLGroupCommand;
	};
};