private ["_veh","_type","_index"];
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

_veh setVariable ['PERS_type', _type];

_veh addEventHandler ['Put', BL_fnc_persistanceEventHandler];
_veh addEventHandler ['Take', BL_fnc_persistanceEventHandler];
_veh addEventHandler ['Dammaged', BL_fnc_persistanceEventHandler];

if ( _veh isKindOf 'LandVehicle' || _veh isKindOf 'Air' ) then {
	_veh addEventHandler ['Fired', BL_fnc_persistanceEventHandler];
	_veh addEventHandler ['GetIn', BL_fnc_persistanceEventHandler];
	_veh addEventHandler ['GetOut', BL_fnc_persistanceEventHandler];
};

_veh setVariable ['lastSave', time];
_veh setVariable ['lastSavePos', getPosATL _veh];

_veh