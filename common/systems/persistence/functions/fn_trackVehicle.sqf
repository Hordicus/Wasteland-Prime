private ["_veh","_type","_index","_id"];
_veh   = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_type  = [_this, 1, "veh", [""]] call BIS_fnc_param;
_id  = [_this, 2, -1, [0]] call BIS_fnc_param;

_index = count PERS_trackedObjectsNetIDs;
PERS_trackedObjectsNetIDs set [_index, netId _veh];

if ( _id >= 0 ) then {
	PERS_trackedObjectsIDs set [_index, _id];
}
else {
	PERS_trackedObjectsIDs set [_index, nil];
};

if ( isServer ) then {
	{
		(_x select 0) publicVariableClient "PERS_trackedObjectsNetIDs";
		(_x select 0) publicVariableClient "PERS_trackedObjectsIDs";
	} count BL_HCs;
}
else {
	publicVariableServer "PERS_trackedObjectsNetIDs";
	publicVariableServer "PERS_trackedObjectsIDs";
};

_veh setVariable ['PERS_type', _type, true];

_veh